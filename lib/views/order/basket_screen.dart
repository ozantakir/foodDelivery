import 'package:bitirme_odev/cubit/order_cubits/basket_screen_cubit.dart';
import 'package:bitirme_odev/entity/sepetteki_yemekler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BasketScreen> {
  String kayitDegeri = "ozan_takir-${FirebaseAuth.instance.currentUser?.email}";

  @override
  void initState() {
    super.initState();
    context.read<BasketScreenCubit>().sepetiYukle(kayitDegeri);
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
           body: sepettekiYemeklerListesi.isNotEmpty ?  ListView.builder(
               itemCount: sepettekiYemeklerListesi.length,
               itemBuilder: (context,index){
                 var sepettekiYemek = sepettekiYemeklerListesi[index];
                 return Card(
                   elevation: 5,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10),
                     child: Row(
                       children: [
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
                                     context.read<BasketScreenCubit>().yemekSil(int.parse(sepettekiYemek.sepet_yemek_id), kayitDegeri);
                                   } else {
                                     context.read<BasketScreenCubit>().yemekSil(int.parse(sepettekiYemek.sepet_yemek_id), kayitDegeri);
                                     context.read<BasketScreenCubit>().bosSepetYukle();
                                   }
                                 },
                               ),
                             ),
                           );
                         }, icon: Icon(Icons.delete_outline)),
                       ],
                     ),
                   ),
                 );
               }
           ) : Center(),
           floatingActionButton: Padding(
             padding: const EdgeInsets.only(bottom: 50.0),
             child: FloatingActionButton.extended(
               label: Text("Devam  -  ${totalMoney(sepettekiYemeklerListesi)}₺"),
               backgroundColor: Colors.black,
               onPressed: (){

               },
             ),
           ),
         );

    });
  }
}

totalMoney(List<SepettekiYemekler> yemekler) {
  var total = 0;
  for (var element in yemekler) {
    total += int.parse(element.yemek_fiyat) * int.parse(element.yemek_siparis_adet);
  }
  return total;
}
