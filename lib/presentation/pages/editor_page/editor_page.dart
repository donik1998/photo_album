import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_album/data/models/album_model.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/data/services/dataBase_services.dart';
import 'package:photo_album/presentation/custom_widgets/back_image_substitution_dialog.dart';
import 'package:photo_album/presentation/custom_widgets/sheets/album_back_sheet.dart';
import 'package:photo_album/presentation/custom_widgets/sheets/elements_sheet.dart';
import 'package:photo_album/presentation/pages/editor_page/photo_editor_page.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/redactor_page_element.dart';
import 'package:photo_album/presentation/state/editor_page_state.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/app_runtime_notifier.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RedactorPage extends StatefulWidget {
  RedactorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RedactorPage> createState() => _RedactorPageState();
}

class _RedactorPageState extends State<RedactorPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final state = context.read<RedactorPageState>();
      final args = ModalRoute.of(context)!.settings.arguments as RedactorPageArgs;
      if (args.localAlbum != null) {
        state.setAlbumModel(args.localAlbum!);
        if (args.localAlbum!.pages.isNotEmpty) {
          state.setSelectedPage(args.localAlbum!.pages.first);
          if (args.localAlbum!.pages.first.decorations.isNotEmpty) {
            state.setSelectedElement(args.localAlbum!.pages.first.decorations.first);
          }
        }
      }
      if (args.localAlbum == null) {
        if (args.backImage != null) {
          final newPage = AlbumPage(decorations: [], background: args.backImage!);
          state.setAlbumModel(state.albumModel.copyWith(pages: [newPage]));
          state.setSelectedPage(newPage);
        }
        await DataBaseService.instance.saveAlbumToDB(state.albumModel);
      }
      if (args.openElementsSheetFirst)
        _showBottomSheet(
          context: context,
          albumPageTemplateCategories: args.albumPageTemplateCategories,
          decorationCategories: args.decorationCategories,
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RedactorPageArgs;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 64),
        child: Consumer<RedactorPageState>(
          builder: (context, state, child) => AppBar(
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: SvgPicture.asset('assets/svgs/download.svg'),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => SizedBox(width: 100, height: 100, child: Center(child: CircularProgressIndicator())),
                  );
                  state.captureAndSave().then((value) => Navigator.pop(context));
                },
              ),
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => SizedBox(width: 100, height: 100, child: Center(child: CircularProgressIndicator())),
                  );
                  state.captureAndShare().then((value) => Navigator.pop(context));
                },
                icon: SvgPicture.asset('assets/svgs/share.svg'),
              ),
              IconButton(
                onPressed: () {
                  AppRuntimeNotifier.instance
                      .showCustomBottomSheet(
                    context: context,
                    sheet: AlbumBackSheet(
                      backImages: args.albumBacks,
                      onSelected: (back) {
                        Navigator.pop(context);
                        state.setAlbumModel(state.albumModel.copyWith(cover: AlbumCover.fromMap(back.toMap)));
                      },
                    ),
                  )
                      .then((value) async {
                    await DataBaseService.instance.editAlbum(state.albumModel);
                  });
                },
                icon: SvgPicture.asset('assets/svgs/switch_back.svg'),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<RedactorPageState>(
          builder: (context, state, child) => Screenshot(
            controller: state.screenshotController,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (state.albumModel.cover.localPath.isNotEmpty)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.file(File(state.albumModel.cover.localPath), fit: BoxFit.fill),
                  ),
                if (state.albumModel.cover.downloadLink.isNotEmpty)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CachedNetworkImage(imageUrl: state.albumModel.cover.downloadLink, fit: BoxFit.fill),
                  ),
                if (state.selectedPage.background.downloadLink.isNotEmpty)
                  Container(
                    margin: AppInsets.horizontalInsets16,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(imageUrl: state.selectedPage.background.downloadLink),
                  ),
                for (final element in state.selectedPage.decorations)
                  Positioned(
                    top: element.y,
                    left: element.x,
                    child: RedactorPageElement(
                      decoration: element,
                      hasResizeControls: state.canResizeSelectedElement && state.selectedElement == element,
                      onTapped: () => state.setSelectedElement(element),
                      onResized: (newSize) => state.onPhotoResized(newSize: newSize, currentElement: element),
                      onDragged: (newOffset) => state.onPhotoDragged(currentElement: element, offset: newOffset),
                      dragEnded: () => state.notifyListeners(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer<RedactorPageState>(
        builder: (context, state, child) => Visibility(
          visible: state.fabIsVisible,
          child: FloatingActionButton(
            backgroundColor: AppColors.pinkLight,
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              state.setFabIsVisible(false);
              _showBottomSheet(
                context: context,
                albumPageTemplateCategories: args.albumPageTemplateCategories,
                decorationCategories: args.decorationCategories,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Consumer<RedactorPageState>(
        builder: (context, state, child) => SafeArea(
          minimum: AppInsets.insetsAll16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 56,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: List<Widget>.from(
                      state.albumModel.pages.map(
                        (e) => GestureDetector(
                          onTap: () => state.setSelectedPage(e),
                          child: Container(
                            margin: AppInsets.horizontalInsets16,
                            height: 48,
                            width: 64,
                            decoration: BoxDecoration(
                              color: e == state.selectedPage ? AppColors.white : Colors.transparent,
                              border: Border.all(color: e == state.selectedPage ? AppColors.pinkLight : AppColors.grey, width: 1),
                            ),
                            child: Center(
                              child: Text('${state.albumModel.pages.indexOf(e) + 1}', style: AppTextStyles.smallTitleBold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (state.selectedElement != null) AppSpacing.verticalSpace10,
              if (state.selectedElement != null)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () => state.bringSelectedElementToFront(),
                          child: SvgPicture.asset('assets/svgs/Copy.svg'),
                        ),
                        AppSpacing.horizontalSpace24,
                        GestureDetector(
                          onTap: () => state.onItemDeleted(currentElement: state.selectedElement!),
                          child: SvgPicture.asset('assets/svgs/Delete.svg'),
                        ),
                        AppSpacing.horizontalSpace24,
                        GestureDetector(
                          onTap: () => state.setCanResizeSelectedElement(true),
                          child: Text(
                            'Изменить размер',
                            style: AppTextStyles.smallTitleBold.copyWith(fontSize: 15),
                          ),
                        ),
                        if (state.selectedElement?.isLocal ?? false) AppSpacing.horizontalSpace24,
                        if (state.selectedElement?.isLocal ?? false)
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhotoEditScreen(file: File(state.selectedElement!.localPath)),
                              ),
                            ).then((value) {
                              if (value is String) state.onPhotoModified(currentElement: state.selectedElement!, newPath: value);
                            }),
                            child: Text(
                              'Реадктировать',
                              style: AppTextStyles.smallTitleBold.copyWith(fontSize: 15),
                            ),
                          ),
                        if (state.selectedElement?.isLocal ?? false) AppSpacing.horizontalSpace24,
                        if (state.selectedElement?.isLocal ?? false)
                          GestureDetector(
                            onTap: () async {
                              final newImage = await ImageCropper.platform.cropImage(sourcePath: state.selectedElement!.localPath);
                              if (newImage != null) {
                                final oldItem = state.selectedElement!;
                                state.setSelectedElement(state.selectedElement!.copyWith(localPath: newImage.path));
                              }
                            },
                            child: Text(
                              'Обрезать',
                              style: AppTextStyles.smallTitleBold.copyWith(fontSize: 15),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              AppSpacing.verticalSpace16,
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet({required BuildContext context, required albumPageTemplateCategories, required decorationCategories}) =>
      AppRuntimeNotifier.instance
          .showCustomBottomSheet(
              context: context,
              sheet: ElementsSheet(albumPageTemplateCategory: albumPageTemplateCategories, decorationCategories: decorationCategories))
          .then((value) {
        final state = context.read<RedactorPageState>();
        if (value is String && state.selectedPage.background.downloadLink.isEmpty) {
          state.onBackgroundChanged(value);
        }
        if (value is String && state.selectedPage.background.downloadLink.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => BackImageSubstitutionConfirmationDialog(
              onCancel: () {
                final newPage = AlbumPage(
                  decorations: [],
                  background: AlbumPageBackground(
                    title: '',
                    localPath: '',
                    downloadLink: value,
                  ),
                );
                state.addPage(newPage);
                state.setSelectedPage(newPage);
              },
              onConfirm: () => state.onBackgroundChanged(value),
            ),
          );
        }
        if (value is AlbumDecoration) {
          state.onDecorationAdded(value);
        }
        if (value is AlbumCover) {
          state.setAlbumModel(state.albumModel.copyWith(cover: value));
        }
        state.setFabIsVisible(true);
      });
}
