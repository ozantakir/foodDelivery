
import 'package:bitirme_odev/cubit/profile_cubits/profile_screen_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../app_styles.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool edit = false;
  var mail = FirebaseAuth.instance.currentUser?.email;
  var tfName = TextEditingController();
  var tfAdress = TextEditingController();
  var tfMail = TextEditingController();
  var tfPhone = TextEditingController();
  var tfIl = TextEditingController();
  var tfIlce = TextEditingController();

  var users = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30)
            )
        ),
        actions: [
          IconButton(onPressed: (){setState(() {
            edit = true;
          });}, icon: Icon(Icons.edit)),
          PopupMenuButton(itemBuilder: (BuildContext context) => [
            PopupMenuItem(child: Text("Çıkış Yap"),value: 0,),
            PopupMenuItem(child: Text("Hesabı Sil"),value: 1,),
          ],
          onSelected: (value){
            if(value == 0){
              context.read<ProfileScreenCubit>().signOut();
            }
          },
          )
        ],
        backgroundColor: orange,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser?.email).get(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            tfName.text = data["full_name"];
            tfPhone.text = data["phone"];
            tfAdress.text = data["address"];
            tfIl.text = data["city"];
            tfIlce.text = data["district"];
            if(mail != null){
              tfMail.text = mail!;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(controller: tfName,style: TextStyle(fontSize: 20),enabled: false,
                      decoration: InputDecoration(
                        label: Text("Ad-Soyad"),
                        labelStyle: TextStyle(fontSize: 20,color: Colors.deepOrange),
                        prefixIcon: Icon(Icons.person,color: Colors.black,),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 4,color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(controller: tfMail,style: TextStyle(fontSize: 20),enabled: false,
                      decoration: InputDecoration(
                          label: Text("E-mail"),
                        labelStyle: TextStyle(fontSize: 20,color: Colors.deepOrange),
                        prefixIcon: Icon(Icons.mail,color: Colors.black,),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 4,color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(controller: tfPhone,style: TextStyle(fontSize: 20),enabled: edit,
                      decoration: InputDecoration(
                        label: Text("Telefon numarası"),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(fontSize: 20,color: Colors.deepOrange),
                        prefixIcon: Icon(Icons.phone,color: Colors.black,),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 4,color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 170,
                          child: TextField(controller: tfIl,style: TextStyle(fontSize: 20),enabled: edit,
                            decoration: InputDecoration(
                              label: Text("İl"),
                              labelStyle: TextStyle(fontSize: 20,color: Colors.deepOrange),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 4,color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: TextField(controller: tfIlce,style: TextStyle(fontSize: 20),enabled: edit,
                            decoration: InputDecoration(
                              label: Text("İlçe"),
                              labelStyle: TextStyle(fontSize: 20,color: Colors.deepOrange),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 4,color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    TextField(controller: tfAdress,style: TextStyle(fontSize: 20),enabled: edit,
                      minLines: 2,
                      maxLines: 3,
                      decoration: InputDecoration(
                        label: Text("Adres"),
                        labelStyle: TextStyle(fontSize: 20,color: Colors.deepOrange),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.home_work,color: Colors.black,),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 4,color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    edit ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(onPressed: (){
                          setState(() {
                            edit = false;
                          });
                        }, child: Text("İptal"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black
                          ),),
                        SizedBox(width: 20,),
                        ElevatedButton(onPressed: (){
                          context.read<ProfileScreenCubit>().register(tfMail.text, tfPhone.text, tfAdress.text,tfName.text,
                          tfIl.text,tfIlce.text) ;
                          setState(() {
                            edit = false;
                          });
                        }, child: Text("Kaydet"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black
                        ),),
                      ],
                    ) : Center()
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}