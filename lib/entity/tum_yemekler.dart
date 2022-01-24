class TumYemekler {
  String yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  String yemek_fiyat;

  TumYemekler(
      {required this.yemek_id,required this.yemek_adi,required this.yemek_resim_adi,required this.yemek_fiyat});

  factory TumYemekler.fromJson(Map<String,dynamic> json) {
    return TumYemekler(yemek_id: json["yemek_id"], yemek_adi: json["yemek_adi"], yemek_resim_adi: json["yemek_resim_adi"], yemek_fiyat: json["yemek_fiyat"]);
  }
}