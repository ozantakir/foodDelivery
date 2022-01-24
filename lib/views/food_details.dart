import 'package:bitirme_odev/cubit/food_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetails extends StatefulWidget {
  String yemek_resim_adi;
  String name;
  String price;


  FoodDetails({required this.yemek_resim_adi,required this.name,required this.price});

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {

  var tfNote = TextEditingController();
  var siparisAdet = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    title: SizedBox(
      height: 20,
      child: Row(
      children: [
      IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.cancel_outlined),splashRadius: 20,),
      ],
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
                color: Colors.black
            ),
            height: 100,
            child: Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget
                    .yemek_resim_adi}")),
        Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
          child: Text("${widget.name}",
              style: TextStyle(fontSize: 20, color: Colors.black)),
        ),
        TextField(
          controller: tfNote,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: "Sipariş notunuzu girebilirsiniz..",
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 2, color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              if (siparisAdet > 1) {
                setState(() {
                  siparisAdet -= 1;
                });
              }
            },
              icon: Icon(Icons.indeterminate_check_box_sharp),
              splashRadius: 20,),
            Text("$siparisAdet"),
            IconButton(onPressed: () {
              setState(() {
                siparisAdet += 1;
              });
            }, icon: Icon(Icons.add), splashRadius: 20,),
          ],
        ),
        ElevatedButton(onPressed: () {
          context.read<FoodDetailsCubit>().sepetEkle(
              widget.name, widget.yemek_resim_adi, widget.price,
              siparisAdet.toString(), "ozan_takir");
          Navigator.pop(context);
        }, child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Sepete Ekle  -  "),
            Text("${int.parse(widget.price) * siparisAdet}₺",)
          ],
        ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black87
          ),
        ),

      ],
    ));
  }
}


