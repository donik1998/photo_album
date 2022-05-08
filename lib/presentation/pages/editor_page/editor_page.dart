import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/data/services/dataBase_services.dart';
import 'package:photo_album/presentation/custom_widgets/sheets/album_back_sheet.dart';
import 'package:photo_album/presentation/custom_widgets/sheets/elements_sheet.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/redactor_page_element.dart';
import 'package:photo_album/presentation/state/editor_page_state.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/app_runtime_notifier.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:photo_album/presentation/utils/ui_models/editor_page_model.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RedactorPage extends StatefulWidget {
  RedactorPage({Key? key}) : super(key: key);

  @override
  State<RedactorPage> createState() => _RedactorPageState();
}

class _RedactorPageState extends State<RedactorPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final state = context.read<RedactorPageState>();
      final backImages = await FirebaseFirestore.instance.collection('decorations').where('type', isEqualTo: 'Фоны альбомов').get();
      state.setAlbumBacks(List<AlbumDecoration>.from(backImages.docs.map((e) => AlbumDecoration.fromMap(e.data()))));
      final args = ModalRoute.of(context)!.settings.arguments as RedactorPageArgs;
      setState(() {
        if (args.album != null) state.setAlbumModel(args.album!);
        state.addEditorPage(EditorPage(elements: [], backImage: args.backImage));
        state.setSelectedPage(state.pages.first);
      });
      if (args.album == null) await DataBaseService.instance.saveAlbumToDB(state.albumModel);
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
                    await DataBaseService.instance.saveAlbumToDB(state.albumModel);
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
                if (state.selectedPage.backImage != null)
                  Container(
                    margin: AppInsets.horizontalInsets16,
                    width: MediaQuery.of(context).size.width,
                    child: state.selectedPage.backImage,
                  ),
                for (final element in state.selectedPage.elements)
                  Positioned(
                    top: element.y,
                    left: element.x,
                    child: RedactorPageElement(
                      hideControls: state.screenshotInProgress,
                      child: element,
                      onEdited: (newPath) => state.onPhotoModified(currentElement: element, newPath: newPath),
                      onCropped: (newFileData) => state.onPhotoCropped(newFileData: newFileData, currentElement: element),
                      onResized: (newSize) => state.onPhotoResized(newSize: newSize, currentElement: element),
                      onDeleted: () => state.onPhotoDeleted(currentElement: element),
                      onDragged: (newOffset) => state.onPhotoDragged(currentElement: element, offset: newOffset),
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
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: List.from(
                state.pages.map(
                  (e) => GestureDetector(
                    onTap: () => state.setSelectedPage(e),
                    child: Container(
                      margin: AppInsets.horizontalInsets16,
                      height: 48,
                      width: 64,
                      decoration: BoxDecoration(
                        color: e == state.selectedPage ? AppColors.white : AppColors.pinkLight.withOpacity(0.5),
                        border: Border.all(color: AppColors.pinkLight, width: 1),
                      ),
                      child: Center(child: Text('${state.pages.indexOf(e) + 1}', style: AppTextStyles.smallTitleBold)),
                    ),
                  ),
                ),
              ),
            ),
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
          .then((value) => context.read<RedactorPageState>().onElementAdded(context: context, value: value));
}
