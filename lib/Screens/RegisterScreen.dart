import 'dart:developer';
import 'package:chatxfirebase/Screens/HomeScreen.dart';
import 'package:chatxfirebase/Screens/LoginScreen.dart';
import 'package:chatxfirebase/Services/Auth_Services.dart';
import 'package:chatxfirebase/Utils/CustomBTN.dart';
import 'package:chatxfirebase/Utils/CustomTF.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailClt = TextEditingController();
  final _passClt = TextEditingController();
  final _conPassClt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(Icons.message,size: 60,color: Theme.of(context).colorScheme.primary,),

            Text('Welcome Back ,you\'ve been missed! ',style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
            ),),

            const SizedBox(height: 25,),

            CustomTF(text: 'username', obscure: false, clt: _emailClt),

            const SizedBox(height: 8,),

            CustomTF(text: 'password', obscure: true, clt: _passClt),

            const SizedBox(height: 8,),

            CustomTF(text: 'confirm password', obscure: true, clt: _conPassClt),

            const SizedBox(height: 25,),

            CustomBTN(text: 'Signup', onPressed: ()async{
              final auth = AuthService();
              if((_emailClt.text.isNotEmpty && _passClt.text.isNotEmpty && _conPassClt.text.isNotEmpty) && (_passClt.text == _conPassClt.text)){
                try{
                  await auth.signUpWthEmail(_emailClt.text, _passClt.text);
                  log("signup");
                  await Future.delayed(const Duration(seconds: 2));

                  // Check if user is signed in
                  if (FirebaseAuth.instance.currentUser != null) {
                    log("Signup success, redirecting to LoginScreen");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) =>  HomeScreen()),
                    );
                  } else {
                    log("Signup successful but user not authenticated");
                  }

                }catch(e){
                  log(e.toString());
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Unable Register !!'),
                      ));
                }
              } else{
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('You Entered Invalid Data please check !!',style: TextStyle(
                      fontWeight: FontWeight.w500,
                          fontSize: 16
                      )),
                    ));
              }
            },),

            const SizedBox(height: 8,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('already have account?',style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                ),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                  },
                  child: Text(' login here ',style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold
                  ),),
                )
              ],
            )


          ],
        ),
      ),
    );
  }
}
