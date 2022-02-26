import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_state.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

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
        listener: (context, state) {
          if (state is HomePageError)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error, style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white))),
            );
          if (state is HomePageSuccess) print(state.categoriesList.length);
          if (state is HomePageSuccess && state.successMessage.isNotEmpty)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage, style: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white))),
            );
        },
      ),
    );
  }
}
