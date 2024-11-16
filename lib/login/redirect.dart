import 'package:fieldapp_functionality/home/home.dart';
import 'package:fieldapp_functionality/login/login.dart';
import 'package:fieldapp_functionality/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Redirect extends StatelessWidget {
  const Redirect({super.key});

  static const routeName = 'redirect';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        });
  }
}
