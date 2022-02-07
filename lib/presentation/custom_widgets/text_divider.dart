import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final Color? dividerColor;

  const TextDivider({Key? key, required this.text, this.dividerColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: Divider(thickness: 1.0, color: dividerColor ?? Theme.of(context).dividerColor)),
        AppSpacing.horizontalSpace16,
        Text(text, style: AppTextStyles.bodyTextStyle),
        AppSpacing.horizontalSpace16,
        Expanded(child: Divider(thickness: 1.0, color: dividerColor ?? Theme.of(context).dividerColor)),
      ],
    );
  }
}
