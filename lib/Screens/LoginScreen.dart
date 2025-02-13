import 'dart:developer';
import 'package:chatxfirebase/Screens/RegisterScreen.dart';
import 'package:chatxfirebase/Services/Auth_Services.dart';
import 'package:chatxfirebase/Utils/CustomBTN.dart';
import 'package:chatxfirebase/Utils/CustomTF.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailClt = TextEditingController();
  final _passClt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              'Welcome Back ,you\'ve been missed! ',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTF(text: 'username', obscure: false, clt: _emailClt),
            const SizedBox(
              height: 8,
            ),
            CustomTF(text: 'password', obscure: true, clt: _passClt),
            const SizedBox(
              height: 25,
            ),
            CustomBTN(
              text: 'Login',
              onPressed: () async {
                AuthService auth = AuthService();
                try {
                  await auth.signInWthEmail(_emailClt.text, _passClt.text);
                } catch (e) {
                  log(e.toString());
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('User Not Register !!',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),),
                          ));
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have account?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()));
                  },
                  child: Text(
                    ' Register here ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
