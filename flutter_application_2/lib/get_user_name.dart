import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentID;
  final String DriverLine;

  const GetUserName({required this.documentID, required this.DriverLine});

  @override
  Widget build(BuildContext context) {

    if(DriverLine=="amman"){
      CollectionReference buses_in_queue=FirebaseFirestore.instance.collection("queue_for_amman");
    return FutureBuilder<DocumentSnapshot>(builder: ((context, snapshot) {
      if (snapshot.connectionState==ConnectionState.done) {
        Map<String,dynamic> data= snapshot.data!.data() as Map<String,dynamic>;
        return Text("bus id: ${data['bus_id']}",style: TextStyle(color: Colors.white),);
      }
      else return Text("loading",style: TextStyle(color: Colors.white),);
    }), future: buses_in_queue.doc(documentID).get(),);

    }

    else if(DriverLine=="jerash"){
      CollectionReference buses_in_queue=FirebaseFirestore.instance.collection("queue_for_jerash");
    return FutureBuilder<DocumentSnapshot>(builder: ((context, snapshot) {
      if (snapshot.connectionState==ConnectionState.done) {
        Map<String,dynamic> data= snapshot.data!.data() as Map<String,dynamic>;
        return Text("bus id: ${data['bus_id']}",style: TextStyle(color: Colors.white),);
      }
      else return Text("loading",style: TextStyle(color: Colors.white),);
    }), future: buses_in_queue.doc(documentID).get(),);
    }

    else{
      CollectionReference buses_in_queue=FirebaseFirestore.instance.collection("queue_for_ajloun");
    return FutureBuilder<DocumentSnapshot>(builder: ((context, snapshot) {
      if (snapshot.connectionState==ConnectionState.done) {
        Map<String,dynamic> data= snapshot.data!.data() as Map<String,dynamic>;
        return Text("bus id: ${data['bus_id']}",style: TextStyle(color: Colors.white),);
      }
      else return Text("loading",style: TextStyle(color: Colors.white),);
    }), future: buses_in_queue.doc(documentID).get(),);
    }

    
  }
}