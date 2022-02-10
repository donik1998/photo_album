abstract class ProfilePageState {}

class ProfileInitial extends ProfilePageState {}
class ProfileLoading extends ProfilePageState {}
class ProfileSuccess extends ProfilePageState {

}
class ProfileError extends ProfilePageState {
  final String error;

  ProfileError({required this.error});
}