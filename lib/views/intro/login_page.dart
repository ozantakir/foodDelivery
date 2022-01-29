import 'package:bitirme_odev/cubit/intro_cubits/login_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool forgotPw = true;
  var tfMail = TextEditingController();
  var tfPw = TextEditingController();
  var tfForgot = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: forgotPw ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 30),
              child: TextField(
                controller: tfMail,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(Icons.email_outlined,color: black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: orange),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
              child: TextField(
                obscureText: true,
                controller: tfPw,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Parola",
                  prefixIcon: Icon(Icons.password,color: black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: orange),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              context.read<LoginPageCubit>().login(tfMail.text, tfPw.text,context);
            }, child: const Text("Giriş"),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              primary: orange,
              minimumSize: const Size(200, 40)
            ),
            ),
            const SizedBox(height: 30,),
            TextButton(onPressed: (){
              setState(() {
                forgotPw = false;
              });
            }, child: Text("Parolanızı mı unuttunuz?",style: subTitle,)),

          ],
        ) : Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(children: [IconButton(onPressed: (){setState(() {
                forgotPw = true;
              });}, icon: const Icon(Icons.arrow_back))],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Row(children : [
                Text("Parolanızı mı\nunuttunuz?",style: TextStyle(color: orange,fontSize: 35),)
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: tfForgot,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined,color: black,),
                  hintText: "E-mail",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: orange),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Text("Parolanızı sıfırlamak için bir mail göndereceğiz.",style: TextStyle(color: black),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(onPressed: (){
                context.read<LoginPageCubit>().resetPw(tfForgot.text,context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("E-mail gönderildi")));
                setState(() {
                  forgotPw = true;
                });
              }, child: const Text("Parolayı Sıfırla"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: orange,
                    minimumSize: const Size(200, 40)
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
