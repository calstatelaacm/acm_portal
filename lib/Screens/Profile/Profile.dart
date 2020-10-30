import 'package:acm_web/Screens/Events/Events.dart';
import 'package:acm_web/Screens/Leadershipboard/LeadershipBoard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  static const String route = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User currUser;
  String userUid;

  void retrieveUid(){
    currUser = FirebaseAuth.instance.currentUser;
    setState(() {
      userUid = currUser.uid;
    });
  }

  Future<DocumentSnapshot> getUserDoc() async{
    return await FirebaseFirestore.instance.collection("users")
        .doc(userUid).get();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveUid();
    getUserDoc();
  }

  @override
  Widget build(BuildContext context) {
    return webDisplay();
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
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Icons.account_circle,),
                    Text(" Profile", style: GoogleFonts.roboto(),)
                  ],
                )
            )
          ],
        ),
        body: FutureBuilder(
          future: getUserDoc(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index){
                // var snapshot = snapshot.data;
                //Membership is not valid
                if(snapshot.data.data()['membership'].toString() == "false"){
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data.data()['profile']),
                      ),
                      SizedBox(height: 10,),
                      Text(snapshot.data.data()['name'], style: GoogleFonts.openSans(fontWeight: FontWeight.bold),),
                      Text('Class Standing: ' + snapshot.data.data()['classStanding'],
                        style: GoogleFonts.openSans(),),
                      Text('Major: ' + snapshot.data.data()['major'],
                        style: GoogleFonts.openSans(),),
                      SizedBox(
                        width: 200,
                        child: GestureDetector(
                          onTap: (){
                            if(canLaunch('https://acm-calstatela.com/membership') != null){
                              launch('https://acm-calstatela.com/membership');
                            }
                          },
                          child: Text("Membership: We are reviewing you account. If you haven't bought a membership click here",
                            style: GoogleFonts.openSans(),),
                        ),
                      )
                    ],
                  );
                }
                //Membership is valid
                return Column(
                  children: [
                    Icon(Icons.account_circle, size: 100,),
                    SizedBox(height: 10,),
                    Text(snapshot.data.data()['name'], style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                    fontSize: 30),),
                    Text('Class Standing: ' + snapshot.data.data()['classStanding'],
                      style: GoogleFonts.openSans(),
                    textAlign: TextAlign.left,),
                    Text('Major: ' + snapshot.data.data()['major'],
                      style: GoogleFonts.openSans(),
                    textAlign: TextAlign.left,),
                    Text('Membership: Expires 05/2021', style: GoogleFonts.openSans(),)
                  ],
                );
              },
            );
          },
        ),
      )
    );
  }
}
