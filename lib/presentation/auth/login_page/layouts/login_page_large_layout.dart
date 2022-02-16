import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_cubit.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/home_page.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class LoginPageLargeLayout extends StatelessWidget {
  const LoginPageLargeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginPageCubit>();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Image.asset('assets/images/login_with_email_page_pic.png')),
        AppSpacing.horizontalSpace20,
        AppSpacing.horizontalSpace20,
        Expanded(
          child: Form(
            key: cubit.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  labelText: 'Почта',
                  controller: cubit.emailController,
                ),
                AppSpacing.verticalSpace24,
                CustomTextField(
                  labelText: 'Пароль',
                  controller: cubit.passwordController,
                  obscureText: true,
                ),
                AppSpacing.verticalSpace24,
                CustomButton.text(
                  text: 'Войти',
                  textStyle: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
                  onTap: () async {
                    final loginSuccess = await cubit.login();
                    if (loginSuccess)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => HomePageCubit(),
                            child: HomePage(),
                          ),
                        ),
                      );
                  },
                  color: AppColors.pinkLight,
                ),
                AppSpacing.verticalSpace16,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
