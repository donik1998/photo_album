import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';

class DecorationElementCard extends StatelessWidget {
  final DecorationElement element;
  final VoidCallback onTap;

  const DecorationElementCard({
    Key? key,
    required this.element,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          width: 110,
          height: 110,
          color: AppColors.darkBlue,
          child: CachedNetworkImage(
            imageUrl: element.downloadLink,
            imageBuilder: (context, image) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(image: image, fit: BoxFit.fill),
            ),
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, trace) => Center(child: Icon(Icons.error_outline, color: AppColors.white)),
          ),
        ),
      ),
    );
  }
}
