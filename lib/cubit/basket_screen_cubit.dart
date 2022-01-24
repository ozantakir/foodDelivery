import 'package:bitirme_odev/entity/sepetteki_yemekler.dart';
import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketScreenCubit extends Cubit<List<SepettekiYemekler>> {
  BasketScreenCubit():super(<SepettekiYemekler>[]);

  var basketRepo = DaoRepository();

  Future<void> sepetiYukle(String kullanici_adi) async {
    var list = await basketRepo.sepettekiYemekleriAl(kullanici_adi);
    emit(list);
  }
  Future<void> bosSepetYukle() async {
    var list = await <SepettekiYemekler>[];
    emit(list);
  }

  Future<void> yemekSil(int sepet_yemek_id,String kullanici_adi) async {
    await basketRepo.yemekSil(sepet_yemek_id, kullanici_adi);
    await sepetiYukle(kullanici_adi);
  }

  Future<void> sonYemekSil(int sepet_yemek_id,String kullanici_adi) async {
    await basketRepo.yemekSil(sepet_yemek_id, kullanici_adi);
  }
  Future<void> fiyatAl(int yemek_fiyat,int yemek_adet) async {
    var total = 0;
    total += yemek_fiyat * yemek_adet;
  }
}