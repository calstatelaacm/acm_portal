import 'package:expansion_card/expansion_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  User currUser;
  String userUid;

  void retrieveUid(){
    currUser = FirebaseAuth.instance.currentUser;
    setState(() {
      userUid = currUser.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveUid();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users")
          .where("uid", isEqualTo: userUid).snapshots(),
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
            //Membership is not valid
            if(docSnapshot.data()['membership'].toString() == "false"){
              return Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: ExpansionCard(
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Name: " + docSnapshot.data()['name'],
                        ),
                        Text(
                          "Email: " + docSnapshot.data()['email'],
                        ),
                      ],
                    ),
                  ),
                  children: <Widget>[
                    Text(
                      "Major: " + docSnapshot.data()['major'],
                    ),
                    Text(
                      "Class Standing: " + docSnapshot.data()['classStanding'],
                    ),
                    GestureDetector(
                      onTap: (){
                        if(canLaunch('https://acm-calstatela.com/membership') != null){
                          launch('https://acm-calstatela.com/membership');
                        }
                      },
                      child: Text("Buy Membership",
                        style: GoogleFonts.openSans(
                          decoration: TextDecoration.underline,
                          color: Colors.blue
                        ),),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text("Log out"),
                    )
                  ],
                ),
              );
            }
            //Membership is valid
            return Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: ExpansionCard(
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Name: " + docSnapshot.data()['name'],
                      ),
                      Text(
                        "Email: " + docSnapshot.data()['email'],
                      ),
                    ],
                  ),
                ),
                children: <Widget>[
                  Text(
                    "Major: " + docSnapshot.data()['major'],
                  ),
                  Text(
                    "Class standing: " + docSnapshot.data()['classStanding'],
                  ),
                  Text("Membership valid till end of current school year"),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text("Log out"),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
