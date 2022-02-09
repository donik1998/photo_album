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

  static const TextStyle ttxt = const TextStyle(
    fontFamily: 'ProximaNove',
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

  static const TextStyle ttxt1 = const TextStyle(
    fontFamily: 'ProximaNove',
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Color(0xFF2E2E2E),
  );
}
