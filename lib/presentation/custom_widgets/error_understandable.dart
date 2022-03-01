import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

mixin ErrorUnderstandable {
  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          message,
          style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
