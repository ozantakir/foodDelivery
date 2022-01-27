import 'package:bitirme_odev/cubit/order_cubits/food_details_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_styles.dart';

class FoodDetails extends StatefulWidget {
  String yemek_resim_adi;
  String name;
  String price;

  FoodDetails({required this.yemek_resim_adi,required this.name,required this.price});

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  String kayitDegeri = "ozan_takir-${FirebaseAuth.instance.currentUser?.email}";
  var siparisAdet = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    title: Row(
    children: [
    IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.cancel_outlined,color: black,),splashRadius: 20,),
    ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
                color: black
            ),
            height: 100,
            child: Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget
                    .yemek_resim_adi}")),
        Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 10),
          child: Text(widget.name,
              style: text),
        ),
        const SizedBox(height: 10,),
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        ,style: subText,textAlign: TextAlign.center,),
        const SizedBox(height: 10,),
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: orange,width: 2)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {
                if (siparisAdet > 1) {
                  setState(() {
                    siparisAdet -= 1;
                  });
                }
              },
                icon: Icon(Icons.indeterminate_check_box_sharp,color: orange,),
                splashRadius: 20,),
              Text("$siparisAdet",style: text,),
              IconButton(onPressed: () {
                setState(() {
                  siparisAdet += 1;
                });
              }, icon: const Icon(Icons.add), splashRadius: 20,color: orange,),
            ],
          ),
        ),
        const SizedBox(height: 15,),
        ElevatedButton(onPressed: () {
          context.read<FoodDetailsCubit>().sepetEkle(
              widget.name, widget.yemek_resim_adi, widget.price,
              siparisAdet.toString(), kayitDegeri);
          Navigator.pop(context);
        }, child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Sepete Ekle  -  ",),
            Text("${int.parse(widget.price) * siparisAdet}₺",)
          ],
        ),
          style: ElevatedButton.styleFrom(
            primary: black
          ),
        ),
      ],
    ));
  }
}


