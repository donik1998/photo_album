import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/auth/login_page/bloc/login_page_cubit.dart';
import 'package:photo_album/presentation/root/root_page.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          titleTextStyle: AppTextStyles.ttxt1,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginPageCubit(), lazy: true),
        ],
        child:RootPage(),
      ),
    );
  }
}
