import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/decoration_category.dart';
import 'package:photo_album/data/services/dataBase_services.dart';
import 'package:photo_album/data/services/decorations_service.dart';
import 'package:photo_album/data/services/templates_service.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/pages/main_page/main_page_body.dart';
import 'package:photo_album/presentation/pages/my_albums_page/my_albums_page_body.dart';
import 'package:photo_album/presentation/pages/profile/profile_page.dart';
import 'package:photo_album/presentation/state/main_page/main_page_body_state.dart';
import 'package:photo_album/presentation/state/main_page/my_albums_body_state.dart';
import 'package:photo_album/presentation/state/main_page/profile_page_state.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  List<Widget> _tabs = List.empty(growable: true);
  List<DecorationCategory> _decorationCategories = List.empty();
  List<AlbumPageTemplateCategory> _albumPageTemplateCategory = List.empty();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) async {
        final decorationCategories = await DecorationService.instance.getDecorationCategories();
        decorationCategories.insert(
          0,
          DecorationCategory(title: 'Фотографии', titleMasks: {'ru': 'Фотографии'}),
        );
        decorationCategories.insert(
          0,
          DecorationCategory(title: 'Шаблоны', titleMasks: {'ru': 'Шаблоны'}),
        );
        final albumPageTemplateCategories = await TemplatesService.instance.getAlbumCategories();
        final localAlbums = await DataBaseService.instance.getAlbumFromDB();
        _decorationCategories = decorationCategories;
        _albumPageTemplateCategory = albumPageTemplateCategories;
        setState(() {
          _tabs = [
            ChangeNotifierProvider(
              create: (_) => MainPageBodyState(
                templateCategories: albumPageTemplateCategories,
                decorationCategories: decorationCategories,
              ),
              child: MainPageBody(),
            ),
            ChangeNotifierProvider(
              create: (_) => MyAlbumsBodyState(localAlbums: localAlbums),
              child: MyAlbumsPageBody(),
            ),
            ChangeNotifierProvider(
              create: (context) => ProfilePageState(),
              child: ProfilePage(),
            ),
          ];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _tabs.isEmpty ? Center(child: Loader()) : _tabs.elementAt(_pageIndex),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.pinkLight,
        onPressed: () => Navigator.pushNamed(
          context,
          AppRoutes.EDITOR_PAGE,
          arguments: RedactorPageArgs(
            albumPageTemplateCategories: _albumPageTemplateCategory,
            decorationCategories: _decorationCategories,
          ),
        ),
        child: Icon(Icons.add),
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
