import 'package:bitirme_odev/cubit/intro_cubits/signup_page_cubit.dart';
import 'package:bitirme_odev/cubit/order_cubits/basket_screen_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_styles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var tfName = TextEditingController();
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();

  @override
  void dispose() {
    tfEmail.dispose();
    tfName.dispose();
    tfPassword.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30,top: 20),
              child: Row(
                children: [
                  Text("Register",style: TextStyle(color: orange,fontSize: 35)),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: ElevatedButton(onPressed: (){},
                        child: Image.asset("pics/google.png"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      fixedSize: const Size(25,25),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 15),
              child: TextField(
                controller: tfName,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Full Name",
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
              padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 15),
              child: TextField(
                controller: tfEmail,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
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
              padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
              child: TextField(
                obscureText: true,
                controller: tfPassword,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Password",
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
            ElevatedButton(onPressed: (){
              context.read<SignupPageCubit>().register(tfName.text,tfEmail.text);
              context.read<SignupPageCubit>().signUp(tfEmail.text, tfPassword.text,context);
            }, child: const Text("Sign-up"),
              style: ElevatedButton.styleFrom(
                primary: orange,
                minimumSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ),
            ),
            TextButton(onPressed: (){
              DefaultTabController.of(context)?.animateTo(0);
            }, child: Text("Already a member?",style: TextStyle(color: black),))
          ],
        ),
      ),
    );
  }
}
