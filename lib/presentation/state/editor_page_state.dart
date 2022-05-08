import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/data/services/dataBase_services.dart';
import 'package:photo_album/presentation/custom_widgets/back_image_substitution_dialog.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/redactor_page_element.dart';
import 'package:photo_album/presentation/state/base_provider.dart';
import 'package:photo_album/presentation/utils/ui_models/editor_page_model.dart';
import 'package:printing/printing.dart' as printing;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class RedactorPageState extends BaseProvider {
  RedactorPageState() {
    albumModel = AlbumModel(
      pages: [],
      cover: AlbumCover(title: '', downloadLink: '', localPath: ''),
      title: DateFormat('yyyy_MM_dd_hh_MM_ss').format(DateTime.now()),
      type: '',
      heightInch: 25,
      heightCm: 25,
      widthCm: 25,
      widthInch: 25,
    );
    selectedPage = EditorPage(elements: []);
  }
  List<EditorPage> pages = [];
  late AlbumModel albumModel;
  late EditorPage selectedPage;
  AlbumDecoration? selectedElement;
  List<AlbumDecoration> albumBackImages = List<AlbumDecoration>.empty(growable: true);
  ScreenshotController screenshotController = ScreenshotController();

  bool fabIsVisible = true;
  bool screenshotInProgress = false;

  void setAlbumBacks(List<AlbumDecoration> backs) {
    albumBackImages = backs;
    notifyListeners();
  }

  void setAlbumModel(AlbumModel albumModel) {
    this.albumModel = albumModel;
    notifyListeners();
  }

  void addEditorPage(EditorPage page) {
    pages.add(page);
    notifyListeners();
  }

  void setSelectedPage(EditorPage page) {
    selectedPage = page;
    notifyListeners();
  }

  void setScreenshotInProgress(bool val) {
    screenshotInProgress = val;
    notifyListeners();
  }

  Future<void> captureAndSave() async {
    final pdfDoc = pw.Document();
    for (final page in pages) {
      setSelectedPage(page);
      setScreenshotInProgress(true);

      final screenshot = await screenshotController.capture(delay: Duration(milliseconds: 10));
      final pdfImageProvider = await printing.flutterImageProvider(Image.memory(screenshot!).image);
      setScreenshotInProgress(false);

      pdfDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(PdfPageFormat.cm * 25, PdfPageFormat.cm * 25),
          build: (context) => pw.Image(pdfImageProvider, fit: pw.BoxFit.cover),
        ),
      );
    }
    final bytes = await pdfDoc.save();
    await FileSaver.instance.saveFile('${DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now())}', bytes, 'pdf');
  }

  Future<void> captureAndShare() async {
    final pdfDoc = pw.Document();
    for (final page in pages) {
      setSelectedPage(page);
      setScreenshotInProgress(true);
      final screenshot = await screenshotController.capture(delay: Duration(milliseconds: 10));
      final pdfImageProvider = await printing.flutterImageProvider(Image.memory(screenshot!).image);
      setScreenshotInProgress(false);
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
    await Share.shareFiles([document.path], text: 'Смотри что я смог сделать в Screenlife');
  }

  void onPhotoModified({required AlbumDecoration currentElement, required String newPath}) {
    final index = selectedPage.elements.indexOf(currentElement);
    if (index.isNegative) return;
    selectedPage.elements[index] = currentElement.copyWith(localPath: newPath);
    notifyListeners();
  }

  void onPhotoCropped({required AlbumDecoration currentElement, required CropData newFileData}) {
    final index = selectedPage.elements.indexOf(currentElement);
    if (index.isNegative) return;
    selectedPage.elements[index] = currentElement.copyWith(
      localPath: newFileData.file.path,
      width: newFileData.dimensions.width,
      height: newFileData.dimensions.height,
    );
    notifyListeners();
  }

  void onPhotoResized({required Size newSize, required AlbumDecoration currentElement}) {
    final index = selectedPage.elements.indexOf(currentElement);
    if (index.isNegative) return;
    selectedPage.elements[index] = currentElement.copyWith(width: newSize.width, height: newSize.height);
    notifyListeners();
  }

  void onPhotoDeleted({required AlbumDecoration currentElement}) {
    selectedPage.elements.remove(currentElement);
    notifyListeners();
  }

  void onPhotoDragged({required AlbumDecoration currentElement, required Offset offset}) {
    final elementIndex = selectedPage.elements.indexOf(currentElement);
    if (elementIndex.isNegative) return;
    selectedPage.elements[elementIndex] = currentElement.copyWith(x: currentElement.x + offset.dx, y: currentElement.y + offset.dy);
    selectedElement = currentElement;
    notifyListeners();
  }

  void setFabIsVisible(bool value) {
    fabIsVisible = value;
    notifyListeners();
  }

  Future<void> onElementAdded({required BuildContext context, dynamic value}) async {
    if (value is String) {
      if (selectedPage.backImage == null) {
        selectedPage.backImage = CachedNetworkImage(imageUrl: value, fit: BoxFit.fitWidth);
        notifyListeners();
      } else {
        showDialog(
          context: context,
          builder: (context) => BackImageSubstitutionConfirmationDialog(
            onCancel: () {
              final newPage = EditorPage(elements: [], backImage: CachedNetworkImage(imageUrl: value, fit: BoxFit.fitWidth));
              addEditorPage(newPage);
              setSelectedPage(newPage);
            },
            onConfirm: () {
              selectedPage.backImage = CachedNetworkImage(imageUrl: value, fit: BoxFit.fitWidth);
              notifyListeners();
            },
          ),
        );
      }
    } else if (value is AlbumDecoration) {
      selectedPage.elements.add(value);
      selectedElement = value;
      notifyListeners();
    } else if (value is AlbumCover) {
      albumModel = albumModel.copyWith(cover: value);
      notifyListeners();
    }
    setFabIsVisible(true);
    await DataBaseService.instance.editAlbum(albumModel);
  }
}
