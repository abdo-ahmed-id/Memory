import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:memories/helpers/routes.dart';
import 'package:toast/toast.dart';

class AuthService {
  bool get isLogin => auth.currentUser != null;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> register(
      BuildContext context, String userName, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: '$userName@m.com', password: password);
      User user = userCredential.user;
      if (user != null) {
        Modular.to.pushReplacementNamed(AppRoutes.home);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Toast.show(e.message, context, duration: 2, gravity: Toast.CENTER);
      } else if (e.code == 'email-already-in-use') {
        Toast.show(e.message, context, duration: 2, gravity: Toast.CENTER);
      }
    } catch (e) {
      Toast.show(e.message, context, duration: 2, gravity: Toast.CENTER);
    }
    return null;
  }

  Future<User> signIn(
      BuildContext context, String userName, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: "$userName@m.com", password: password);
      User user = userCredential.user;
      if (user != null) {
        Modular.to.pushReplacementNamed(AppRoutes.home);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Toast.show(e.message, context, duration: 2, gravity: Toast.CENTER);
      } else if (e.code == 'user-not-found') {
        Toast.show(e.message, context, duration: 2, gravity: Toast.CENTER);
      } else if (e.code == 'wrong-password') {
        Toast.show(e.message, context, duration: 2, gravity: Toast.CENTER);
      } else if (e.code == 'user-disabled') {
        Toast.show(e.message, context, duration: 2, gravity: Toast.CENTER);
      }
    } catch (e) {
      Toast.show(e.message, context, duration: 2, gravity: Toast.CENTER);
    }
    return null;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<User> loginOrCreateAccount(bool newAccount, String userName,
      String password, BuildContext context) async {
    return newAccount
        ? signIn(context, userName, password)
        : register(context, userName, password);
  }
}
