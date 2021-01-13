import 'package:acm_web/Authentication/CreateAccount/CreateAccount.dart';
import 'package:acm_web/Screens/Events/Events.dart';
import 'package:acm_web/Screens/Navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_platform/universal_platform.dart';

class Login extends StatefulWidget {
  static const String route = '/login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, pwd;
  var mobileSize, webSize;

  @override
  Widget build(BuildContext context) {
    mobileSize = (MediaQuery.of(context).size.width*9)/10;
    webSize = MediaQuery.of(context).size.width/2;

    if(UniversalPlatform.isAndroid || MediaQuery.of(context).size.width < 600){
      return SafeArea(
          child: Scaffold(
            body: mobile(),
          )
      );
    }
    return SafeArea(
        child: Scaffold(
          body: web(),
        )
    );
  }

  Widget mobile(){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/sideshow1.png'),
              fit: BoxFit.cover
          )
      ),
      child: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) :Center(
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
                    width: mobileSize,
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
                    width: mobileSize,
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
                    onPressed: (){
                      setState(() {
                        isLoading = true;
                      });
                      signIn();
                    },
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
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => CreateAccount()));
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

  Widget web(){
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
                    width: webSize,
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
                    width: webSize,
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
                onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  signIn();
                },
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
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => CreateAccount()));
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
        if(MediaQuery.of(context).size.width < 600){
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => Navigation()));
        }
        else{
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => Events()));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
