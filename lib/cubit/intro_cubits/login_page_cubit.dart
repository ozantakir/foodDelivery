import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageCubit extends Cubit<void>{
  LoginPageCubit():super(0);


  Future login(String email,String password,context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      var snackBar = SnackBar(content: Text(e.message!),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future resetPw(String email,context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e){
      var snackBar = SnackBar(content: Text(e.message!),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}