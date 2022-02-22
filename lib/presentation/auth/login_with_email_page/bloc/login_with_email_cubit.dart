import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/services/auth_service.dart';
import 'package:photo_album/presentation/custom_widgets/error_understandable.dart';
import 'package:photo_album/presentation/root/root_page.dart';

import 'login_with_email_page_state.dart';

class LoginWithEmailPageCubit extends Cubit<LoginWithEmailPageState> with ErrorUnderstandable {
  LoginWithEmailPageCubit() : super(LoginWithEmailInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  Future<void> loginWithEmailAndPassword(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final isSignedIn = await AuthService.instance.loginWithEmailAndPassword(emailController.text, passwordController.text);
      if (isSignedIn) {
        if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RootPage()),
            (route) => false,
          );
        } else
          showErrorSnackBar(
            context,
            'Не удалось войти или создать аккаунт. Убедитесь что подключены к интернету',
          );
      }
    }
  }
}
