import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/elements_sheet.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/redactor_page_element.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/different_icons.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:screenshot/screenshot.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RedactorPage extends StatefulWidget {
  RedactorPage({Key? key}) : super(key: key);

  @override
  State<RedactorPage> createState() => _RedactorPageState();
}

class _RedactorPageState extends State<RedactorPage> {
  ScrollController scrollController = ScrollController();
  List<DecorationElement> elements = List.empty(growable: true);
  DecorationElement? _selectedElement;
  ScreenshotController screenshotController = ScreenshotController();
  Widget? _backImage;
  bool fabIsVisible = true;
  bool _resizeEnabled = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {});
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final args = ModalRoute.of(context)!.settings.arguments as RedactorPageArgs;
      setState(() => _backImage = args.backImage);
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
            icon: Icon(MyFlutterApp.dot_2, color: Color(0xFF2E2E2E), size: 24),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () async {
              Directory? dir;
              if (Platform.isAndroid) {
                dir = await getExternalStorageDirectory();
              } else if (Platform.isIOS) {
                dir = await getApplicationDocumentsDirectory();
              }
              final image = await screenshotController.capture(delay: Duration.zero);
              if (image != null) {
                final imagePath = await File('${dir?.path}/${DateFormat('dd_MM_yyyy_HH_mm_ss')}.png').create();
                await imagePath.writeAsBytes(image);
              }
            },
            icon: Icon(MyFlutterApp.cloud_download, color: Color(0xFF2E2E2E), size: 24),
          ),
          IconButton(
            icon: Icon(MyFlutterApp.upload, color: Color(0xFF2E2E2E), size: 24),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {
              if (_selectedElement != null)
                setState(() {
                  elements.removeWhere((element) => element.title == _selectedElement!.title);
                  elements.add(_selectedElement!);
                });
            },
            icon: Icon(MyFlutterApp.popup, color: Color(0xFF2E2E2E), size: 24),
          ),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_backImage != null)
              Container(
                margin: AppInsets.horizontalInsets16,
                width: MediaQuery.of(context).size.width,
                child: _backImage,
              ),
            for (final element in elements)
              Positioned(
                top: element.y,
                left: element.x,
                child: RedactorPageElement(
                  child: element,
                  hasResizeControls: _resizeEnabled,
                  onCropped: (newFile) => setState(() {
                    final index = elements.indexOf(element);
                    elements.removeAt(index);
                    elements.insert(index, element.copyWith(localPath: newFile.path));
                  }),
                  onScaleDown: () => setState(() {
                    final index = elements.indexOf(element);
                    elements.removeAt(index);
                    elements.insert(index, element.copyWith(width: element.width - 25, height: element.height - 25));
                  }),
                  onScaleUp: () => setState(() {
                    final index = elements.indexOf(element);
                    elements.removeAt(index);
                    elements.insert(index, element.copyWith(width: element.width + 25, height: element.height + 25));
                  }),
                  onDeleted: () => setState(() => elements.remove(element)),
                  onDragged: (newOffset) => setState(() {
                    final renderBox = context.findRenderObject() as RenderBox;
                    Offset off = renderBox.localToGlobal(newOffset);
                    final elementIndex = elements.indexOf(element);
                    elements.removeAt(elementIndex);
                    elements.insert(elementIndex, element.copyWith(x: off.dx, y: off.dy - 80));
                    _selectedElement = element;
                  }),
                ),
              ),
          ],
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
        if (value is String) setState(() => _backImage = CachedNetworkImage(imageUrl: value, fit: BoxFit.fitWidth));
        if (value is DecorationElement) elements.add(value);
        setState(() => fabIsVisible = true);
      });
}
