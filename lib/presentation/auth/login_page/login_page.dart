import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_cubit.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_state.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginPageCubit>();
    return Scaffold(
      body: BlocConsumer<LoginPageCubit, LoginPageState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is LoginPageLoading) return Loader();
          return Padding(
            padding: AppInsets.horizontalInsets36,
            child: cubit.getLayoutFromBoxConstrains(
              BoxConstraints.expand(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height),
            ),
          );
        },
        listener: (context, state) {
          if (state is LoginPageError)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w700, color: AppColors.white),
                ),
                backgroundColor: AppColors.black,
              ),
            );
        },
      ),
    );
  }
}
