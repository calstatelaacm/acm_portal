import 'package:acm_web/Authentication/UserCard.dart';
import 'package:acm_web/Screens/Events/Events.dart';
import 'package:acm_web/Screens/Profile/Profile.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadershipBoard extends StatefulWidget {
  static const String route = '/leaderboard';
  @override
  _LeadershipBoardState createState() => _LeadershipBoardState();
}

class _LeadershipBoardState extends State<LeadershipBoard> {
  @override
  Widget build(BuildContext context) {
    if(UniversalPlatform.isAndroid || MediaQuery.of(context).size.width < 600){
      return mobileDisplay();
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
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => Events()));
                },
                title: Text("Events"),
              ),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
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
        body: retriveLeadershipBoard(),
      ),
    );
  }

  Widget webDisplay(){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/acmlogo1.png', width: 100),
          actions: [
            FlatButton(
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacementNamed('/events');
                },
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    Text(" Events", style: GoogleFonts.roboto(),)
                  ],
                )
            ),
            FlatButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Icons.leaderboard,),
                    Text(" Leadership Board", style: GoogleFonts.roboto(),)
                  ],
                )
            ),
            FlatButton(
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacementNamed('/profile');
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
        body: Row(
          children: [
            Expanded(
              // child: UserCard(),
              child: getFirstPlace(),
            ),
            Expanded(child: retriveLeadershipBoard())
          ],
        ),
      ),
    );
  }

  Widget retriveLeadershipBoard(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").orderBy("points", descending: true)
          .limit(10).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot docSnapshot = snapshot.data.docs[index];
            var id = docSnapshot.id;
            return Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                elevation: 10,
                child: ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text("Name: " + docSnapshot.data()['name']),
                  subtitle: Text("Points: " + docSnapshot.data()['points'].toString()),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget getFirstPlace(){
    return StreamBuilder(
      // First item in the collection will have the most points
      stream: FirebaseFirestore.instance.collection("users").orderBy("points", descending: true)
          .limit(1).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot docSnapshot = snapshot.data.docs[index];
            var id = docSnapshot.id;
            return Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                color: Colors.blueGrey,
                elevation: 10,
                child: ListTile(
                  leading: Icon(Icons.emoji_events_outlined),
                  title: Text("First place: " + docSnapshot.data()['name']),
                  subtitle: Text("Points: " + docSnapshot.data()['points'].toString()),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
