import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color, shadowColor;
  final TextStyle textStyle;
  final Widget child;
  final double height;
  final double elevation;

  const CustomButton({
    Key? key,
    this.text = '',
    required this.onTap,
    this.height = 48,
    required this.color,
    this.elevation = 0.5,
    this.shadowColor = AppColors.grey,
    this.child = const SizedBox(),
    this.textStyle = const TextStyle(),
  }) : super(key: key);

  factory CustomButton.text({
    required String text,
    required VoidCallback onTap,
    required Color color,
    Color? shadowColor,
    TextStyle? textStyle,
    double? height,
    double? elevation,
  }) =>
      CustomButton(
        onTap: onTap,
        color: color,
        text: text,
        height: height ?? 48,
        elevation: elevation ?? 0.5,
        shadowColor: shadowColor ?? AppColors.grey,
        textStyle: textStyle ?? AppTextStyles.bodyTextStyle.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
      );

  factory CustomButton.child({
    required VoidCallback onTap,
    required Color color,
    required Widget child,
    Color? shadowColor,
    TextStyle? textStyle,
    double? elevation,
    double? height,
  }) =>
      CustomButton(
        onTap: onTap,
        color: color,
        elevation: elevation ?? 0.5,
        shadowColor: shadowColor ?? AppColors.grey,
        child: child,
        height: height ?? 48,
        textStyle: textStyle ?? AppTextStyles.bodyTextStyle,
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      shadowColor: AppColors.grey,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: text.isEmpty ? child : Center(child: Text(text, style: textStyle)),
        ),
      ),
    );
  }
}
