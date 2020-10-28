import 'package:acm_web/Screens/Leadershipboard/LeadershipBoard.dart';
import 'package:acm_web/Screens/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_platform/universal_platform.dart';

class Events extends StatefulWidget {
  static const String route = '/events';
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    if(UniversalPlatform.isAndroid || MediaQuery.of(context).size.width < 600){
      mobileDisplay();
    }
    return webDisplay();
  }

  Widget mobileDisplay(){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ACM Portal'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                },
                title: Text("Events"),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => LeadershipBoard()));
                },
                title: Text("Leadership Board"),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.white,
              ),
              ListTile(
                title: Text("Request Event"),
              ),
              ListTile(
                title: Text("Request Project"),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.white,
              ),
              ListTile(
                title: Text("Profile"),
              ),
            ],
          ),
        ),
        body: Center(
          child: Text("Mobile Under development"),
        ),
      )
    );
  }

  Widget webDisplay(){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/acmlogo1.png', width: 100),
          actions: [
            FlatButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    Text(" Events", style: GoogleFonts.roboto(),)
                  ],
                )
            ),
            FlatButton(
                onPressed: (){
                  // Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacementNamed('/leadershipBoard');
                },
                child: Row(
                  children: [
                    Icon(Icons.leaderboard,),
                    Text(" Leadership Board", style: GoogleFonts.roboto(),)
                  ],
                )
            ),
            FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/profile');
                },
                child: Row(
                  children: [
                    Icon(Icons.account_circle,),
                    Text("Profile", style: GoogleFonts.roboto(),)
                  ],
                )
            )
          ],
        ),
        body: Text("Under Development"),
      ),
    );
  }
}
