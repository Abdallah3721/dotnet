// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, unused_import

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/HomePage.dart';
import 'package:flutter_application_2/booking_interface.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:flutter_application_2/main_page.dart';
import 'package:flutter_application_2/map_for_passenger.dart';
import 'package:flutter_application_2/queue_mode.dart';
import 'package:flutter_application_2/test.dart';
import 'package:flutter_application_2/Location.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'driver_home.dart';
import 'package:flutter_application_2/Map.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home:MainPage(),
    );
  }
}
