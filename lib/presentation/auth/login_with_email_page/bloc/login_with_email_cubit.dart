import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_with_email_page_state.dart';


class LoginWithEmailPageCubit extends Cubit<LoginWithEmailPageState> {
  LoginWithEmailPageCubit() : super(LoginWithEmailInitial());
}