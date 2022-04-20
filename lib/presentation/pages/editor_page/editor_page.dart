import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/data/services/dataBase_services.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/elements_sheet.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/redactor_page_element.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/theme/different_icons.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:printing/printing.dart' as print;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RedactorPage extends StatefulWidget {
  RedactorPage({Key? key}) : super(key: key);

  @override
  State<RedactorPage> createState() => _RedactorPageState();
}

class _RedactorPageState extends State<RedactorPage> {
  ScrollController scrollController = ScrollController();
  List<EditorPage> _pages = [];
  late AlbumModel albumModel;
  late EditorPage selectedPage;
  DecorationElement? _selectedElement;
  ScreenshotController screenshotController = ScreenshotController();

  bool fabIsVisible = true;
  bool _screenshotInProgress = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {});
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      setState(
        () => albumModel = AlbumModel(
          pages: [],
          cover: AlbumCover(title: '', downloadLink: '', localPath: ''),
          title: '',
          thumbnailPath: '',
          type: '',
          heightInch: 25,
          heightCm: 25,
          widthCm: 25,
          widthInch: 25,
        ),
      );
      DataBaseService.instance.saveAlbumToDB(albumModel);
      final args = ModalRoute.of(context)!.settings.arguments as RedactorPageArgs;
      setState(() {
        _pages.add(EditorPage(elements: [], backImage: args.backImage));
        selectedPage = _pages.first;
      });
      if (args.openElementsSheetFirst)
        _showBottomSheet(
          context: context,
          albumPageTemplateCategories: args.albumPageTemplateCategories,
          decorationCategories: args.decorationCategories,
        );
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RedactorPageArgs;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(CustomIcons.dot_2, color: Color(0xFF2E2E2E), size: 24),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SizedBox(width: 100, height: 100, child: Center(child: CircularProgressIndicator())),
              );
              final pdfDoc = pw.Document();
              for (final page in _pages) {
                setState(() {
                  _screenshotInProgress = true;
                  selectedPage = page;
                });
                final screenshot = await screenshotController.capture(delay: Duration(milliseconds: 10));
                final pdfImageProvider = await print.flutterImageProvider(Image.memory(screenshot!).image);
                setState(() => _screenshotInProgress = false);
                pdfDoc.addPage(
                  pw.Page(
                    pageFormat: PdfPageFormat(PdfPageFormat.cm * 25, PdfPageFormat.cm * 25),
                    build: (context) => pw.Image(pdfImageProvider, fit: pw.BoxFit.cover),
                  ),
                );
              }
              Directory? dir;
              if (Platform.isAndroid) {
                dir = await getExternalStorageDirectory();
              } else if (Platform.isIOS) {
                dir = await getApplicationDocumentsDirectory();
              }
              final bytes = await pdfDoc.save();
              final document = File('${dir?.path}/${DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now())}.pdf');
              document.writeAsBytesSync(bytes);
              await document.create();
              Navigator.pop(context);
              await Share.shareFiles([document.path], text: 'Смотри что я смог сделать в Screenlife');
            },
            icon: Icon(CustomIcons.upload, color: Color(0xFF2E2E2E), size: 24),
          ),
          IconButton(
            onPressed: () {
              if (_selectedElement != null)
                setState(() {
                  selectedPage.elements.removeWhere((element) => element.title == _selectedElement!.title);
                  selectedPage.elements.add(_selectedElement!);
                });
            },
            icon: Icon(CustomIcons.popup, color: Color(0xFF2E2E2E), size: 24),
          ),
        ],
      ),
      body: SafeArea(
        child: Screenshot(
          controller: screenshotController,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (albumModel.cover.localPath.isNotEmpty)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.file(
                    File(albumModel.cover.localPath.isEmpty ? albumModel.cover.downloadLink : albumModel.cover.localPath),
                    fit: BoxFit.cover,
                  ),
                ),
              if (selectedPage.backImage != null)
                Container(
                  margin: AppInsets.horizontalInsets16,
                  width: MediaQuery.of(context).size.width,
                  child: selectedPage.backImage,
                ),
              for (final element in selectedPage.elements)
                Positioned(
                  top: element.y,
                  left: element.x,
                  child: RedactorPageElement(
                    hideControls: _screenshotInProgress,
                    child: element,
                    onCropped: (newFileData) => setState(() {
                      final index = selectedPage.elements.indexOf(element);
                      if (index.isNegative) return;
                      selectedPage.elements[index] = element.copyWith(
                        localPath: newFileData.file.path,
                        width: newFileData.dimensions.width,
                        height: newFileData.dimensions.height,
                      );
                    }),
                    onResized: (newSize) => setState(() {
                      final index = selectedPage.elements.indexOf(element);
                      if (index.isNegative) return;
                      selectedPage.elements[index] = element.copyWith(width: newSize.width, height: newSize.height);
                    }),
                    onDeleted: () => setState(() => selectedPage.elements.remove(element)),
                    onDragged: (newOffset) => setState(() {
                      final elementIndex = selectedPage.elements.indexOf(element);
                      if (elementIndex.isNegative) return;
                      selectedPage.elements[elementIndex] = element.copyWith(x: element.x + newOffset.dx, y: element.y + newOffset.dy);
                      _selectedElement = element;
                    }),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: fabIsVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.pinkLight,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            setState(() => fabIsVisible = false);
            _showBottomSheet(
              context: context,
              albumPageTemplateCategories: args.albumPageTemplateCategories,
              decorationCategories: args.decorationCategories,
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: AppInsets.insetsAll16,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: List.from(
              _pages.map(
                (e) => GestureDetector(
                  onTap: () => setState(() => selectedPage = e),
                  child: Container(
                    margin: AppInsets.horizontalInsets16,
                    height: 48,
                    width: 64,
                    decoration: BoxDecoration(
                      color: e == selectedPage ? AppColors.white : AppColors.pinkLight.withOpacity(0.5),
                      border: Border.all(color: AppColors.pinkLight, width: 1),
                    ),
                    child: Center(child: Text('${_pages.indexOf(e) + 1}', style: AppTextStyles.smallTitleBold)),
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
      showModalBottomSheet(
        context: context,
        elevation: 10,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ElementsSheet(
            controller: scrollController,
            albumPageTemplateCategory: albumPageTemplateCategories,
            decorationCategories: decorationCategories,
          ),
        ),
      ).then((value) {
        if (value is String) {
          if (selectedPage.backImage == null)
            setState(() => selectedPage.backImage = CachedNetworkImage(imageUrl: value, fit: BoxFit.fitWidth));
          else
            showDialog(
              context: context,
              builder: (context) => BackImageSubstitutionConfirmationDialog(
                onCancel: () {
                  setState(() {
                    final newPage = EditorPage(elements: [], backImage: CachedNetworkImage(imageUrl: value, fit: BoxFit.fitWidth));
                    _pages.add(newPage);
                    selectedPage = newPage;
                  });
                },
                onConfirm: () => setState(() {
                  selectedPage.backImage = CachedNetworkImage(imageUrl: value, fit: BoxFit.fitWidth);
                }),
              ),
            );
        } else if (value is DecorationElement) {
          setState(() {
            selectedPage.elements.add(value);
            _selectedElement = value;
          });
        } else if (value is AlbumCover) {
          setState(() {
            albumModel = albumModel.copyWith(cover: value);
          });
        }
        setState(() => fabIsVisible = true);
      });
}

class BackImageSubstitutionConfirmationDialog extends StatelessWidget {
  final VoidCallback onCancel, onConfirm;

  const BackImageSubstitutionConfirmationDialog({
    Key? key,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Похоже что у вас уже есть фоновая картинка. Хотите ее заменить?'),
      actions: [
        TextButton(
          onPressed: () {
            onCancel();
            Navigator.pop(context);
          },
          child: Text('Нет, создать отдельную страницу'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text('Да, заменить фон'),
        ),
      ],
    );
  }
}

class EditorPage {
  final List<DecorationElement> elements;
  Widget? backImage;

  EditorPage({
    required this.elements,
    this.backImage,
  });
}
