import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/login_with_email_page/bloc/login_with_email_page_state.dart';

class LoginWithEmailPageCubit extends Cubit<LoginWithEmailPageState> {
  LoginWithEmailPageCubit() : super(LoginWithEmailInitial());
}