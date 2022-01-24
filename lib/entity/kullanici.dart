class Kullanici {
  String id;
  String full_name;

  Kullanici({required this.full_name,required this.id});

  factory Kullanici.fromJson(String key, Map<dynamic,dynamic> json) {
    return Kullanici(full_name: json["full_name"] as String, id: key);
  }
}