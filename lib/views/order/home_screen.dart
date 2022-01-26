import 'package:bitirme_odev/cubit/order_cubits/home_screen_cubit.dart';
import 'package:bitirme_odev/entity/tum_yemekler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_styles.dart';
import 'food_details.dart';

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
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: Text("Menü"),
        backgroundColor: orange,
      ),
      body: BlocBuilder<HomeScreenCubit, List<TumYemekler>>(
          builder: (context, yemeklerListesi) {
        if (yemeklerListesi.isNotEmpty) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              // childAspectRatio: 1 / 1,
              mainAxisSpacing: 10.0,
            ),
            itemCount: yemeklerListesi.length,
            itemBuilder: (context, index) {
              var yemek = yemeklerListesi[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => FoodDetails(
                          yemek_resim_adi: yemek.yemek_resim_adi,
                          name: yemek.yemek_adi,
                          price: yemek.yemek_fiyat));
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(width: 2, color: black)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 100,
                            child: Image.network(
                                "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                        Text(
                          "${yemek.yemek_adi}",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff272D2F)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${yemek.yemek_fiyat}₺",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
