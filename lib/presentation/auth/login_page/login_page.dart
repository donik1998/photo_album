import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_cubit.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPageCubit, LoginPageState>(
      builder: (context, state) {
        return Container();
      },
      listener: (context, state) {},
    );
  }
}
