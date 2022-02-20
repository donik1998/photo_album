import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final TextStyle textStyle;
  final Widget child;

  const CustomButton({
    Key? key,
    this.text = '',
    required this.onTap,
    required this.color,
    this.child = const SizedBox(),
    this.textStyle = const TextStyle(),
  }) : super(key: key);

  factory CustomButton.text({
    required String text,
    required VoidCallback onTap,
    required Color color,
    TextStyle? textStyle,
  }) =>
      CustomButton(
        onTap: onTap,
        color: color,
        text: text,
        textStyle: textStyle ?? AppTextStyles.bodyTextStyle.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
      );

  factory CustomButton.child({
    required VoidCallback onTap,
    required Color color,
    required Widget child,
    TextStyle? textStyle,
  }) =>
      CustomButton(
        onTap: onTap,
        color: color,
        child: child,
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
          height: 56,
          child: Center(child: text.isEmpty ? child : Text(text, style: textStyle)),
        ),
      ),
    );
  }
}
