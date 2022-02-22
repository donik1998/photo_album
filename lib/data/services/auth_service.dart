import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();
  final GoogleSignIn _googleSignInPlugin = GoogleSignIn();
  static AuthService get instance => AuthService._();

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return await _createAccountWithEmailAndPassword(email, password);
      } else {
        return false;
      }
    }
  }

  Future<bool> _createAccountWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      print('1');
      final isLoggedIn = await _googleSignInPlugin.isSignedIn();
      print('is in: $isLoggedIn');
      final googleUser = await _googleSignInPlugin.signIn();
      print('2');
      final googleUserAuth = await googleUser?.authentication;
      print('3');
      final credential = GoogleAuthProvider.credential(idToken: googleUserAuth?.idToken, accessToken: googleUserAuth?.accessToken);
      print('4');
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('5');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    final hasGoogleAccount = await _googleSignInPlugin.isSignedIn();
    if (hasGoogleAccount) await _googleSignInPlugin.signOut();
    if (FirebaseAuth.instance.currentUser?.uid != null) await FirebaseAuth.instance.signOut();
  }
}
