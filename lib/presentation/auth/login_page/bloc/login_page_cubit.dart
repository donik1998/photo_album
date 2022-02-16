import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_state.dart';
import 'package:photo_album/presentation/auth/login_page/layouts/login_page_large_layout.dart';
import 'package:photo_album/presentation/auth/login_page/layouts/login_page_mobile_layout.dart';
import 'package:photo_album/presentation/theme/layout_decider.dart';

class LoginPageCubit extends Cubit<LoginPageState> with LayoutDecider {
  LoginPageCubit() : super(LoginPageInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        emit(LoginPageLoading());
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        return true;
      } catch (e) {
        emit(LoginPageError(error: e.toString()));
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget get largeLayout => LoginPageLargeLayout();

  @override
  Widget get tabletLayout => LoginPageLargeLayout();

  @override
  Widget get mobileLayout => LoginPageMobileLayout();
}
