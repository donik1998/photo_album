import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageInitial());
}
