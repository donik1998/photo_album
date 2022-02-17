import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class SideBar extends StatefulWidget {
  final ValueChanged<int> onPageChanged;

  const SideBar({Key? key, required this.onPageChanged}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int activePageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBlue,
      padding: AppInsets.horizontalInsets16,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpacing.verticalSpace16,
          Image.asset('assets/images/sidebar_logo.png'),
          AppSpacing.verticalSpace16,
          SidebarAction(
            icon: Icons.list_alt,
            isSelected: activePageIndex == 0,
            onTap: () {
              setState(() => activePageIndex = 0);
              widget.onPageChanged(0);
            },
            title: 'Заказы',
          ),
          SidebarAction(
            icon: Icons.menu,
            isSelected: activePageIndex == 1,
            onTap: () {
              setState(() => activePageIndex = 1);
              widget.onPageChanged(1);
            },
            title: 'Элементы украшения',
          ),
          SidebarAction(
            icon: Icons.add,
            isSelected: activePageIndex == 2,
            onTap: () {
              setState(() => activePageIndex = 2);
              widget.onPageChanged(2);
            },
            title: 'Добавить элементы украшения',
          ),
        ],
      ),
    );
  }
}

class SidebarAction extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String title;
  final IconData icon;

  const SidebarAction({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.lightBlue : AppColors.darkBlue,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        highlightColor: AppColors.lightBlue.withOpacity(0.1),
        child: Ink(
          height: 48,
          color: isSelected ? AppColors.lightBlue : AppColors.darkBlue,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.white),
              AppSpacing.horizontalSpace16,
              Expanded(child: Text(title, style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
