import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserCredential> loginAnonymously() {
    return _auth.signInAnonymously();
  }
}