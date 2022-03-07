import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';

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
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: 110,
          height: 110,
          padding: AppInsets.all16,
          decoration: BoxDecoration(
            color: AppColors.darkBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: CachedNetworkImage(
            imageUrl: element.downloadLink,
            imageBuilder: (context, image) => ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(image: image, fit: BoxFit.contain),
            ),
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, trace) => Center(child: Icon(Icons.error_outline, color: AppColors.white)),
          ),
        ),
      ),
    );
  }
}
