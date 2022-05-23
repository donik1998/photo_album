import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/presentation/custom_widgets/custom_confirmation_dialog.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';

class AlbumCard extends StatefulWidget {
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
  State<AlbumCard> createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  bool _isGoingToDelete = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grey,
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          if (_isGoingToDelete)
            setState(() => _isGoingToDelete = false);
          else
            widget.onTap();
        },
        onLongPress: () => setState(() => _isGoingToDelete = true),
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.grey),
              child: Center(
                child: widget.album.cover.localPath.isNotEmpty
                    ? Image.file(
                        File(widget.album.cover.localPath),
                        fit: BoxFit.fill,
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.album.cover.downloadLink,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, trace) => Expanded(
                          child: Center(child: SvgPicture.asset('assets/svgs/image.svg', fit: BoxFit.scaleDown)),
                        ),
                      ),
              ),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 250),
              opacity: _isGoingToDelete ? 1 : 0,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.grey.withOpacity(0.85)),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialog(
                        message:
                            'Вы действительно хотите удалить альбом ${widget.album.title} из ваших альбомов? Это действие невозможно отменить',
                        onCancel: () {},
                        onConfirm: () => widget.onAlbumDeleted(),
                      ),
                    ),
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
