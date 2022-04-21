import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/text_divider.dart';
import 'package:photo_album/presentation/state/auth/login_page_state.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/app_runtime_notifier.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LoginPageState>(
          builder: (context, state, child) => Padding(
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
                  onTap: () => state.loginWithGoogle().then((signInSuccess) {
                    if (signInSuccess)
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.ROOT_PAGE, (route) => false);
                    else
                      AppRuntimeNotifier.instance.showErrorSnack(context: context, message: 'Не получилось войти через Google');
                  }),
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
                AppSpacing.verticalSpace32,
                TextDivider(text: 'или'),
                AppSpacing.verticalSpace32,
                CustomButton.text(
                  text: 'Продолжить с почтой',
                  textStyle: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
                  onTap: () => Navigator.pushNamed(context, AppRoutes.LOGIN_WITH_EMAIL_PAGE),
                  color: AppColors.pinkLight,
                ),
                AppSpacing.verticalSpace16,
                Text(
                  'Продолжая, вы принимаете условия пользовательского соглашения и политику конфиденциальности “App”',
                  style: AppTextStyles.smallText,
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalSpace16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
