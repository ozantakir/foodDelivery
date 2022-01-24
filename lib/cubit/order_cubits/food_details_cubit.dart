import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetailsCubit extends Cubit<void> {
  FoodDetailsCubit():super(0);

  var addRepo = DaoRepository();

  Future<void> sepetEkle(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,
      String yemek_siparis_adet,String kullanici_adi) async {
    await addRepo.sepetEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
}
}