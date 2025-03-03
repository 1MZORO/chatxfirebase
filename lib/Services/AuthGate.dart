import 'package:chatxfirebase/Screens/HomeScreen.dart';
import 'package:chatxfirebase/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return  HomeScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
