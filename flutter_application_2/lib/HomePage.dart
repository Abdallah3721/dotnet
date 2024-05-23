// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/booking_interface.dart';
import 'package:flutter_application_2/cities.dart';
import 'package:flutter_application_2/get_user_name.dart';
import 'package:flutter_application_2/map_for_passenger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  final User? currentUser=FirebaseAuth.instance.currentUser;
  
  
  Future<DocumentSnapshot<Map<String,dynamic>>> GetUserDetails() async{
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(currentUser!.email)
    .get();
  }
  
  


  @override
  Widget build(BuildContext context) {
    final List<Cities> cities=[Cities(name: "Irbid-Amman"),Cities(name: "irbid-jerash"),Cities(name: "irbid-ajloun"),];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple,
  child: Column(
    children: [
      // Your other drawer items
      DrawerHeader(child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: 0),
        SizedBox(height: 0),
        Icon(Icons.person),
        Container(child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
          future: GetUserDetails(),
          builder: (context,Snapshot){
            Map<String,dynamic>? user=Snapshot.data!.data();
            return Text(user!['full name']);
          },
        ),)
      ],)),
      // Add your widget in the bottom left corner
      Expanded(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(icon: Icon(Icons.logout,color: Colors.black87,),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            ),
          ),
        ),
      ),
    ],
  ),
),
body:
  
  ListView(
    children: [
      SizedBox(height: 25,),
      Center(child: Text("Pick a line",style: TextStyle(color: Theme.of(context).colorScheme.primary),),),
      SizedBox(
      height: 350,
      child: ListView.builder(
      itemCount: cities.length,
      padding: EdgeInsets.all(15),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index){
        return GestureDetector(
          onTap:() {
            
              Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                        return MapForPassenger(chosen_line: cities[index].name,);
                      }));
          }, 
          child: Container(
            width: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius:BorderRadius.circular(15) 
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)
                ),
                width: double.infinity,
                padding: EdgeInsets.all(25),
                child: Icon(Icons.bus_alert)),
            ),
            SizedBox(height: 10,),
            Text(cities[index].name),
          ],),),
        );
      }),
    ),],
    
  ),
  );
  }
}