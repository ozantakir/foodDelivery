import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenCubit extends Cubit<void> {
  ProfileScreenCubit():super(0);

  var pRepo = DaoRepository();

  Future<void> signOut() async {
    await pRepo.signOut();
  }

  Future<void> register(String mail,String phone,String address,String name,String city,String district,String title) async {
    await pRepo.registerInfo(mail, phone, address,name,city,district,title);
  }



}