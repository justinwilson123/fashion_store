import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../feature/auth/data/models/user_model.dart';
import '../error/exception.dart';

class FirebaseAuthService {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  FirebaseAuthService(this.googleSignIn, this.firebaseAuth);

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future signupWithgoole() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final userEmail = googleUser.email;
      final userName = googleUser.displayName;
      return UserModel(userEmail: userEmail, userFullName: userName!);
    } catch (_) {
      throw GoogleSignInException();
    }
  }

  Future loginWithgoole() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final userEmail = googleUser.email;
      final userName = googleUser.displayName;

      return UserModel(userEmail: userEmail, userFullName: userName!);
    } catch (_) {
      throw GoogleSignInException();
    }
  }

  Future logoutGoogleAccounte() async {
    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
        await firebaseAuth.signOut();
      }
    } catch (_) {
      throw GoogleSignInException();
    }
  }
}
