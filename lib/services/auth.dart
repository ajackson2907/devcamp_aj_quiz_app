// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  /// Anonymous Firebase login
  Future<void> anonymousLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print(e.stackTrace);
    }
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      print(e.stackTrace);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> loginUser(String userName, String password) async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userName,
        password: password,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> registerUser(String username, String password) async {
    try {
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    return user != null;
  }
}

class User {
  final String userName;
  String? photoURL;
  final String? email;
  User({required this.userName, required this.photoURL, required this.email});
  get displayName => userName;
}
