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
      final googleUser = await _googleSignInPlugin.signIn();
      final googleUserAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(idToken: googleUserAuth?.idToken, accessToken: googleUserAuth?.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
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
