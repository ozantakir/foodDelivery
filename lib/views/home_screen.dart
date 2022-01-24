import 'package:bitirme_odev/cubit/home_screen_cubit.dart';
import 'package:bitirme_odev/entity/tum_yemekler.dart';
import 'package:bitirme_odev/views/food_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var tfSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20),
            child: TextField(
              controller: tfSearch,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Arama",
                prefixIcon: const Icon(Icons.search,color: Colors.black,),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.red,
        ),
      ),
      body: BlocBuilder<HomeScreenCubit,List<TumYemekler>>(
          builder: (context,yemeklerListesi){
            if(yemeklerListesi.isNotEmpty){
              return ListView.builder(
                itemCount: yemeklerListesi.length,
                itemBuilder: (context,index){
                  var yemek = yemeklerListesi[index];
                  return GestureDetector(
                    onTap: (){
                      showDialog(context: context, builder: (context) =>
                          FoodDetails(yemek_resim_adi: yemek.yemek_resim_adi, name: yemek.yemek_adi, price: yemek.yemek_fiyat));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(width: 2,color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 100,
                                child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(yemek.yemek_adi,style: TextStyle(fontSize: 20,color: Colors.black),),
                                  SizedBox(height: 10,),
                                  Text("${yemek.yemek_fiyat}₺",style: TextStyle(fontSize: 18,color: Colors.black54),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },

              );
            } else {
              return Center();
            }
          }
      ),
    );




  }
}

