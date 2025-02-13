import 'package:chatxfirebase/Services/Auth_Services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()async{
              final auth = AuthService();
              await auth.logout();
            },
            child: Center(
              child: Icon(Icons.logout,size: 60,),
            ),
          )
        ],
      ),
    );
  }
}
