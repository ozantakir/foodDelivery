import 'package:bitirme_odev/entity/tum_yemekler.dart';

class TumYemeklerCevap {
  List<TumYemekler> yemeklerListesi;
  int success;

  TumYemeklerCevap({required this.yemeklerListesi,required this.success});

  factory TumYemeklerCevap.fromJson(Map<String,dynamic> json){
    var jsonArray = json["yemekler"] as List;
    List<TumYemekler> yemeklerListesi = jsonArray.map((jsonOnject) => TumYemekler.fromJson(jsonOnject)).toList();
    return TumYemeklerCevap(yemeklerListesi: yemeklerListesi, success: json["success"] as int);
  }
}