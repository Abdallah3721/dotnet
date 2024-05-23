import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/queue_mode.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? currentUser;
  String st = "empty";

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<String> getBusId() async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(currentUser!.email).get();

    if (documentSnapshot.exists) {
      final Map<String, dynamic> seatData = documentSnapshot.data() as Map<String, dynamic>;
      return seatData['bus_id'];
    } else {
      return "empty";
    }
  }

  Future<void> _addData(String id) async {
    final User? currentUser=FirebaseAuth.instance.currentUser;
    DocumentSnapshot userSnapshot =await FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser!.email)
              .get();

              print(userSnapshot.get('line'));
              
              if(userSnapshot.get("line")=="amman"){
              final querySnapshot = await _firestore.collection('queue_for_amman').where('bus_id', isEqualTo: id).get();

    if (querySnapshot.docs.isEmpty) {
      final Map<String, dynamic> documentData = {
        'bus_id': id,
        'timestamp': Timestamp.now(),
      };
      try {
        await FirebaseFirestore.instance.collection('queue_for_amman').doc(id).set(documentData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Listed in queue'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add data: $e'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Already in queue'),
          duration: Duration(seconds: 2),
        ),
      );
    }
              }

              else if(userSnapshot.get("line")=="jerash"){
              final querySnapshot = await _firestore.collection('queue_for_jerash').where('bus_id', isEqualTo: id).get();

    if (querySnapshot.docs.isEmpty) {
      final Map<String, dynamic> documentData = {
        'bus_id': id,
        'timestamp': Timestamp.now(),
      };
      try {
        await FirebaseFirestore.instance.collection('queue_for_jerash').doc(id).set(documentData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Listed in queue'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add data: $e'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Already in queue'),
          duration: Duration(seconds: 2),
        ),
      );
    }
              }

              else {
              final querySnapshot = await _firestore.collection('queue_for_ajloun').where('bus_id', isEqualTo: id).get();

    if (querySnapshot.docs.isEmpty) {
      final Map<String, dynamic> documentData = {
        'bus_id': id,
        'timestamp': Timestamp.now(),
      };
      try {
        await FirebaseFirestore.instance.collection('queue_for_ajloun').doc(id).set(documentData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Listed in queue'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add data: $e'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Already in queue'),
          duration: Duration(seconds: 2),
        ),
      );
    }
              }
    
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==1){
      FirebaseAuth.instance.signOut();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Driver Home'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            final busId = await getBusId();
            if (busId != "empty") {
              _addData(busId);
              Future.delayed(Duration(milliseconds: 600), () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return QueueMode();
                }));
                print("Delayed task executed!");
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('No bus id found'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bus_alert_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Request Active Mode",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
