import 'package:bitirme_odev/views/main_screens.dart';
import 'package:bitirme_odev/views/login_page.dart';
import 'package:bitirme_odev/views/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../size_configs.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return MainScreens();
        } else {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(sizeV * 35),
                child: AppBar(
                  elevation: 5,
                  backgroundColor: Colors.white,
                  flexibleSpace: Image.asset("pics/logo.png"),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20)
                      )
                  ),
                  bottom: const TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 3.0,color: Colors.deepOrange),
                        insets: EdgeInsets.symmetric(horizontal:20.0)
                    ),
                    labelColor: Colors.black,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),
                    tabs: [
                      Tab(text: "Login",),
                      Tab(text: "Sign-up",),
                    ],
                  ),
                ),
              ),
              body: const TabBarView(
                children: [
                  LoginPage(),
                  SignUpPage()
                ],
              ),
            ),
          );
        }
      }
    );
  }
}
