import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/widgets/sidebar.dart';

class HomePageLargeLayout extends StatelessWidget {
  const HomePageLargeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: SideBar(onPageChanged: (value) => cubit.changeCurrentIndex(value)),
        ),
        Expanded(
          flex: 7,
          child: cubit.homePageBodies.elementAt(cubit.currentPageIndex),
        ),
      ],
    );
  }
}
