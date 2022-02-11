import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AlbumCard extends StatelessWidget {
  final Album album;

  const AlbumCard({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          height: 110,
          margin: EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage(album.thumbnailLink)),
          ),
        ),
        AppSpacing.verticalSpace7,
        Text(album.type, style: AppTextStyles.txt13),
      ],
    );
  }
}
