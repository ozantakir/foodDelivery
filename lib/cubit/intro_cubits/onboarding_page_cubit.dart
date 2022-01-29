import 'package:bitirme_odev/repo/dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPageCubit extends Cubit<void>{
  OnboardingPageCubit():super(0);

  var repo = DaoRepository();

  Future setSeenOnboard() async {
    await repo.setSeenOnboard();
  }
}