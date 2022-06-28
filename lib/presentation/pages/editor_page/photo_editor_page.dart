import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_album/data/models/color_filter_model.dart';
import 'package:photo_album/data/models/stacked_widget.dart';
import 'package:photo_album/data/services/file_service.dart';
import 'package:photo_album/presentation/custom_widgets/image_filter.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/blur_selection.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/bottom_bar_widget.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/filter_selection.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:screenshot/screenshot.dart';

class PhotoEditScreen extends StatefulWidget {
  static String tag = '/PhotoEditScreen';
  final File? file;

  PhotoEditScreen({this.file});

  @override
  PhotoEditScreenState createState() => PhotoEditScreenState();
}

class PhotoEditScreenState extends State<PhotoEditScreen> {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey key = GlobalKey<PhotoEditScreenState>();
  final ScrollController scrollController = ScrollController();

  DateTime? currentBackPressTime;

  /// Used to save edited image on storage
  ScreenshotController screenshotController = ScreenshotController();
  final GlobalKey screenshotKey = GlobalKey();
  final GlobalKey imageKey = GlobalKey();

  /// Used to draw on image
  List<Offset> points = [];

  /// Texts on image
  List<StackedWidgetModel> mStackedWidgetList = [];

  /// Image file picked from previous screen
  File? originalFile;
  File? croppedFile;

  double topWidgetHeight = 80, bottomWidgetHeight = 80, blur = 0;

  /// Variables used to show or hide bottom widgets
  bool mIsFilterViewVisible = false;
  bool mIsBlurVisible = false;
  bool mIsFrameVisible = false;
  bool mIsBrightnessSliderVisible = false;
  bool mIsSaturationSliderVisible = false;
  bool mIsHueSliderVisible = false;
  bool mIsContrastSliderVisible = false;
  bool mIsMoreConfigWidgetVisible = true;
  bool mShowBeforeImage = false;
  bool mIsPremium = false;

  /// Selected color filter
  ColorFilterModel? filter;

  double brightness = 0.0, saturation = 0.0, hue = 0.0, contrast = 0.0;

  /// Selected frame
  String? frame;

  double? imageHeight;
  double? imageWidth;

  void setVisibility({
    bool? filterViewVisible,
    bool? blurVisible,
    bool? frameVisible,
    bool? brightnessSliderVisible,
    bool? saturationSliderVisible,
    bool? hueSliderVisible,
    bool? contrastSliderVisible,
  }) {
    if (filterViewVisible != null)
      mIsFilterViewVisible = filterViewVisible;
    else
      mIsFilterViewVisible = false;
    if (blurVisible != null)
      mIsBlurVisible = blurVisible;
    else
      mIsBlurVisible = false;
    if (frameVisible != null)
      mIsFrameVisible = frameVisible;
    else
      mIsFrameVisible = false;
    if (brightnessSliderVisible != null)
      mIsBrightnessSliderVisible = brightnessSliderVisible;
    else
      mIsBrightnessSliderVisible = false;
    if (saturationSliderVisible != null)
      mIsSaturationSliderVisible = saturationSliderVisible;
    else
      mIsSaturationSliderVisible = false;
    if (hueSliderVisible != null)
      mIsHueSliderVisible = hueSliderVisible;
    else
      mIsHueSliderVisible = false;
    if (contrastSliderVisible != null)
      mIsContrastSliderVisible = contrastSliderVisible;
    else
      mIsContrastSliderVisible = false;
    setState(() {});
  }

  @override
  void initState() {
    //saveToDirectory(originalFile);
    WidgetsBinding.instance?.addPostFrameCallback((_) => getImageSize());
    setState(() {});

    super.initState();
    init();

    setStatusBarColor(white);
  }

  Future<void> getImageSize() async {
    await 2.seconds.delay;
    imageHeight = imageKey.currentContext!.size!.height;
    imageWidth = imageKey.currentContext!.size!.width;
    log(imageHeight);
    log(imageWidth);
    if (imageHeight.validate().toInt() == 0) {
      imageHeight = context.height();
    }
    if (imageWidth.validate().toInt() == 0) {
      imageWidth = context.width();
    }
    setState(() {});
  }

  Future<void> init() async {
    originalFile = widget.file;
    croppedFile = widget.file;

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        mIsMoreConfigWidgetVisible = false;
      } else {
        mIsMoreConfigWidgetVisible = true;
      }

      setState(() {});
    });
  }

  Future<String?> capture() async {
    mIsBlurVisible = false;
    mIsFilterViewVisible = false;
    mIsFrameVisible = false;
    mIsBrightnessSliderVisible = false;
    mIsSaturationSliderVisible = false;
    mIsHueSliderVisible = false;
    mIsContrastSliderVisible = false;
    setState(() {});

    final value = await screenshotController.captureAndSave(await getFileSavePath(), delay: 1.seconds);
    return value;
  }

  void onEraserClick() {
    showConfirmDialog(context, 'Это действие удалит все ваши изменения',
            positiveText: 'Продолжить', negativeText: 'Отменить', buttonColor: AppColors.pinkLight)
        .then((value) {
      if (value ?? false) {
        mIsBlurVisible = false;
        mIsFilterViewVisible = false;
        mIsFrameVisible = false;
        mIsBrightnessSliderVisible = false;
        mIsSaturationSliderVisible = false;
        mIsHueSliderVisible = false;
        mIsContrastSliderVisible = false;
        points.clear();

        /// Clear stacked widgets
        mStackedWidgetList.clear();

        /// Clear filter
        filter = null;

        /// Clear blur effect
        blur = 0;

        /// Clear frame
        frame = null;

        /// Clear brightness, contrast, saturation, hue
        brightness = 0.0;
        saturation = 0.0;
        hue = 0.0;
        contrast = 0.0;

        setState(() {});
      }
    }).catchError(log);
  }

  void onBlurClick() {
    mIsFilterViewVisible = false;
    mIsFrameVisible = false;
    mIsBrightnessSliderVisible = false;
    mIsSaturationSliderVisible = false;
    mIsHueSliderVisible = false;
    mIsContrastSliderVisible = false;
    mIsBlurVisible = !mIsBlurVisible;

    setState(() {});
  }

  Future<void> onFilterClick() async {
    mIsFrameVisible = false;
    mIsBlurVisible = false;
    mIsBrightnessSliderVisible = false;
    mIsSaturationSliderVisible = false;
    mIsHueSliderVisible = false;
    mIsContrastSliderVisible = false;
    mIsFilterViewVisible = !mIsFilterViewVisible;
    setState(() {});
  }

  Future<void> onFrameClick() async {
    if (!getBoolAsync('IS_FRAME_REWARDED')) {
      mIsBlurVisible = false;
      mIsFilterViewVisible = false;
      mIsBrightnessSliderVisible = false;
      mIsSaturationSliderVisible = false;
      mIsHueSliderVisible = false;
      mIsContrastSliderVisible = false;
      mIsFrameVisible = !mIsFrameVisible;

      setState(() {});
    } else {
      /*if (rewardedAd != null && await rewardedAd.isLoaded()) {
        rewardedAd.show();

        toast('Showing reward ad');
      }*/
    }
  }

  Future<void> onBrightnessSliderClick() async {
    mIsBlurVisible = false;
    mIsFilterViewVisible = false;
    mIsFrameVisible = false;
    mIsSaturationSliderVisible = false;
    mIsHueSliderVisible = false;
    mIsContrastSliderVisible = false;
    mIsBrightnessSliderVisible = !mIsBrightnessSliderVisible;

    setState(() {});
  }

  Future<void> onSaturationSliderClick() async {
    mIsBlurVisible = false;
    mIsFilterViewVisible = false;
    mIsFrameVisible = false;
    mIsBrightnessSliderVisible = false;
    mIsHueSliderVisible = false;
    mIsContrastSliderVisible = false;
    mIsSaturationSliderVisible = !mIsSaturationSliderVisible;

    setState(() {});
  }

  Future<void> onHueSliderClick() async {
    mIsBlurVisible = false;
    mIsFilterViewVisible = false;
    mIsFrameVisible = false;
    mIsBrightnessSliderVisible = false;
    mIsSaturationSliderVisible = false;
    mIsContrastSliderVisible = false;
    mIsHueSliderVisible = !mIsHueSliderVisible;

    setState(() {});
  }

  Future<void> onContrastSliderClick() async {
    mIsBlurVisible = false;
    mIsFilterViewVisible = false;
    mIsFrameVisible = false;
    mIsBrightnessSliderVisible = false;
    mIsSaturationSliderVisible = false;
    mIsHueSliderVisible = false;
    mIsContrastSliderVisible = !mIsContrastSliderVisible;

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          toast('Press back again to exit from the app');
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: CloseButton(
            onPressed: () {
              showConfirmDialog(context, 'Это действие удалит все ваши изменения',
                      positiveText: 'Продолжить', negativeText: 'Отменить', buttonColor: AppColors.pinkLight)
                  .then((value) {
                if (value ?? false) {
                  Navigator.pop(context);
                }
              });
            },
          ),
          actions: [
            GestureDetector(
              onTapDown: (v) {
                mShowBeforeImage = true;
                setState(() {});
              },
              onTapUp: (v) {
                mShowBeforeImage = false;
                setState(() {});
              },
              onTapCancel: () {
                mShowBeforeImage = false;
                setState(() {});
              },
              child: Icon(Icons.compare_rounded).paddingAll(8),
            ),
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => Center(child: CircularProgressIndicator()),
                );
                final newPath = await capture();
                Navigator.pop(context);
                if (newPath != null) Navigator.pop(context, newPath);
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  /// This widget will be saved as edited Image
                  Screenshot(
                    controller: screenshotController,
                    key: screenshotKey,
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        (filter != null && filter!.matrix != null)
                            ? ColorFiltered(
                                colorFilter: ColorFilter.matrix(filter!.matrix!),
                                child: ImageFilterWidget(
                                  brightness: brightness,
                                  saturation: saturation,
                                  hue: hue,
                                  contrast: contrast,
                                  child: Image.file(croppedFile!, fit: BoxFit.fitWidth),
                                ),
                              )
                            : Stack(
                                alignment: Alignment.center,
                                fit: StackFit.expand,
                                children: [
                                  ImageFilterWidget(
                                    brightness: brightness,
                                    saturation: saturation,
                                    hue: hue,
                                    contrast: contrast,
                                    child: Image.file(croppedFile!, fit: BoxFit.fitWidth, key: imageKey),
                                  ),
                                  if (filter != null && filter!.color != null)
                                    Container(
                                      height: imageHeight,
                                      width: imageWidth,
                                      color: Colors.black12,
                                    ).withShaderMaskGradient(
                                      LinearGradient(colors: filter!.color!, begin: Alignment.topLeft, end: Alignment.bottomRight),
                                      blendMode: BlendMode.srcOut,
                                    ),
                                ],
                              ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                          child: Container(alignment: Alignment.center),
                        ),
                        frame != null
                            ? Container(
                                color: Colors.black12,
                                child: Image.asset(
                                  frame!,
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ).center(),
                  ),
                  if (mShowBeforeImage) Image.file(croppedFile!, fit: BoxFit.fitWidth),
                ],
              ),
            ),
            if (mIsFilterViewVisible)
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: mIsFilterViewVisible ? 60 : 0,
                  width: context.width(),
                  child: FilterSelectionWidget(
                    image: croppedFile,
                    onSelect: (v) {
                      filter = v;
                      setState(() {});
                    },
                  ),
                ),
              ),
            if (mIsBrightnessSliderVisible)
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: mIsBrightnessSliderVisible ? 60 : 0,
                  width: context.width(),
                  child: Container(
                    color: Colors.white38,
                    height: 60,
                    child: Row(
                      children: [
                        8.width,
                        Text('Яркость'),
                        8.width,
                        Slider(
                          min: 0.0,
                          max: 1.0,
                          onChanged: (d) {
                            brightness = d;
                            setState(() {});
                          },
                          value: brightness,
                        ).expand(),
                      ],
                    ),
                  ),
                ),
              ),
            if (mIsContrastSliderVisible)
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: mIsContrastSliderVisible ? 60 : 0,
                  width: context.width(),
                  child: Container(
                    color: Colors.white38,
                    height: 60,
                    child: Row(
                      children: [
                        8.width,
                        Text('Контраст'),
                        8.width,
                        Slider(
                          min: 0.0,
                          max: 1.0,
                          onChanged: (d) {
                            contrast = d;
                            setState(() {});
                          },
                          value: contrast,
                        ).expand(),
                      ],
                    ),
                  ),
                ),
              ),
            if (mIsSaturationSliderVisible)
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: mIsSaturationSliderVisible ? 60 : 0,
                  width: context.width(),
                  child: Container(
                    color: Colors.white38,
                    height: 60,
                    child: Row(
                      children: [
                        8.width,
                        Text('Сатурация'),
                        8.width,
                        Slider(
                          min: 0.0,
                          max: 1.0,
                          onChanged: (d) {
                            saturation = d;
                            setState(() {});
                          },
                          value: saturation,
                        ).expand(),
                      ],
                    ),
                  ),
                ),
              ),
            if (mIsHueSliderVisible)
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: mIsHueSliderVisible ? 60 : 0,
                  width: context.width(),
                  child: Container(
                    color: Colors.white38,
                    height: 60,
                    child: Row(
                      children: [
                        8.width,
                        Text('Оттенок'),
                        8.width,
                        Slider(
                          min: 0.0,
                          max: 1.0,
                          onChanged: (d) {
                            hue = d;
                            setState(() {});
                          },
                          value: hue,
                        ).expand(),
                      ],
                    ),
                  ),
                ),
              ),
            if (mIsBlurVisible)
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: mIsBlurVisible ? 60 : 0,
                  color: Colors.white38,
                  width: context.width(),
                  child: BlurSelectorBottomSheet(
                    sliderValue: blur,
                    onColorSelected: (v) {
                      blur = v;
                      setState(() {});
                    },
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: ColoredBox(
            color: AppColors.white,
            child: SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BottomBarItemWidget(
                      title: 'Очистить',
                      icons: Icon(FontAwesomeIcons.eraser).icon,
                      onTap: () => onEraserClick(),
                    ),
                    BottomBarItemWidget(
                      title: 'Яркость',
                      icons: Icon(Icons.brightness_2_outlined).icon,
                      onTap: () => onBrightnessSliderClick(),
                    ),
                    BottomBarItemWidget(
                      title: 'Контраст',
                      icons: Icon(Icons.brightness_4_outlined).icon,
                      onTap: () => onContrastSliderClick(),
                    ),
                    BottomBarItemWidget(
                      title: 'Сатурация',
                      icons: Icon(Icons.brightness_4_sharp).icon,
                      onTap: () => onSaturationSliderClick(),
                    ),
                    BottomBarItemWidget(
                      title: 'Оттенок',
                      icons: Icon(Icons.brightness_medium_sharp).icon,
                      onTap: () => onHueSliderClick(),
                    ),
                    BottomBarItemWidget(
                      title: 'Размытие',
                      icons: Icon(MaterialCommunityIcons.blur).icon,
                      onTap: () => onBlurClick(),
                    ),
                    BottomBarItemWidget(
                      title: 'Фильтр',
                      icons: Icon(Icons.photo).icon,
                      onTap: () => onFilterClick(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
