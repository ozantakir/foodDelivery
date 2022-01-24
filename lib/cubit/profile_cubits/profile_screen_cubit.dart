
import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenCubit extends Cubit<void> {
  ProfileScreenCubit():super(0);

  var pRepo = DaoRepository();

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> register(String mail,String phone,String address,String name) async {
    await pRepo.registerInfo(mail, phone, address,name);
  }



}