abstract class LoginPageState {}

class LoginPageInitial extends LoginPageState {}

class LoginPageLoading extends LoginPageState {}

class LoginPageSuccess extends LoginPageState {}

class LoginPageError extends LoginPageState {
  final String error;

  LoginPageError({required this.error});
}
