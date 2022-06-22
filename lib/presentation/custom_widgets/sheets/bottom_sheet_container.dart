import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;
  final MainAxisSize mainAxisSize;
  final Color? color;

  const BottomSheetContainer({
    Key? key,
    required this.child,
    this.mainAxisSize = MainAxisSize.min,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: color ?? Colors.white,
      ),
      child: Column(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: 72,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          AppSpacing.verticalSpace4,
          AppSpacing.verticalSpace4,
          child,
        ],
      ),
    );
  }
}
