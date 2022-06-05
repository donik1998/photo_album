import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';

class PickImageSheet extends StatelessWidget {
  final ValueChanged<ImageSource> onSourceChosen;

  const PickImageSheet({
    Key? key,
    required this.onSourceChosen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.insetsAll16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpacing.verticalSpace16,
          CustomButton.text(
            text: 'Взять фото с галереи',
            onTap: () {
              Navigator.pop(context);
              onSourceChosen(ImageSource.gallery);
            },
            color: AppColors.pinkLight,
          ),
          AppSpacing.verticalSpace16,
          CustomButton.text(
            text: 'Взять с камеры',
            onTap: () {
              Navigator.pop(context);
              onSourceChosen(ImageSource.camera);
            },
            color: AppColors.pinkLight,
          ),
          AppSpacing.verticalSpace16,
        ],
      ),
    );
  }
}
