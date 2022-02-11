import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/my_albums_page/bloc/my_albums_page_cubit.dart';
import 'package:photo_album/presentation/profile/bloc/profile_page_cubit.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

import '../../custom_widgets/custom_button.dart';
import '../../home_page/home_page.dart';
import '../../theme/app_colors.dart';
import 'bloc/login_with_email_cubit.dart';
import 'bloc/login_with_email_page_state.dart';

class LoginWithEmailPage extends StatelessWidget {
  const LoginWithEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginWithEmailPageCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<LoginWithEmailPageCubit, LoginWithEmailPageState>(
          bloc: cubit,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoginWithEmailInitial)
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppSpacing.verticalSpace32,
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/login_form_pic.png',
                    ),
                  ),
                  AppSpacing.verticalSpace24,
                  Align(alignment: Alignment.center, child: Text('Введите свои данные', style: AppTextStyles.title)),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.dark,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                        )),
                  ),
                  AppSpacing.verticalSpace4,
                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                        obscureText: true,
                        keyboardAppearance: Brightness.dark,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                        )),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: CustomButton.text(
                      text: "Продолжить",
                      textStyle: AppTextStyles.bodyTextStyle
                          .copyWith(color: AppColors.white),
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
                  ),
                  AppSpacing.verticalSpace32,
                ],
              );

            return Container();
          },
        ),
      ),
    );
  }
}
