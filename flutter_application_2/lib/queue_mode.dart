import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/driver_home.dart';
import 'get_user_name.dart';
import 'package:firebase_auth/firebase_auth.dart';


class QueueMode extends StatefulWidget {
  const QueueMode({super.key});

  @override
  State<QueueMode> createState() => _QueueModeState();
}

class _QueueModeState extends State<QueueMode> {
  String DriverLine='';


      

  Future<void> EmptySeats() async{
    final User? currentUser=FirebaseAuth.instance.currentUser;
    DocumentSnapshot userSnapshot =await FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser!.email)
              .get();

              print(userSnapshot.get('line'));
              
              if(userSnapshot.get("line")=="amman"){
              for (var i = 1; i < 16; i++) {


                
              await FirebaseFirestore.instance.collection("bus_seats_for_amman")
              .doc("seat_${i.toString()}").update({"reserved":false});
              }
              }

              else if(userSnapshot.get("line")=="jerash"){
              for (var i = 1; i < 16; i++) {
              await FirebaseFirestore.instance.collection("bus_seats_for_jerash")
              .doc("seat_${i.toString()}").update({"reserved":false});
              }
              }

              else {
              for (var i = 1; i < 16; i++) {
              await FirebaseFirestore.instance.collection("bus_seats_for_ajloun")
              .doc("seat_${i.toString()}").update({"reserved":false});
              }
              }


      }
  List<String> docIDs=[];
  Future getDocId() async{
    final User? currentUser=FirebaseAuth.instance.currentUser;
    DocumentSnapshot userSnapshot =await FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser!.email)
              .get();


              print(userSnapshot.get('line'));
              
              if(userSnapshot.get("line")=="amman"){
              await FirebaseFirestore.instance.collection("queue_for_amman").orderBy("timestamp",descending: false).get().then(
              (snapshot) => snapshot.docs.forEach((element) {
              docIDs.add(element.reference.id);
              }));
              DriverLine="amman";
              }

              else if(userSnapshot.get("line")=="jerash"){
              await FirebaseFirestore.instance.collection("queue_for_jerash").orderBy("timestamp",descending: false).get().then(
              (snapshot) => snapshot.docs.forEach((element) {
              docIDs.add(element.reference.id);
              }));
              DriverLine="jerash";
              }

              else {
              await FirebaseFirestore.instance.collection("queue_for_ajloun").orderBy("timestamp",descending: false).get().then(
              (snapshot) => snapshot.docs.forEach((element) {
              docIDs.add(element.reference.id);
              }));
              DriverLine="ajloun";
              }
    
  }

  final User? currentUser=FirebaseAuth.instance.currentUser;
  String st="empty";

  Future<String> BusId() async {
        
        await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email) 
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Seat document found
        var seatData = documentSnapshot.data() as Map<String, dynamic>;
        st=  seatData['bus_id'];
      } 
    }).catchError((error) {
      print('Error fetching data: $error');
    });
    return st;
  }

  void deleteData(String documentId) async {
  try {
    final User? currentUser=FirebaseAuth.instance.currentUser;
    DocumentSnapshot userSnapshot =await FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser!.email)
              .get();

              print(userSnapshot.get('line'));
              
              if(userSnapshot.get("line")=="amman"){
              await FirebaseFirestore.instance.collection('queue_for_amman').doc(documentId).delete();
              }

              else if(userSnapshot.get("line")=="jerash"){
              await FirebaseFirestore.instance.collection('queue_for_jerash').doc(documentId).delete();
              }

              else {
              await FirebaseFirestore.instance.collection('queue_for_ajloun').doc(documentId).delete();
              }

  } catch (e) {
    print('Error deleting document: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Queue"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body:
      
        Center(
        child: Column(
          
          children: [Expanded(
            child: FutureBuilder(future: getDocId(),
            builder: (context,snapshot){
              return ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context,index){
                return Card(
                  color:  index==0 ? Color.fromARGB(255, 83, 205, 87) : Color.fromARGB(255, 150, 39, 31),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      leading: Icon(Icons.person,color: Colors.white,),
                      title: GetUserName(documentID: docIDs[index], DriverLine: DriverLine,),
                      subtitle: Text(
                        "Position: ${index + 1}",
                        style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      ));
              });
              })
            ),
            GestureDetector(
  onTap: () async {
    await BusId();
    deleteData(st);
    EmptySeats();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted from queue'),
        duration: Duration(seconds: 2),
      ),
    );
  },
  child: Material(
    color: Colors.transparent,
    child: Ink(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(100),
      ),
      child: GestureDetector(
  onTap: () async {
    await BusId();
    deleteData(st);
    EmptySeats();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted from queue'),
        duration: Duration(seconds: 2),
      ),
    );
  },
  child: AnimatedContainer(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    width: 180,
    height: 60,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6E5AE6), Colors.deepPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Color(0x80000000),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          left: 15,
          top: 15,
          child: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 25,
          ),
        ),
        Positioned(
          right: 15,
          top: 15,
          child: Text(
            "Leave Queue",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
),

    ),
  ),
),

      SizedBox(height: 20,)],
        ),
      ),
    );
  }
}