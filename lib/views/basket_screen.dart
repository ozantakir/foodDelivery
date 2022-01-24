import 'package:bitirme_odev/cubit/basket_screen_cubit.dart';
import 'package:bitirme_odev/entity/sepetteki_yemekler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BasketScreen> {
  var tfPrice = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BasketScreenCubit>().sepetiYukle("ozan_takir");
  }

  @override
  Widget build(BuildContext context) {
    var totalPrice = 0;
     return BlocBuilder<BasketScreenCubit,List<SepettekiYemekler>>(builder: (context,sepettekiYemeklerListesi){
         return Scaffold(
           appBar: AppBar(
             backgroundColor: Colors.red,
             title: Text("Sepetim"),
           ),
           body: sepettekiYemeklerListesi.isNotEmpty ? ListView.builder(
               itemCount: sepettekiYemeklerListesi.length,
               itemBuilder: (context,index){
                 var sepettekiYemek = sepettekiYemeklerListesi[index];
                 return Card(
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
                             child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepettekiYemek.yemek_resim_adi}")),
                         Padding(
                           padding: const EdgeInsets.only(left: 20.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("${sepettekiYemek.yemek_adi}  x${sepettekiYemek.yemek_siparis_adet}",style: TextStyle(fontSize: 20,color: Colors.black),),
                               SizedBox(height: 10,),
                               Text("${int.parse(sepettekiYemek.yemek_fiyat) * int.parse(sepettekiYemek.yemek_siparis_adet)}₺",style: TextStyle(fontSize: 18,color: Colors.black54),),
                             ],
                           ),
                         ),
                         Spacer(),
                         IconButton(onPressed: (){
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               behavior: SnackBarBehavior.floating,
                               content: Text("${sepettekiYemek.yemek_adi} sepetinizden çıkarılsın mı?"),
                               action: SnackBarAction(
                                 label: "Evet",
                                 onPressed: (){
                                   if(sepettekiYemeklerListesi.length > 1){
                                     context.read<BasketScreenCubit>().yemekSil(int.parse(sepettekiYemek.sepet_yemek_id), "ozan_takir");
                                   } else {
                                     context.read<BasketScreenCubit>().yemekSil(int.parse(sepettekiYemek.sepet_yemek_id), "ozan_takir");
                                     context.read<BasketScreenCubit>().bosSepetYukle();
                                   }
                                 },
                               ),
                             ),
                           );
                         }, icon: Icon(Icons.delete_outline))
                       ],
                     ),
                   ),
                 );
               }
           ) : Center(),
           floatingActionButton: Padding(
             padding: const EdgeInsets.only(bottom: 50.0),
             child: FloatingActionButton.extended(
               label: Text("Devam"),
               backgroundColor: Colors.black,
               onPressed: (){

               },
             ),
           ),
         );

    });
  }
}
