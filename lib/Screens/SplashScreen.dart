import 'package:acm_web/Authentication/Login/login.dart';
import 'package:acm_web/Screens/Events/Events.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    User user = FirebaseAuth.instance.currentUser;
    //User is not logged in
    if(user == null){
      {
        // Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushNamed('/login');
      }
    }
    //User is logged in
    else{
      {
        // Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushNamed('/events');
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/sideshow1.png'),
                  fit: BoxFit.cover
              )
          ),
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/acmlogo1.png', height: 100,),
                Text("Loading...", style: GoogleFonts.openSans(fontSize: 50, color: Colors.white),)
              ],
            ),
          ),
        ),
      )
    );
  }
}
