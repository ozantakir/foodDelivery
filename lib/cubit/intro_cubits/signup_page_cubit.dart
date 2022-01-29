import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPageCubit extends Cubit<void>{
  SignupPageCubit():super(0);

  var signRepo = DaoRepository();

  Future<void> register(String full_name,String mail) async {
    await signRepo.registerPerson(full_name,mail);
  }

  Future signUp(String email,String password, context) async {
    await signRepo.signUp(email, password, context);
  }
}