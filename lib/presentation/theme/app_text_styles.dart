import 'package:flutter/cupertino.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle bodyTextStyle = const TextStyle(
    fontFamily: 'ProximaNove',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.dark,
  );

  static const TextStyle title = const TextStyle(
    fontFamily: 'ProximaNove',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
  );

  static const TextStyle smallText = const TextStyle(
    fontFamily: 'ProximaNove',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.dark,
  );
}
