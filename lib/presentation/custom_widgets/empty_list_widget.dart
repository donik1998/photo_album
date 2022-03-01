import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  const EmptyListWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message, style: AppTextStyles.title, textAlign: TextAlign.center));
  }
}
