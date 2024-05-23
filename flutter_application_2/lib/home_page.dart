// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgetpasspage.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegPage;
  const LoginPage({Key?key, required this.showRegPage}) :super(key: key);
  
  @override
  State<LoginPage> createState()=> _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _email_is_correct=true;
  bool _password_is_correct=true;
  final _EmailController=TextEditingController();
  final _PasswordController=TextEditingController();
  Future SignIn() async{

    showDialog(context: context,
      builder: (context){
        return Center(child: CircularProgressIndicator());},
        );

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _EmailController.text,
        password: _PasswordController.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        setState(() {
          _email_is_correct=false;
        });
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        setState(() {
          _password_is_correct=false;
        });
      }
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _EmailController.dispose();
    _PasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      body:SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bus_alert,size: 70,),
              SizedBox(height: 70,),
              Text("Hello Again!",
              style: GoogleFonts.bebasNeue(fontSize:54)),
              SizedBox(height: 10,),
              Text("Welcome back, you've been missed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20
              ),),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _EmailController,
                decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12)
                ),
                hintText: "Email",
                fillColor: Colors.grey[200],
                filled: true
                ),),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: !_email_is_correct,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    'Invalid email. Please try again.',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                controller: _PasswordController,
                decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12)
                ),
                hintText: "Password",
                fillColor: Colors.grey[200],
                filled: true
                ),
                obscureText: true,
                ),
              ),
              Visibility(
                visible: !_password_is_correct,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    'Invalid password. Please try again.',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 7,),
              GestureDetector(
                onTap:(){
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                    return ForgotPasswordPage();
                  }));
                } ,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot Password?",style: 
                      TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: SignIn,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text("Sign In",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18))),
                    ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member? ",style: TextStyle(fontWeight: FontWeight.w300),),
                  GestureDetector(
                    onTap: widget.showRegPage,
                    child: Text("Register now",style: 
                    TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
                  )
                ],
              )
            ],),
          ),
        ),
      ),
    );
  }
}