import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_with_email_confirmation_page/bloc/login_with_email_confirmation_page_cubit.dart';
import 'package:photo_album/presentation/auth/login_with_email_confirmation_page/bloc/login_with_email_confirmation_page_state.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/home_page.dart';
import 'package:photo_album/presentation/my_albums_page/bloc/my_albums_page_cubit.dart';
import 'package:photo_album/presentation/profile/bloc/profile_page_cubit.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class LoginWithEmailConfirmationPage extends StatelessWidget {
  const LoginWithEmailConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginWithEmailConfirmationPageCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          // SvgPicture.asset('assets/svgs/app_logo_white.svg'),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset('assets/images/app_logo.png'),
          ),
        ],
      ),
      body: SafeArea(
        minimum: AppInsets.horizontalInsets36,
        child: BlocConsumer<LoginWithEmailConfirmationPageCubit, LoginWithEmailConfirmationPageState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is LoginWithEmailConfirmationPageLoading) return Loader();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                AppSpacing.verticalSpace24,
                Text('Подтверждение', style: AppTextStyles.title),
                AppSpacing.verticalSpace16,
                Text(
                  'Осталось только ввести код из письма на вашей электроной почте',
                  style: AppTextStyles.bodyTextStyle,
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Не пришел код?',
                  style: AppTextStyles.smallPinkText.copyWith(color: AppColors.dark),
                ),
                AppSpacing.verticalSpace16,
                CustomTextField(
                  labelText: 'Код с почты',
                  controller: TextEditingController(),
                ),
                AppSpacing.verticalSpace32,
                CustomButton.text(
                  text: "Отправить код",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(create: (context) => ProfilePageCubit(), lazy: true),
                          BlocProvider(create: (context) => HomePageCubit(), lazy: true),
                          BlocProvider(create: (context) => MyAlbumsPageCubit(), lazy: true),
                        ],
                        child: HomePage(),
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
              ],
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
