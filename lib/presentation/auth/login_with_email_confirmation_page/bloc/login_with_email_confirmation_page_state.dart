abstract class LoginWithEmailConfirmationPageState {}

class LoginWithEmailConfirmationPageInitial extends LoginWithEmailConfirmationPageState {}

class LoginWithEmailConfirmationPageLoading extends LoginWithEmailConfirmationPageState {}

class LoginWithEmailConfirmationPageSuccess extends LoginWithEmailConfirmationPageState {}

class LoginWithEmailConfirmationPageError extends LoginWithEmailConfirmationPageState {
  final String error;

  LoginWithEmailConfirmationPageError({required this.error});
}
