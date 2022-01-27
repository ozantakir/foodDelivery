import 'package:bitirme_odev/entity/sepet_cevap.dart';
import 'package:bitirme_odev/entity/sepetteki_yemekler.dart';
import 'package:bitirme_odev/entity/tum_yemekler_cevap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bitirme_odev/entity/tum_yemekler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class DaoRepository {

  // Shared Pref

  Future setSeenOnboard() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    seenOnboard = await sharedPreferences.setBool("seenOnboard", true);
  }

  // Firebase auth

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

  Future signUp(String email,String password, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      var snackBar = SnackBar(content: Text(e.message!),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Firestore

  Future<void> registerPerson(String full_name,String mail) async {
    var users = FirebaseFirestore.instance.collection("users").doc(mail);
    var json = {
      "full_name": full_name,
      "phone": "",
      "address":"",
      "city":"",
      "district":"",
      "title":""
    };
    await users.set(json);
  }
  Future<void> registerInfo(String mail,String phone,String address,String name,String city,String district,String title) async {
    var users = FirebaseFirestore.instance.collection("users").doc(mail);
    var json = {
      "full_name": name,
      "phone": phone,
      "address":address,
      "city": city,
      "district": district,
      "title": title
    };
    await users.set(json);
  }

  // http

  List<TumYemekler> parseYemeklerCevap(String cevap){
    return TumYemeklerCevap.fromJson(json.decode(cevap)).yemeklerListesi;
  }

  Future<List<TumYemekler>> tumYemekleriAl() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");

    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }

  Future<void> sepetEkle(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,
      String yemek_siparis_adet,String kullanici_adi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var data = {"yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi};
    var cevap = await http.post(url,body: data);
    print(cevap.body);
  }
  
  Future<void> yemekSil(int sepet_yemek_id,String kullanici_adi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var data = {"sepet_yemek_id":sepet_yemek_id.toString(),"kullanici_adi":kullanici_adi};
    await http.post(url,body: data);
  }

  List<SepettekiYemekler> parseSepetCevap(String cevap){
    return SepetCevap.fromJson(json.decode(cevap)).sepettekiYemeklerListesi;
  }

  Future<List<SepettekiYemekler>> sepettekiYemekleriAl(String kullanici_adi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var data = {"kullanici_adi":kullanici_adi};
    var answer = await http.post(url,body: data);
    return parseSepetCevap(answer.body);
  }


}