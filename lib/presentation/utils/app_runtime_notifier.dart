import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/sheets/bottom_sheet_container.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AppRuntimeNotifier {
  AppRuntimeNotifier._();

  static AppRuntimeNotifier get instance => AppRuntimeNotifier._();

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

  void showCustomBottomSheet({required BuildContext context, required Widget sheet}) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => BottomSheetContainer(child: sheet),
      );
}
