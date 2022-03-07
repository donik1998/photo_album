import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/template_page_model.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AlbumPageTemplateCard extends StatelessWidget {
  final AlbumPageTemplate template;
  final VoidCallback onTap;

  const AlbumPageTemplateCard({
    Key? key,
    required this.template,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                height: 200,
                imageUrl: template.imageLinks.first,
                imageBuilder: (context, image) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(image: image),
                ),
                errorWidget: (context, url, trace) => Center(child: Icon(Icons.error_outline, color: Colors.white)),
              ),
              AppSpacing.verticalSpace16,
              Text(template.title, style: AppTextStyles.smallTitleBold.copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
