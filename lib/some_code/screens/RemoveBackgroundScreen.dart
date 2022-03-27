import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_album/some_code/services/FileService.dart';
import 'package:photo_album/some_code/utils/Colors.dart';

class RemoveBackgroundScreen extends StatefulWidget {
  static String tag = '/RemoveBackgroundScreen';
  final File? file;

  RemoveBackgroundScreen({this.file});

  @override
  RemoveBackgroundScreenState createState() => RemoveBackgroundScreenState();
}

class RemoveBackgroundScreenState extends State<RemoveBackgroundScreen> {
  File? originalFile;
  late File removeBgImage;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    originalFile = widget.file;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Remove Background Image'),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              Column(
                children: [
                  Text('Original File', style: boldTextStyle(color: colorPrimary)),
                  8.height,
                  Image.file(originalFile!, height: (context.height() / 2) - 60, fit: BoxFit.cover),
                ],
              )
            ],
          ),
          AppButton(
            child: Text('Remove Background', style: primaryTextStyle(color: Colors.white)),
            color: colorPrimary,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 60),
            onTap: () async {
              String fileName = DateTime.now().toIso8601String();
              String path = '$fileName.jpeg';

              removeWhiteBackground(File(originalFile!.path).readAsBytesSync()).then((value) async {
                removeBgImage = File(path);
                removeBgImage.writeAsBytesSync(value);

                log(removeBgImage.existsSync());
              }).catchError((e) {
                log(e);
              });
            },
          ),
          Observer(builder: (_) => Loader().visible(true)),
        ],
      ).paddingAll(16),
    );
  }
}
