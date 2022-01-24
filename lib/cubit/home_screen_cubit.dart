import 'package:bitirme_odev/entity/tum_yemekler.dart';
import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<List<TumYemekler>> {
  HomeScreenCubit():super(<TumYemekler>[]);

  var homeRepo = DaoRepository();
  
  Future<void> yemekleriYukle() async {
    var liste = await homeRepo.tumYemekleriAl();
    emit(liste);
  }

}