import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AlbumPageTemplateCategoeyCard extends StatelessWidget {
  final AlbumPageTemplateCategory category;
  final VoidCallback onTap;
  final bool isSelected;

  const AlbumPageTemplateCategoeyCard({
    Key? key,
    required this.category,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.darkBlue,
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.dark : AppColors.darkBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            category.masks['ru'],
            style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
