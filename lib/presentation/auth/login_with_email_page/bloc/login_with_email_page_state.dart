abstract class LoginWithEmailPageState {}

class LoginWithEmailInitial extends LoginWithEmailPageState {}

class LoginWithEmailLoading extends LoginWithEmailPageState {}

class LoginWithEmailSuccess extends LoginWithEmailPageState {}

class LoginWithEmailError extends LoginWithEmailPageState {
  final String error;

  LoginWithEmailError({required this.error});
}
