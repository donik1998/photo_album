import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;
  final bool showText;
  final VoidCallback onTap;

  const AlbumCard({
    Key? key,
    required this.album,
    required this.onTap,
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grey,
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.grey),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl: album.cover.downloadLink,
                fit: BoxFit.fitHeight,
                errorWidget: (context, url, trace) => Expanded(
                  child: Center(child: SvgPicture.asset('assets/svgs/image.svg', fit: BoxFit.scaleDown)),
                ),
              ),
              if (showText) AppSpacing.verticalSpace7,
              if (showText) Text(album.type, style: AppTextStyles.txt13),
            ],
          ),
        ),
      ),
    );
  }
}
