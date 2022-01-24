import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPageCubit extends Cubit<void>{
  SignupPageCubit():super(0);

  var signRepo = DaoRepository();

  Future<void> register(String full_name) async {
    await signRepo.registerPerson(full_name);
  }

  Future signUp(String email,String password, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      var snackBar = SnackBar(content: Text(e.message!),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}