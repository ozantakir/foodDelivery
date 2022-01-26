import 'package:bitirme_odev/app_styles.dart';
import 'package:bitirme_odev/views/order/basket_screen.dart';
import 'package:bitirme_odev/views/order/home_screen.dart';
import 'package:bitirme_odev/views/profile/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {

  int chosenIndex = 0;
  var pageList = [HomeScreen(),BasketScreen(),ProfileScreen()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      body: pageList[chosenIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.home,color: white,),
          Icon(Icons.shopping_basket,color: white),
          Icon(Icons.person,color: white)
        ],
        onTap: (index){
          setState(() {
            chosenIndex = index;
          });
        },
        height: 50,
        color: orange,
        buttonBackgroundColor: orange,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
      ),
    );
  }
}
