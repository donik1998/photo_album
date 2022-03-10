import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/custom_button.dart';
import 'package:photo_album/presentation/custom_widgets/custom_text_field.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/state/auth/login_with_email_page_state.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class LoginWithEmailPage extends StatelessWidget {
  const LoginWithEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<LoginWithEmailPageState>(
          builder: (context, state, child) {
            if (state.loading)
              return Loader();
            else
              return Padding(
                padding: AppInsets.horizontalInsets36,
                child: Form(
                  key: state.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppSpacing.verticalSpace32,
                      Image.asset('assets/images/login_with_email_page_pic.png', width: 161, height: 122),
                      AppSpacing.verticalSpace20,
                      AppSpacing.verticalSpace32,
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: state.emailController,
                        labelText: 'Почта',
                        validator: (value) {
                          if (value?.isEmpty ?? false)
                            return 'Это обязательное поле';
                          else
                            return null;
                        },
                      ),
                      AppSpacing.verticalSpace16,
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: state.passwordController,
                        labelText: 'Пароль',
                        obscureText: true,
                        validator: (value) {
                          if (value?.isEmpty ?? false)
                            return 'Это обязательное поле';
                          else
                            return null;
                        },
                      ),
                      AppSpacing.verticalSpace32,
                      CustomButton.text(
                        text: "Продолжить",
                        textStyle: AppTextStyles.smallTitleBold.copyWith(color: AppColors.white),
                        onTap: () => state.loginWithEmailAndPassword(context),
                        color: AppColors.pinkLight,
                      ),
                      AppSpacing.verticalSpace16,
                      Text(
                        'Продолжая, вы принимаете условия пользовательского сошлашения и политику конфиденциальности “App”',
                        style: AppTextStyles.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
