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
  var tfTitle = TextEditingController();

  var users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30)
            )
        ),
        actions: [
          IconButton(onPressed: (){setState(() {
            edit = true;
          });}, icon: const Icon(Icons.edit)),
          IconButton(onPressed: (){
            context.read<ProfileScreenCubit>().signOut();
          }, icon: const Icon(Icons.logout))
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
            tfTitle.text = data["title"];
            if(mail != null){
              tfMail.text = mail!;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 30,bottom: 100),
                child: Column(
                  children: [
                    TextField(controller: tfName,style: text,enabled: false,
                      decoration: InputDecoration(
                        label: const Text("Ad-Soyad"),
                        labelStyle: label,
                        prefixIcon: Icon(Icons.person,color: black,),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 4,color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextField(controller: tfMail,style: text,enabled: false,
                      decoration: InputDecoration(
                          label: const Text("E-mail"),
                        labelStyle: label,
                        prefixIcon: Icon(Icons.mail,color: black,),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4,color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextField(controller: tfPhone,style: text,enabled: edit,
                      decoration: InputDecoration(
                        label: const Text("Telefon numarası"),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: label,
                        prefixIcon: Icon(Icons.phone,color: black,),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4,color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: orange),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: tfTitle,style: text,enabled: edit,
                            decoration: InputDecoration(
                              label: const Text("Adres Başlığı"),
                              labelStyle: label,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 4,color: grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: orange),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 230,
                          child: TextField(controller: tfIl,style: text,enabled: edit,
                            decoration: InputDecoration(
                              label: const Text("İl"),
                              labelStyle: label,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 4,color: grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: orange),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    TextField(controller: tfIlce,style: text,enabled: edit,
                      decoration: InputDecoration(
                        label: const Text("İlçe"),
                        labelStyle: label,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4,color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: orange),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextField(controller: tfAdress,style: text,enabled: edit,
                      minLines: 2,
                      maxLines: 3,
                      decoration: InputDecoration(
                        label: const Text("Adres"),
                        labelStyle: label,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.home_work,color: black,),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4,color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: orange),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    edit ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(onPressed: (){
                          setState(() {
                            edit = false;
                          });
                        }, child: const Text("İptal"),
                          style: ElevatedButton.styleFrom(
                              primary: black
                          ),),
                        const SizedBox(width: 20,),
                        ElevatedButton(onPressed: (){
                          context.read<ProfileScreenCubit>().register(tfMail.text, tfPhone.text, tfAdress.text,tfName.text,
                          tfIl.text,tfIlce.text,tfTitle.text) ;
                          setState(() {
                            edit = false;
                          });
                        }, child: const Text("Kaydet"),
                        style: ElevatedButton.styleFrom(
                          primary: black
                        ),),
                      ],
                    ) : const Center()
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
