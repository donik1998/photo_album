import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/widgets/decorations_tab.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';

class HomePageDecorationElementsBody extends StatefulWidget {
  const HomePageDecorationElementsBody({Key? key}) : super(key: key);

  @override
  State<HomePageDecorationElementsBody> createState() => _HomePageDecorationElementsBodyState();
}

class _HomePageDecorationElementsBodyState extends State<HomePageDecorationElementsBody> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 56,
          width: double.infinity,
          child: TabBar(
            controller: tabController,
            tabs: [
              Tab(icon: Icon(Icons.emoji_emotions_outlined, color: AppColors.white)),
              Tab(icon: Icon(Icons.gif, color: AppColors.white)),
              Tab(icon: Icon(Icons.format_color_text, color: AppColors.white)),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              DecorationsTab(type: DecorationElementTypes.STICKER, onMessageGenerated: (message) => cubit.showMessage(message)),
              DecorationsTab(type: DecorationElementTypes.ANIMATION, onMessageGenerated: (message) => cubit.showMessage(message)),
              DecorationsTab(type: DecorationElementTypes.FONT, onMessageGenerated: (message) => cubit.showMessage(message)),
            ],
          ),
        ),
      ],
    );
  }
}
