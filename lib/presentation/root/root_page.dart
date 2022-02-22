import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_cubit.dart';
import 'package:photo_album/presentation/auth/login_page/login_page.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/home_page.dart';
import 'package:photo_album/presentation/my_albums_page/bloc/my_albums_page_cubit.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/loader.png'), fit: BoxFit.cover)),
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting)
              return Loader();
            else if (!userSnapshot.hasData)
              return BlocProvider(create: (context) => LoginPageCubit(), child: LoginPage());
            else
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => HomePageCubit()),
                  BlocProvider(create: (context) => MyAlbumsPageCubit()),
                ],
                child: HomePage(),
              );
          },
        ),
      ),
    );
  }
}
