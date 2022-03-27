import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: AppColors.pinkLight,
      shape: CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(1000),
        onTap: onTap,
        child: Ink(
          height: 36,
          width: 36,
          padding: AppInsets.insetsAll8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.pinkLight,
          ),
          child: Center(child: Icon(icon, color: AppColors.white, size: 18)),
        ),
      ),
    );
  }
}
