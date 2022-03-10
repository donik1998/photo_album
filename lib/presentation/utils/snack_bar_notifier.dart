import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

mixin SnackBarNotifier {
  void showErrorSnack({required BuildContext context, required String message}) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.smallTitleBold.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
      );
}
