import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Ничего не найдено', style: AppTextStyles.title.copyWith(color: Colors.white)));
  }
}
