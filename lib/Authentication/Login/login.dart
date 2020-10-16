import 'dart:html';

import 'package:acm_web/Authentication/CreateAccount/CreateAccount.dart';
import 'package:acm_web/Screens/Events/Events.dart';
import 'package:acm_web/Screens/Leadershipboard/Leadership.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, pwd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: loginForm(),
        )
    );
  }

  Widget loginForm(){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sideshow1.png'),
          fit: BoxFit.cover
        )
      ),
      child: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Image.asset('assets/acmlogo1.png', height: 100,),
            SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: TextFormField(
                      validator: (input){
                        if(input.isEmpty){
                          return 'Email is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          // fillColor: Colors.white.withOpacity(.85),
                          labelStyle: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: Colors.white
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          )

                      ),
                      onSaved: (input) => email = input,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: TextFormField(
                      validator: (input){
                        if(input.isEmpty){
                          return 'Password is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          labelStyle: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: Colors.white
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)))),
                      onSaved: (input) => pwd = input,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 10,),
                  RaisedButton(
                    onPressed: signIn,
                    child: Text("Login", style: GoogleFonts.openSans(),),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.white,
                    thickness: 1,
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) => CreateAccount()));
                    },
                    child: Text("New? Create Account", textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(fontSize: 20),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        // Toast.show("Logging you in", context, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pwd);
        // Toast.show("Logging in successful", context, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => Events()));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
