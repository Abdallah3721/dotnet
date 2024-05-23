import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/booking_interface.dart';

class MapForPassenger extends StatefulWidget {
  final String chosen_line;
  const MapForPassenger( {super.key,required this.chosen_line});

  @override
  State<MapForPassenger> createState() => _MapForPassengerState();
}

class _MapForPassengerState extends State<MapForPassenger> {
    final User? currentUser=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    print(widget.chosen_line);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Container(
            height:500,
            width: 450, 
            child:Image.asset('images/mymap.jpg')),
            MaterialButton(onPressed:() {
            Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return BookingInterface(chosen_line: widget.chosen_line,);
            }));
        },
        minWidth: 150,
        child: Text('Book a seat'),
        color: Colors.deepPurple,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
        ),
        )
        ],),
      ),
    );
  }
}