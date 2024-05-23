// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/HomePage.dart';
import 'package:flutter_application_2/booking_interface.dart';
import 'package:flutter_application_2/map_for_passenger.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'main_page.dart';
class PaymentPage extends StatefulWidget {
  final String seat_number;
  final String chosen_line;

  const PaymentPage({super.key, required this.seat_number, required this.chosen_line});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  Future<void> UpdateSeatStatus(String index) async{
        if(widget.chosen_line=="amman"){
          await FirebaseFirestore.instance.collection("bus_seats_for_amman")
        .doc("seat_${index.toString()}").update({"reserved":true});
        }

        else if(widget.chosen_line=="jerash"){
          await FirebaseFirestore.instance.collection("bus_seats_for_jerash")
        .doc("seat_${index.toString()}").update({"reserved":true});
        }
        else{
          await FirebaseFirestore.instance.collection("bus_seats_for_ajloun")
        .doc("seat_${index.toString()}").update({"reserved":true});
        }
        
      }

      @override
  void initState() {
    print(widget.chosen_line);
    super.initState();
  }
      

  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  String cardNumber="";
  String expiryDate="";
  String cardHolderName="";
  String cvvCode="";
  bool isCvvFocused=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:  Text("Checkout"),
        centerTitle: true,
      ),
      body: Column(children: [
        CreditCardWidget(
          cardBgColor: Colors.deepPurple,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          showBackView: isCvvFocused,
          onCreditCardWidgetChange: (p0){}
          ),
          CreditCardForm(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (data){
              setState(() {
                cardNumber=data.cardNumber;
                expiryDate=data.expiryDate;
                cardHolderName=data.cardHolderName;
                cvvCode=data.cvvCode;
              });
            },
            formKey: formKey),
            SizedBox(height: 20,),
            MaterialButton(onPressed:() {
            if(formKey.currentState!.validate()){
              showDialog(context: context,
              builder: (context)=>AlertDialog(
                title: const Text("Confirm Payment"),
                content: SingleChildScrollView(
                  child: ListBody(children: [
                    Text("Card Number: $cardNumber"),
                    Text("Expiry Date: $expiryDate"),
                    Text("Card Holder Name: $cardHolderName"),
                    Text("Cvv: $cvvCode")
                  ],),
                ),
                actions: [
                  TextButton(
                  onPressed:() async{
                    await  UpdateSeatStatus(widget.seat_number);
                    Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                    (route) => false, // Always return false to remove all routes
                    );
                  },
                  child: Text("Yes")),
                  TextButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text("Cancel"))
                ],
              ));
            }
        },
        minWidth: 300,
        child: Text('Pay Now'),
        color: Colors.deepPurple,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
        ),
        )
      ],),
    );
  }
}