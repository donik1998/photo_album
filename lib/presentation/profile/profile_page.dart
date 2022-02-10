import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';

import 'bloc/profile_page_cubit.dart';
import 'bloc/profile_page_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      bloc: context.read<ProfilePageCubit>(),
      builder: (context, state) {
        if (state is ProfileLoading)
          return Loader();
        else
          return Container();
      },
      listener: (context, state) {},
    );
  }
}
