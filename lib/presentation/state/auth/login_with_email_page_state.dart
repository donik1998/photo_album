import 'package:flutter/material.dart';
import 'package:photo_album/data/services/auth_service.dart';
import 'package:photo_album/presentation/state/base_provider.dart';
import 'package:photo_album/presentation/utils/routes.dart';

class LoginWithEmailPageState extends BaseProvider {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginWithEmailAndPassword(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      setLoading(true);
      await AuthService.instance.loginWithEmailAndPassword(emailController.text, passwordController.text);
      setLoading(false);
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.ROOT_PAGE, (route) => false);
    }
  }
}
