import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/login_with_email_page/bloc/login_with_email_cubit.dart';
import 'package:photo_album/presentation/auth/login_page/login_with_email_page/bloc/login_with_email_page_state.dart';

class LoginWithEmailPage extends StatelessWidget {
  const LoginWithEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginWithEmailPageCubit>();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginWithEmailPageCubit, LoginWithEmailPageState>(
          bloc: cubit,
          listener: (context, state) {},
          builder: (context, state) {
            if(state is LoginWithEmailInitial)
              return Column();

            return Container();
          },
        ),
      ),
    );
  }
}
