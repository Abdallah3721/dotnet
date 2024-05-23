// ignore_for_file: prefer_const_constructors, empty_catches, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _EmailController=TextEditingController();

Future PasswordResetMethod() async{
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _EmailController.text.trim());
    showDialog(context: context, builder: (context){
      return AlertDialog(content: Text("password reset link sent"),);
    });
  } on FirebaseAuthException catch (e) {
    showDialog(context: context, builder: (context){
      return AlertDialog(content: Text(e.message.toString()),);
    });
  }
    
  }

  @override
  void dispose() {
    _EmailController.dispose();
    super.dispose();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple[200],elevation: 0,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Text("enter your email and we will send you a link to reset your password",
          textAlign: TextAlign.center),
          SizedBox(height: 10),
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
              MaterialButton(onPressed: (){
                PasswordResetMethod();
              },child: Text("Reset Password"),
              color: Colors.deepPurple[200],)
        ],
      ),
    );
  }
}