import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/pages/auth/login_page/login_page.dart';
import 'package:photo_album/presentation/pages/home_page/home_page.dart';
import 'package:photo_album/presentation/state/auth/login_page_state.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) return Loader();
          if (!userSnapshot.hasData)
            return ChangeNotifierProvider(create: (context) => LoginPageState(), child: LoginPage());
          else if (userSnapshot.hasData)
            return HomePage();
          else
            return Container();
        },
      ),
    );
  }
}
