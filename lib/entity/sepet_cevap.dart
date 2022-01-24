import 'package:bitirme_odev/entity/sepetteki_yemekler.dart';

class SepetCevap {
  List<SepettekiYemekler> sepettekiYemeklerListesi;
  int success;

  SepetCevap({required this.sepettekiYemeklerListesi,required this.success});

  factory SepetCevap.fromJson(Map<String,dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    List<SepettekiYemekler> sepettekiYemeklerListesi = jsonArray.map((jsonObject) => SepettekiYemekler.fromJson(jsonObject)).toList();
    return SepetCevap(sepettekiYemeklerListesi: sepettekiYemeklerListesi, success: json["success"] as int);
  }
}