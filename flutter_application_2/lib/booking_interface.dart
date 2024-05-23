// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/cities.dart';
import 'package:flutter_application_2/payment_page.dart';

class BookingInterface extends StatefulWidget {
  final String chosen_line;
  const BookingInterface({super.key,required this.chosen_line});

  @override
  State<BookingInterface> createState() => _BookingInterfaceState();
}

class _BookingInterfaceState extends State<BookingInterface> {
  void initState() {
    print(widget.chosen_line);
    super.initState();
  }
  bool seat_status=true;


    Future<void> UpdateSeatStatus(int index) async{
        
        await FirebaseFirestore.instance.collection("bus_seats")
        .doc("seat_${index.toString()}").update({"reserved":true});
      }

      //////check seat is reserved or not//////////////
      Future<bool> SeatStatus(int index) async {
        if (widget.chosen_line=="jerash") {
          bool isReserved =false;
        await FirebaseFirestore.instance
        .collection('bus_seats_for_jerash')
        .doc("seat_${index.toString()}") 
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Seat document found
        var seatData = documentSnapshot.data() as Map<String, dynamic>;
        isReserved=  seatData['reserved'];
        
        if (!isReserved) {
          // Seat is available
          seat_status=false;
        } else {
          // Seat is occupied
          seat_status=true;
        }
      } 
    }).catchError((error) {
      print('Error fetching data: $error');
    });
    return seat_status;
        }
        else if (widget.chosen_line=="ajloun") {
          bool isReserved =false;
        await FirebaseFirestore.instance
        .collection('bus_seats_for_ajloun')
        .doc("seat_${index.toString()}") 
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Seat document found
        var seatData = documentSnapshot.data() as Map<String, dynamic>;
        isReserved=  seatData['reserved'];
        
        if (!isReserved) {
          // Seat is available
          seat_status=false;
        } else {
          // Seat is occupied
          seat_status=true;
        }
      } 
    }).catchError((error) {
      print('Error fetching data: $error');
    });
    return seat_status;
        }
        else {
        bool isReserved =false;
        await FirebaseFirestore.instance
        .collection('bus_seats_for_amman')
        .doc("seat_${index.toString()}") 
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Seat document found
        var seatData = documentSnapshot.data() as Map<String, dynamic>;
        isReserved=  seatData['reserved'];
        
        if (!isReserved) {
          // Seat is available
          seat_status=false;
        } else {
          // Seat is occupied
          seat_status=true;
        }
      } 
    }).catchError((error) {
      print('Error fetching data: $error');
    });
    return seat_status;
    }
  }
      /////////check seat is reserved or not//////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
body:
      Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30,vertical:40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8),
                    color: Colors.grey),
                    width: 25,
                    height: 25),
                    Text("Empty"),
                ],
              ),
              
                Row(
                  children: [
                    Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple,),
                    width: 25,
                    height: 25),
                    Text("Reserved"),
                  ],
                ),
        
            ],),
        
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin:EdgeInsets.symmetric(horizontal: 15,vertical: 20) ,
                child:Row(children: [
                  GestureDetector(
                    onTap:() async {
                      if(!await SeatStatus(1)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '1', chosen_line: widget.chosen_line,);
                      }));
                      }
                    },
                    child: FutureBuilder<bool>(
                          future: SeatStatus(1),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("1",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),),
                        GestureDetector(
                          onTap:() async{
                            if(!await SeatStatus(2)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '2', chosen_line: widget.chosen_line,);
                      }));
                            }
                          },
                          child: FutureBuilder<bool>(
                          future: SeatStatus(2),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("2",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                        ),
                        
                ],)),
                GestureDetector(
                  onTap:() async{
                      if(!await SeatStatus(3)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '3', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          },
                  child: FutureBuilder<bool>(
                          future: SeatStatus(3),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("3",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin:EdgeInsets.symmetric(horizontal: 15,vertical: 20) ,
                child:Row(children: [
                  GestureDetector(
                    onTap:() async{
                      
                          
                      if(!await SeatStatus(4)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '4', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          },
                    child: FutureBuilder<bool>(
                          future: SeatStatus(4),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("4",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                  ),
                        GestureDetector(
                          onTap:()async {
                            
                      if(!await SeatStatus(5)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '5', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          
                          },
                          child: FutureBuilder<bool>(
                          future: SeatStatus(5),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("5",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                        ),
                ],)),
                GestureDetector(
                      onTap:() async{
                        
                      if(!await SeatStatus(6)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '6', chosen_line: widget.chosen_line,);
                      }));
                      }
                      
                      
                      },

                  child: FutureBuilder<bool>(
                          future: SeatStatus(6),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("6",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin:EdgeInsets.symmetric(horizontal: 15,vertical: 20) ,
                child:Row(children: [
                  GestureDetector(
                    onTap:() async{
                      
                      if(!await SeatStatus(7)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '7', chosen_line: widget.chosen_line,);
                      }));
                      }
                      
                      
                      },
                    child: FutureBuilder<bool>(
                          future: SeatStatus(7),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("7",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                  ),
                        GestureDetector(
                          onTap:() async{
                      if(!await SeatStatus(8)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '8', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          
                          
                          },
                          child: FutureBuilder<bool>(
                          future: SeatStatus(8),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("8",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                        ),
                ],)),
                GestureDetector(
                  onTap:() async{
                    
                      if(!await SeatStatus(9)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '9', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          },
                  child: FutureBuilder<bool>(
                          future: SeatStatus(9),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("9",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin:EdgeInsets.symmetric(horizontal: 15,vertical: 20) ,
                child:Row(children: [
                  GestureDetector(
                    onTap:() async{
                      
                          
                      if(!await SeatStatus(10)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '10', chosen_line: widget.chosen_line,);
                      }));
                      }
                        
                          },
                    child: FutureBuilder<bool>(
                          future: SeatStatus(10),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("10",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                  ),
                        GestureDetector(
                          onTap:() async{
                            
                      if(!await SeatStatus(11)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '11', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          
                          },
                          child: FutureBuilder<bool>(
                          future: SeatStatus(11),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("11",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                        ),
                ],)),
                GestureDetector(
                  onTap:() async{
                    
                      if(!await SeatStatus(12)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '12', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          
                          },
                  child: FutureBuilder<bool>(
                          future: SeatStatus(12),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("12",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin:EdgeInsets.symmetric(horizontal: 15,vertical: 20) ,
                child:Row(children: [
                  GestureDetector(
                    onTap:() async{
                      
                      if(!await SeatStatus(13)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '13', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          },
                    child: FutureBuilder<bool>(
                          future: SeatStatus(13),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("13",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                  ),
                        GestureDetector(
                          onTap:() async{

                      if(!await SeatStatus(14)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '14', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          
                          
                          },
                          child: FutureBuilder<bool>(
                          future: SeatStatus(14),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("14",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                        ),
                ],)),
                GestureDetector(
                  onTap:() async{
                    
                      if(!await SeatStatus(15)){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return PaymentPage(seat_number: '15', chosen_line: widget.chosen_line,);
                      }));
                      }
                          
                          
                          },
                  child: FutureBuilder<bool>(
                          future: SeatStatus(15),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Once data is fetched, return the Container with the appropriate color
                              bool isOccupied = snapshot.data ?? true;
                              return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: isOccupied ? Colors.deepPurple :Colors.grey ),
                          width: 35,
                          height: 35,
                          child: Center(child: Text("15",style: TextStyle(fontSize: 12),)),);
                          }},
                  ),
                ),
            ],
          ),
          SizedBox(height: 30,),
        //  MaterialButton(onPressed:() {
          //  Navigator.push(context, MaterialPageRoute(
            //  builder: (context){
              //  return PaymentPage();
                //}));
        //    },
        //  minWidth: 300,
          //  child: Text('Check Out'),
           // color: Colors.deepPurple,
           // textColor: Colors.white,
           // shape: RoundedRectangleBorder(
           //borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
           // ),
         // )
          
        ],),
      ),
    );
  }
}