import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    return Scaffold(
      body: BlocConsumer<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageLoading) return Loader();
          return cubit.getLayoutFromBoxConstrains(BoxConstraints.loose(MediaQuery.of(context).size));
        },
        listener: (context, state) {},
      ),
    );
  }
}
