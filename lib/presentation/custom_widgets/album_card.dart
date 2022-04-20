import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;
  final bool showText;

  const AlbumCard({
    Key? key,
    required this.album,
    this.showText = true,
  }) : super(key: key);

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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: CachedNetworkImage(
            imageUrl: album.cover.downloadLink,
            fit: BoxFit.cover,
            errorWidget: (context, url, trace) => SvgPicture.asset('assets/svgs/image.svg', fit: BoxFit.scaleDown),
          ),
        ),
        if (showText) AppSpacing.verticalSpace7,
        if (showText) Text(album.type, style: AppTextStyles.txt13),
      ],
    );
  }
}
