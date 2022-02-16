import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/album_card.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';

import '../../data/models/album_template.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final List<AlbumModel> content;
  const DetailPage({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

        actions: [Image(image: AssetImage('assets/images/Logo_small.png'))],
      ),
      body: GridView.builder(
        padding: AppInsets.horizontalInsets16.copyWith(top: 32),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemBuilder: (BuildContext context, int index) {
          return AlbumCard(album: widget.content.elementAt(index), showText: false);
        },
        itemCount: widget.content.length,
      ),
    );
  }
}
