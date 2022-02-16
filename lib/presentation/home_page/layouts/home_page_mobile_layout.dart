import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class HomePageMobileLayout extends StatelessWidget {
  const HomePageMobileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Закзаы', style: AppTextStyles.title),
      ],
    );
  }
}
