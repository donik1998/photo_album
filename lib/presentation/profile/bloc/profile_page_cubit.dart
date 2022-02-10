import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/profile/bloc/profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(ProfileInitial());
}