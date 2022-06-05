import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;
  final bool showText;
  final VoidCallback onTap;
  final VoidCallback onAlbumDeleted;

  const AlbumCard({
    Key? key,
    required this.album,
    required this.onAlbumDeleted,
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
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.grey),
              child: Center(
                child: album.cover.localPath.isNotEmpty
                    ? Image.file(File(album.cover.localPath), fit: BoxFit.fill)
                    : CachedNetworkImage(
                        imageUrl: album.cover.downloadLink,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, trace) => Expanded(
                          child: Center(child: SvgPicture.asset('assets/svgs/image.svg', fit: BoxFit.scaleDown)),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
