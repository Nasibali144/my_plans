import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_plans/pages/signin_page.dart';
import 'package:my_plans/services/pref_service.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<FirebaseUser> signInUser(BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser firebaseUser = await _auth.currentUser();
      print(firebaseUser.toString());
      return firebaseUser;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<FirebaseUser> signUpUser(BuildContext context, String name, String email, String password) async {
    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;

      print(firebaseUser.toString());
      return firebaseUser;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Prefs.removeUserId().then((value) => {
      Navigator.pushReplacementNamed(context, SignInPage.id)
    });
  }
}