import 'dart:async';

import 'package:bitirme_odev/views/order/main_screens.dart';
import 'package:flutter/material.dart';

class OrderComing extends StatefulWidget {
  const OrderComing({Key? key}) : super(key: key);

  @override
  _OrderComingState createState() => _OrderComingState();
}

class _OrderComingState extends State<OrderComing> {
  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 3), (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainScreens()),(Route<dynamic> route) => false);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 80,),
          Image.asset("pics/delivery.gif"),
          const Text("Geliyoruzzz..",style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }
}
