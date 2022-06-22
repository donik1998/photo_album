import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class SetTextAlbumDecorationDialog extends StatefulWidget {
  const SetTextAlbumDecorationDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<SetTextAlbumDecorationDialog> createState() => _SetTextAlbumDecorationDialogState();
}

class _SetTextAlbumDecorationDialogState extends State<SetTextAlbumDecorationDialog> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: AppInsets.insetsAll16,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Введите текст',
                style: AppTextStyles.ttxt.copyWith(color: AppColors.black),
              ),
              AppSpacing.verticalSpace16,
              CustomTextField(
                labelText: 'Текст',
                controller: controller,
                validator: (value) {
                  if (value?.isEmpty ?? false)
                    return 'Это поле не может быть пустым';
                  else
                    return null;
                },
              ),
              AppSpacing.verticalSpace16,
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: CustomButton.text(
                      text: 'Отмена',
                      onTap: () {
                        Navigator.pop(context);
                      },
                      color: AppColors.pinkLight,
                    ),
                  ),
                  AppSpacing.horizontalSpace16,
                  Expanded(
                    child: CustomButton.text(
                      text: 'Готово',
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          Navigator.pop(context, controller.text);
                        }
                      },
                      color: AppColors.pinkLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
