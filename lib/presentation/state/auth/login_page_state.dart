import 'package:photo_album/data/services/auth_service.dart';
import 'package:photo_album/presentation/state/base_provider.dart';

class LoginPageState extends BaseProvider {
  Future<bool> loginWithGoogle() async {
    final signedIn = await AuthService.instance.signInWithGoogle();
    return signedIn;
  }
}
