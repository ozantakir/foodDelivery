import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageCubit extends Cubit<void>{
  LoginPageCubit():super(0);

  var repo = DaoRepository();

  Future login(String email,String password,context) async {
    await repo.login(email, password, context);
  }

  Future resetPw(String email,context) async {
    await repo.resetPw(email, context);
  }

}