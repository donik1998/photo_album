import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_album/presentation/pages/all_templates_page/all_templates_page.dart';
import 'package:photo_album/presentation/pages/auth/login_page/login_page.dart';
import 'package:photo_album/presentation/pages/auth/login_with_email_page/login_with_email_page.dart';
import 'package:photo_album/presentation/pages/editor_page/editor_page.dart';
import 'package:photo_album/presentation/pages/root/root_page.dart';
import 'package:photo_album/presentation/state/all_templates_page_state/all_templates_page_state.dart';
import 'package:photo_album/presentation/state/auth/login_page_state.dart';
import 'package:photo_album/presentation/state/auth/login_with_email_page_state.dart';
import 'package:photo_album/presentation/state/editor_page_state.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [
    SystemUiOverlay.bottom,
    SystemUiOverlay.top,
  ]);
  //
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AppRoutes.LOGIN_WITH_EMAIL_PAGE: (context) => ChangeNotifierProvider(
              create: (context) => LoginWithEmailPageState(),
              child: LoginWithEmailPage(),
            ),
        AppRoutes.ROOT_PAGE: (context) => RootPage(),
        AppRoutes.ALL_TEMPLATES_PAGE: (context) => ChangeNotifierProvider(
              create: (_) => AllTemplatesPageState(),
              child: AllTemplatesPage(),
            ),
        AppRoutes.LOGIN_PAGE: (context) => ChangeNotifierProvider(
              create: (context) => LoginPageState(),
              child: LoginPage(),
            ),
        AppRoutes.EDITOR_PAGE: (context) => ChangeNotifierProvider(
              create: (context) => RedactorPageState(),
              child: RedactorPage(),
            ),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          titleTextStyle: AppTextStyles.ttxt1,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      initialRoute: AppRoutes.ROOT_PAGE,
    );
  }
}
