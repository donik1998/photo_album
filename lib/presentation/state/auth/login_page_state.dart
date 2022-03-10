import 'package:photo_album/data/services/auth_service.dart';
import 'package:photo_album/presentation/state/base_provider.dart';
import 'package:photo_album/presentation/utils/snack_bar_notifier.dart';

class LoginPageState extends BaseProvider with SnackBarNotifier {
  Future<bool> loginWithGoogle() async {
    final signedIn = await AuthService.instance.signInWithGoogle();
    return signedIn;
  }
}
