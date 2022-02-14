import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_with_email_confirmation_page/bloc/login_with_email_confirmation_page_state.dart';

class LoginWithEmailConfirmationPageCubit extends Cubit<LoginWithEmailConfirmationPageState> {
  LoginWithEmailConfirmationPageCubit() : super(LoginWithEmailConfirmationPageInitial());
}
