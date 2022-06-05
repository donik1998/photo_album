import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class ChangeNameSheet extends StatelessWidget {
  final TextEditingController nameController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSaved;

  const ChangeNameSheet({
    Key? key,
    required this.nameController,
    required this.formKey,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpacing.verticalSpace16,
          Text('Введите ваше имя', style: AppTextStyles.title),
          AppSpacing.verticalSpace16,
          CustomTextField(
            labelText: 'Имя',
            controller: nameController,
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return 'Это поле не может быть пустым';
              } else {
                return null;
              }
            },
          ),
          AppSpacing.verticalSpace16,
          CustomButton.text(
            text: 'Сохранить',
            onTap: () {
              onSaved();
              Navigator.pop(context);
            },
            color: AppColors.pinkLight,
          ),
          AppSpacing.verticalSpace16,
        ],
      ),
    );
  }
}
