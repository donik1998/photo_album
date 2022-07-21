import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:photo_album/data/models/album_model.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/data/services/dataBase_services.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/redactor_page_element.dart';
import 'package:photo_album/presentation/state/base_provider.dart';
import 'package:printing/printing.dart' as printing;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class RedactorPageState extends BaseProvider {
  bool canResizeSelectedElement = false;

  RedactorPageState() {
    albumModel = AlbumModel(
      pages: [
        AlbumPage(
          decorations: [],
          background: AlbumPageBackground(
            title: '',
            downloadLink: '',
            localPath: '',
          ),
        ),
      ],
      cover: AlbumCover(title: '', downloadLink: '', localPath: ''),
      title: DateFormat('yyyy_MM_dd_hh_MM_ss').format(DateTime.now()),
      type: '',
      heightInch: 25,
      heightCm: 25,
      widthCm: 25,
      widthInch: 25,
    );
    selectedPage = albumModel.pages.first;
  }

  int fontSize = 12;

  late AlbumModel albumModel;
  late AlbumPage selectedPage;
  AlbumDecoration? selectedElement;
  ScreenshotController screenshotController = ScreenshotController();

  bool fabIsVisible = true;
  bool screenshotInProgress = false;

  bool get inTextEditingMode => selectedElement != null && (selectedElement?.isText ?? false) && canResizeSelectedElement;

  void setFontSize(int size) {
    fontSize = size;
    final pageIndex = albumModel.pages.indexOf(selectedPage);
    final elementIndex = selectedPage.decorations.indexOf(selectedElement!);
    selectedElement = selectedElement!.copyWith(fontSize: size);
    albumModel.pages.elementAt(pageIndex).decorations[elementIndex] = selectedElement!;
    _updateDb();
    notifyListeners();
  }

  void setAlbumModel(AlbumModel albumModel) {
    this.albumModel = albumModel;
    if (this.albumModel.pages.isNotEmpty) setSelectedPage(this.albumModel.pages.first);
    _updateDb();
    notifyListeners();
  }

  void addPage(AlbumPage page) {
    albumModel = albumModel.copyWith(pages: <AlbumPage>[...albumModel.pages, page]);
    _updateDb();
    notifyListeners();
  }

  void setSelectedPage(AlbumPage page) {
    selectedPage = page;
    notifyListeners();
  }

  void setScreenshotInProgress(bool val) {
    screenshotInProgress = val;
    notifyListeners();
  }

  void setSelectedElement(AlbumDecoration element) {
    selectedElement = element;
    notifyListeners();
  }

  void setCanResizeSelectedElement(bool value) {
    canResizeSelectedElement = value;
    notifyListeners();
  }

  Future<void> captureAndSave() async {
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    final pdfDoc = pw.Document();
    for (final page in albumModel.pages) {
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
    await FileSaver.instance.saveAs('${DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now())}', bytes, 'pdf', MimeType.PDF);
  }

  Future<void> captureAndShare() async {
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    final pdfDoc = pw.Document();
    for (final page in albumModel.pages) {
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
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    final index = selectedPage.decorations.indexOf(currentElement);
    if (index.isNegative) return;
    selectedPage.decorations[index] = currentElement.copyWith(localPath: newPath);
    _updateDb();
    notifyListeners();
  }

  void onPhotoCropped({required AlbumDecoration currentElement, required CropData newFileData}) {
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    final index = selectedPage.decorations.indexOf(currentElement);
    if (index.isNegative) return;
    selectedPage.decorations[index] = currentElement.copyWith(
      localPath: newFileData.file.path,
      width: newFileData.dimensions.width,
      height: newFileData.dimensions.height,
      isLocal: true,
    );
    _updateDb();
    notifyListeners();
  }

  void onPhotoResized({required Size newSize, required AlbumDecoration currentElement}) {
    final index = selectedPage.decorations.indexOf(currentElement);
    final pageIndex = albumModel.pages.indexOf(selectedPage);
    if (index.isNegative || pageIndex.isNegative) return;
    selectedPage.decorations[index] = selectedPage.decorations[index].copyWith(width: newSize.width, height: newSize.height);
    albumModel.pages[pageIndex] = selectedPage;
    setSelectedElement(selectedPage.decorations.elementAt(index));
    _updateDb();
    notifyListeners();
  }

  void onItemDeleted({required AlbumDecoration currentElement}) {
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    selectedPage.decorations.remove(currentElement);
    final pageIndex = albumModel.pages.indexOf(selectedPage);
    albumModel.pages[pageIndex] = selectedPage;
    selectedElement = null;
    _updateDb();
    notifyListeners();
  }

  void onPhotoDragged({required AlbumDecoration currentElement, required Offset offset}) {
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    final elementIndex = selectedPage.decorations.indexOf(currentElement);
    if (elementIndex.isNegative) return;
    selectedPage.decorations[elementIndex] = currentElement.copyWith(
      x: currentElement.x + offset.dx,
      y: currentElement.y + offset.dy,
      isText: currentElement.isText,
    );
    selectedElement = selectedPage.decorations[elementIndex];
    _updateDb();
    notifyListeners();
  }

  void setFabIsVisible(bool value) {
    fabIsVisible = value;
    notifyListeners();
  }

  void onBackgroundChanged(String value) {
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    final currentBack = selectedPage.background;
    final pageIndex = albumModel.pages.indexOf(selectedPage);
    final newBack = AlbumPageBackground(
      title: currentBack.title,
      downloadLink: value,
      localPath: currentBack.localPath,
    );
    if (!pageIndex.isNegative) {
      albumModel.pages.removeAt(pageIndex);
      albumModel.pages.insert(
        pageIndex,
        selectedPage.copyWith(background: newBack),
      );
    }
    selectedPage = selectedPage.copyWith(background: newBack);
    _updateDb();
    notifyListeners();
  }

  void onDecorationAdded(AlbumDecoration decoration) async {
    if (decoration.isLocal) {
      final decorationFile = File(decoration.localPath);
      final docDir = await getApplicationDocumentsDirectory();
      final newPath = '${docDir.path}/${decoration.title}';
      final newFile = File(newPath);
      await newFile.writeAsBytes(decorationFile.readAsBytesSync());
      await newFile.create();
      decoration = decoration.copyWith(localPath: newFile.path);
    }
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    final pageIndex = albumModel.pages.indexOf(selectedPage);
    if (!pageIndex.isNegative) {
      albumModel.pages.elementAt(pageIndex).decorations.add(decoration);
    }
    selectedElement = decoration;
    _updateDb();
    notifyListeners();
  }

  void bringSelectedElementToFront() {
    if (canResizeSelectedElement) setCanResizeSelectedElement(false);
    if (selectedPage.decorations.last == selectedElement) return;
    int pageIndex = albumModel.pages.indexOf(selectedPage);
    int itemIndex = albumModel.pages.elementAt(pageIndex).decorations.indexOf(selectedElement!);
    albumModel.pages.elementAt(pageIndex).decorations.removeAt(itemIndex);
    albumModel.pages.elementAt(pageIndex).decorations.add(selectedElement!);
    _updateDb();
    notifyListeners();
  }

  void onTextDecorationEdited(String value) {
    final pageIndex = albumModel.pages.indexOf(selectedPage);
    final elementIndex = selectedPage.decorations.indexOf(selectedElement!);
    selectedElement = selectedElement!.copyWith(title: value);
    albumModel.pages.elementAt(pageIndex).decorations[elementIndex] = selectedElement!;
    _updateDb();
    notifyListeners();
  }

  void changeFontFamily(String value) {
    final pageIndex = albumModel.pages.indexOf(selectedPage);
    final elementIndex = selectedPage.decorations.indexOf(selectedElement!);
    selectedElement = selectedElement!.copyWith(fontFamily: value);
    albumModel.pages.elementAt(pageIndex).decorations[elementIndex] = selectedElement!;
    _updateDb();
    notifyListeners();
  }

  void saveElement({required AlbumDecoration element}) => _updateDb();

  void _updateDb() => DataBaseService.instance.editAlbum(albumModel);

  void onScaled({required AlbumDecoration element}) {
    final pageIndex = albumModel.pages.indexOf(selectedPage);
    final elementIndex = selectedPage.decorations.indexOf(selectedElement!);
    selectedElement = element;
    albumModel.pages.elementAt(pageIndex).decorations[elementIndex] = selectedElement!;
    notifyListeners();
  }
}
