import 'package:bitirme_odev/views/intro/login_page.dart';
import 'package:bitirme_odev/views/intro/signup_page.dart';
import 'package:bitirme_odev/views/order/main_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';

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
          return const MainScreens();
        } else {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(sizeV * 35),
                child: AppBar(
                  elevation: 10,
                  backgroundColor: Colors.white,
                  flexibleSpace: Image.asset("pics/animation.gif"),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30)
                      )
                  ),
                  bottom: TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 3.0,color: orange),
                        insets: const EdgeInsets.symmetric(horizontal:20.0)
                    ),
                    labelColor: black,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal,fontSize: 16),
                    tabs: const [
                      Tab(text: "Giriş",),
                      Tab(text: "Üye Ol",),
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
