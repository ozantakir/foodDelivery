import 'dart:collection';
import 'package:bitirme_odev/entity/sepet_cevap.dart';
import 'package:bitirme_odev/entity/sepetteki_yemekler.dart';
import 'package:bitirme_odev/entity/tum_yemekler_cevap.dart';
import 'package:bitirme_odev/views/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bitirme_odev/entity/tum_yemekler.dart';

class DaoRepository {

  var refSignPerson = FirebaseDatabase.instance.reference().child("signed up people");
  var users = FirebaseFirestore.instance.collection("users");

  Future<void> registerPerson(String full_name) async {
    return users.add({
      "full_name": full_name
    }).then((value){}).catchError((onError) => print(onError));
  }

  Future<void> deleteMember(String person_id) async {
    refSignPerson.child(person_id).remove();
  }

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