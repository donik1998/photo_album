import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_with_email_page_state.dart';

class LoginWithEmailPageCubit extends Cubit<LoginWithEmailPageState> {
  LoginWithEmailPageCubit() : super(LoginWithEmailInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
