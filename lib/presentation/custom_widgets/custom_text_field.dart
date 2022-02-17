import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Color? labelColor;
  final String? Function(String?)? validator;
  final Color? inputTextColor;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscureText,
    this.inputTextColor,
    this.validator,
    this.fillColor,
    this.labelColor,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        style: AppTextStyles.bodyTextStyle.copyWith(color: inputTextColor),
        decoration: InputDecoration(
          fillColor: fillColor ?? AppColors.grey,
          filled: true,
          labelText: labelText,
          labelStyle: AppTextStyles.smallPinkText.copyWith(color: labelColor ?? AppColors.dark),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
