import 'package:bitirme_odev/views/basket_screen.dart';
import 'package:bitirme_odev/views/home_screen.dart';
import 'package:bitirme_odev/views/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../size_configs.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {

  var tfSearch = TextEditingController();
  int chosenIndex = 0;
  var pageList = [HomeScreen(),BasketScreen(),ProfileScreen()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      body: pageList[chosenIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.home,color: Colors.white,),
          Icon(Icons.shopping_basket,color: Colors.white),
          Icon(Icons.person,color: Colors.white)
        ],
        onTap: (index){
          setState(() {
            chosenIndex = index;
          });
        },
        height: 50,
        color: Colors.red,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
      ),
    );
  }
}
