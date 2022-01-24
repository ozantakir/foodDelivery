import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';


class OnboardingPageCubit extends Cubit<void>{
  OnboardingPageCubit():super(0);


  Future setSeenOnboard() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    seenOnboard = await sharedPreferences.setBool("seenOnboard", true);
  }
}