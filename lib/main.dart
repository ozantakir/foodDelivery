import 'package:bitirme_odev/cubit/basket_screen_cubit.dart';
import 'package:bitirme_odev/cubit/food_details_cubit.dart';
import 'package:bitirme_odev/cubit/home_screen_cubit.dart';
import 'package:bitirme_odev/cubit/login_page_cubit.dart';
import 'package:bitirme_odev/cubit/onboarding_page_cubit.dart';
import 'package:bitirme_odev/cubit/profile_screen_cubit.dart';
import 'package:bitirme_odev/cubit/signup_page_cubit.dart';
import 'package:bitirme_odev/views/onboarding_page.dart';
import 'package:bitirme_odev/views/sign_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? seenOnboard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  seenOnboard = sharedPreferences.getBool("seenOnboard") ?? false;

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingPageCubit()),
        BlocProvider(create: (context) => LoginPageCubit()),
        BlocProvider(create: (context) => SignupPageCubit()),
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => FoodDetailsCubit()),
        BlocProvider(create: (context) => BasketScreenCubit()),
        BlocProvider(create: (context) => ProfileScreenCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: seenOnboard == true ? SignPage() : OnboardPage(),
      ),
    );
  }
}


