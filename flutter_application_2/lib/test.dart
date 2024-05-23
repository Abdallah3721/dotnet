// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/Map.dart';
import 'package:flutter_application_2/map_for_passenger.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.email)
        .get();
  }

  void checkIfDatabaseIsEmpty(String line) {
    _firestore.collection(line).get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size == 0) {
        print('queue is empty');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Queue Is Empty'),
            duration: Duration(seconds: 2),
          ),
        );
        // Perform actions if the database is empty
      } else {
        if(line=="queue_for_amman"){
          print('amman queue is not empty');
          Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                        return BusBookInfo(chosen_line: "amman",);
                      }));
        }
        else if(line=="queue_for_jerash"){
          print('jerash queue is not empty');
          Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                        return BusBookInfo(chosen_line: "jerash",);
                      }));
        }
        else if(line=="queue_for_ajloun"){
          print('ajloun queue is not empty');
          Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                        return BusBookInfo(chosen_line: "ajloun",);
                      }));
        }

        
      }
    }).catchError((error) {
      print('Failed to check database: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 200, 171, 228),
                    Color.fromARGB(255, 143, 118, 198),
                    Color.fromARGB(255, 92, 52, 156),
                    Color.fromARGB(255, 91, 19, 172),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          icon: Icon(Icons.logout, size: 30, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 30),
                    child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: getUserDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        Map<String, dynamic>? user = snapshot.data!.data();
                        return Text(
                          "Hi " + user!['full name'],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 30),
                    child: Text(
                      "Where To Go?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    checkIfDatabaseIsEmpty("queue_for_amman");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 210, left: 20, right: 20),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 15,
                                offset: const Offset(5, 5))
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "Irbid",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "To",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "Amman",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 25,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.bus_alert_rounded, color: Colors.deepPurple, size: 60)
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    checkIfDatabaseIsEmpty("queue_for_jerash");
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 15,
                                offset: const Offset(5, 5))
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      // ignore: prefer_const_constructors
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "Irbid",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "To",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "Jerash",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 25,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.bus_alert_rounded, color: Colors.deepPurple, size: 60)
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    checkIfDatabaseIsEmpty("queue_for_ajloun");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 15,
                                offset: const Offset(5, 5))
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "Irbid",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "To",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "ajloun",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 25,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.bus_alert_rounded, color: Colors.deepPurple, size: 60)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
