import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWthEmail(String email,password)async{
      try{
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch(e){
          throw Exception(e);
      }
  }

  Future<UserCredential> signUpWthEmail(String email,password)async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e);
    }
  }

  Future<void> logout()async{
      return await _auth.signOut();
  }
}