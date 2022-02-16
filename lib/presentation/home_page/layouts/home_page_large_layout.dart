import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';

class HomePageLargeLayout extends StatelessWidget {
  const HomePageLargeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: Container(),
        ),
        Expanded(
          flex: 7,
          child: Container(),
        ),
      ],
    );
  }
}
