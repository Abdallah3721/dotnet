import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_page.dart';
import 'reg_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool show_login_page=true;
  void togglescreens(){
    setState(() {
      show_login_page=!show_login_page;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (show_login_page) {
      return LoginPage(showRegPage:togglescreens);
    } 
    else
    return RegPage(show_login_page:  togglescreens);
  }
}