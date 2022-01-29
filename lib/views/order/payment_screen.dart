import 'package:bitirme_odev/app_styles.dart';
import 'package:bitirme_odev/views/order/order_coming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class PaymentScreen extends StatefulWidget {
  String totalPayment;

  PaymentScreen({required this.totalPayment});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  String cardNumber = "";
  String cardHolderName = "";
  String cvvNumber = "";
  String expirationDate = "";
  bool showBack = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void onCreditCardModel(CreditCardModel creditCardModel){
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      cardHolderName = creditCardModel.cardHolderName;
      expirationDate = creditCardModel.expiryDate;
      cvvNumber = creditCardModel.cvvCode;
      showBack = creditCardModel.isCvvFocused;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ödeme"),
        backgroundColor: black,
      ),
      body: Column(
        children: [
          CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expirationDate,
              cardHolderName: cardHolderName,
              obscureCardNumber: false,
              obscureCardCvv: false,
              cvvCode: cvvNumber,
              width: 300,
              height: 200,
              showBackView: showBack,
              isHolderNameVisible: true,
              cardBgColor: black,
              animationDuration: const Duration(milliseconds: 800),
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            ),
          Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onCreditCardModel,
                  cursorColor: orange,
                  themeColor: black,
                  cardNumber: cardNumber,
                  obscureCvv: false,
                  obscureNumber: false,
                  expiryDate: expirationDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvNumber, formKey: formKey,
                ),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Siparişi Onayla  -  ${widget.totalPayment}"),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OrderComing()));
        },
        backgroundColor: black,
      ),
    );
  }

}
