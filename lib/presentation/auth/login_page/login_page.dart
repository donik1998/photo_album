import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_cubit.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_state.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/custom_widgets/text_divider.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

import '../login_with_email_page/bloc/login_with_email_cubit.dart';
import '../login_with_email_page/login_with_email_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginPageCubit>();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginPageCubit, LoginPageState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is LoginPageLoading)
              return Loader();
            else if (state is LoginPageInitial || state is LoginPageSuccess)
              return Padding(
                padding: AppInsets.horizontalInsets36,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSpacing.verticalSpace20,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('assets/images/login_form_pic.png', width: 100, height: 96),
                    ),
                    AppSpacing.verticalSpace24,
                    Text(
                      'Создавайте фотоальбомы Делитесь со своими близкими',
                      style: AppTextStyles.title,
                    ),
                    AppSpacing.verticalSpace16,
                    Text(
                      'Среди 5000 готовых шаблонов вы наверняка найдете идеальный для своего фотоальбома',
                      style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 16),
                    ),
                    Expanded(child: SizedBox()),
                    CustomButton.child(
                      onTap: () {},
                      color: AppColors.grey,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SvgPicture.asset('assets/svgs/google.svg'),
                          AppSpacing.horizontalSpace20,
                          Text('Войти через Google', style: AppTextStyles.bodyTextStyle)
                        ],
                      ),
                    ),
                    AppSpacing.verticalSpace16,
                    CustomButton.child(
                      onTap: () {},
                      color: AppColors.grey,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SvgPicture.asset('assets/svgs/facebook.svg'),
                          AppSpacing.horizontalSpace20,
                          Text(
                            'Войти через Facebook',
                            style: AppTextStyles.bodyTextStyle,
                          )
                        ],
                      ),
                    ),
                    AppSpacing.verticalSpace32,
                    TextDivider(text: 'или'),
                    AppSpacing.verticalSpace32,
                    CustomButton.text(
                      text: 'Продолжить с почтой',
                      textStyle: AppTextStyles.bodyTextStyle.copyWith(color: AppColors.white),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => LoginWithEmailPageCubit(),
                            child: LoginWithEmailPage(),
                          ),
                        ),
                      ),
                      color: AppColors.pinkLight,
                    ),
                    AppSpacing.verticalSpace16,
                    Text(
                      'Продолжая, вы принимаете условия пользовательского сошлашения и политику конфиденциальности “App”',
                      style: AppTextStyles.smallText,
                      textAlign: TextAlign.center,
                    ),
                    AppSpacing.verticalSpace16,
                  ],
                ),
              );
            else
              return Container();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
