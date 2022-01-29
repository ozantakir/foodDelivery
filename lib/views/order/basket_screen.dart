import 'dart:async';
import 'package:bitirme_odev/app_styles.dart';
import 'package:bitirme_odev/cubit/order_cubits/basket_screen_cubit.dart';
import 'package:bitirme_odev/entity/sepetteki_yemekler.dart';
import 'package:bitirme_odev/views/order/payment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BasketScreen> {
  String kayitDegeri = "ozan_takir-${FirebaseAuth.instance.currentUser?.email}";
  bool opening = false;
  String dropdownValue = "Ev";

  @override
  void initState() {
    super.initState();
    context.read<BasketScreenCubit>().sepetiYukle(kayitDegeri);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketScreenCubit, List<SepettekiYemekler>>(
        builder: (context, sepettekiYemeklerListesi) {
        return Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            backgroundColor: orange,
            title: Row(
              children: [const Text("Sepetim"), Spacer(),
                const Text("Adres : ",style: TextStyle(fontSize: 20,color: Colors.white),),
                DropdownButton<String>(
                  style: const TextStyle(color: Colors.white,fontSize: 20),
                  dropdownColor: yellow,
                  underline: Container(
                    height: 0,
                  ),
                  value: dropdownValue,
                  items: <String>["Ev","İş"]
                      .map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ],

            ),
          ),
          body: sepettekiYemeklerListesi.isNotEmpty ? ListView.builder(
              itemCount: sepettekiYemeklerListesi.length,
              itemBuilder: (context, index) {

                 sepettekiYemeklerListesi
                     .sort((a, b) => a.yemek_adi.compareTo(b.yemek_adi));

                 if(sepettekiYemeklerListesi.length > 1){
                   if(index < sepettekiYemeklerListesi.length - 1){
                     if(sepettekiYemeklerListesi[index].yemek_adi == sepettekiYemeklerListesi[index+1].yemek_adi){

                       int aNum = int.parse(sepettekiYemeklerListesi[index+1].yemek_siparis_adet);

                       context.read<BasketScreenCubit>().yemekSil(
                           int.parse(sepettekiYemeklerListesi[index+1].sepet_yemek_id), kayitDegeri);

                       addFood(context, sepettekiYemeklerListesi[index], kayitDegeri, aNum);
                     }
                   }
                 }

                 Timer(const Duration(milliseconds: 900), () {
                   setState(() {
                     opening = true;
                   });
                 });

                var sepettekiYemek = sepettekiYemeklerListesi[index];
                return opening
                    ? Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sepettekiYemek.yemek_adi,
                                      style:
                                          TextStyle(fontSize: 20, color: black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${int.parse(sepettekiYemek.yemek_fiyat) * int.parse(sepettekiYemek.yemek_siparis_adet)}₺",
                                      style: subText,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: orange, width: 2)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (int.parse(sepettekiYemek
                                                .yemek_siparis_adet) >
                                            1) {
                                          context
                                              .read<BasketScreenCubit>()
                                              .yemekSil(
                                                  int.parse(sepettekiYemek
                                                      .sepet_yemek_id),
                                                  kayitDegeri);
                                          context
                                              .read<BasketScreenCubit>()
                                              .sepetEkle(
                                                  sepettekiYemek.yemek_adi,
                                                  sepettekiYemek
                                                      .yemek_resim_adi,
                                                  sepettekiYemek.yemek_fiyat,
                                                  (int.parse(sepettekiYemek
                                                              .yemek_siparis_adet) - 1).toString(),
                                                  kayitDegeri);
                                        } else if (int.parse(sepettekiYemek
                                                .yemek_siparis_adet) == 1) {
                                          if (sepettekiYemeklerListesi.length == 1) {
                                            context
                                                .read<BasketScreenCubit>()
                                                .yemekSil(
                                                    int.parse(sepettekiYemek
                                                        .sepet_yemek_id),
                                                    kayitDegeri);
                                            context
                                                .read<BasketScreenCubit>()
                                                .bosSepetYukle();
                                          } else {
                                            context
                                                .read<BasketScreenCubit>()
                                                .yemekSil(
                                                    int.parse(sepettekiYemek
                                                        .sepet_yemek_id),
                                                    kayitDegeri);
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        Icons.indeterminate_check_box_sharp,
                                        color: orange,
                                      ),
                                      splashRadius: 20,
                                    ),
                                    Text(
                                      sepettekiYemek.yemek_siparis_adet,
                                      style:
                                          TextStyle(color: black, fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        addFood(context, sepettekiYemek,
                                            kayitDegeri, 1);

                                      },
                                      icon: const Icon(Icons.add),
                                      splashRadius: 20,
                                      color: orange,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Center();
              }) : const Center(),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: FloatingActionButton.extended(
              label: Text(
                "Devam  -  ${totalMoney(sepettekiYemeklerListesi)}₺",
                style: TextStyle(color: white),
              ),
              backgroundColor: black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                              totalPayment:
                                  "${totalMoney(sepettekiYemeklerListesi)}₺",
                            )));
              },
            ),
          ),
        );
      }
    );
  }
}

totalMoney(List<SepettekiYemekler> yemekler) {
  var total = 0;
  for (var element in yemekler) {
    total +=
        int.parse(element.yemek_fiyat) * int.parse(element.yemek_siparis_adet);
  }
  return total;
}

addFood(
    BuildContext context, SepettekiYemekler sepetYemek, String kayit, int a) {
  context
      .read<BasketScreenCubit>()
      .yemekSil(int.parse(sepetYemek.sepet_yemek_id), kayit);
  context.read<BasketScreenCubit>().sepetEkle(
      sepetYemek.yemek_adi,
      sepetYemek.yemek_resim_adi,
      sepetYemek.yemek_fiyat,
      (int.parse(sepetYemek.yemek_siparis_adet) + a).toString(),
      kayit);
}
