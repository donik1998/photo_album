import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class ElementCard extends StatelessWidget {
  final String title;
  final String imageLink;
  final VoidCallback onTap;

  const ElementCard({
    Key? key,
    required this.title,
    required this.imageLink,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: imageLink,
                width: 110,
                height: 110,
                imageBuilder: (context, image) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(image: image, fit: BoxFit.fitWidth),
                ),
                errorWidget: (context, url, trace) => Center(child: Icon(Icons.error_outline)),
              ),
              AppSpacing.verticalSpace7,
              Text(title, style: AppTextStyles.txt13),
            ],
          ),
        ),
      ),
    );
  }
}
