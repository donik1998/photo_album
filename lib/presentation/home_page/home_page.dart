import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/main_page/main_page_body.dart';
import 'package:photo_album/presentation/my_albums_page/my_albums_page_body.dart';
import 'package:photo_album/presentation/profile/profile_page.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  List<Widget> _tabs = [
    MainPageBody(),
    MyAlbumsPageBody(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _tabs.elementAt(_pageIndex),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) => setState(() => _pageIndex = value),
        indicatorColor: AppColors.pinkLight,
        activeColor: AppColors.pinkLight,
        inactiveColor: AppColors.black,
        inactiveStripColor: AppColors.grey,
        items: [
          TitledNavigationBarItem(
            icon: Text(
              'Главная',
              style: AppTextStyles.smallBoldText.copyWith(fontSize: 10),
            ),
            title: SvgPicture.asset('assets/svgs/home.svg'),
          ),
          TitledNavigationBarItem(
            title: SvgPicture.asset('assets/svgs/book.svg'),
            icon: Text(
              'Мои альбомы',
              style: AppTextStyles.smallBoldText.copyWith(fontSize: 10),
            ),
          ),
          TitledNavigationBarItem(
            title: SvgPicture.asset('assets/svgs/menu.svg'),
            icon: Text(
              'Меню',
              style: AppTextStyles.smallBoldText.copyWith(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
