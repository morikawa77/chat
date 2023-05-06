import 'package:firebase_auth/firebase_auth.dart';

class AnonymousAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential;
    } catch (e) {
      // ignore: avoid_print
      print("Error signing in anonymously: $e");
      return null;
    }
  }
}