import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_platform/universal_platform.dart';

class LeadershipBoard extends StatefulWidget {
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

  //Mobile screen
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
                title: Text("Events"),
              ),
              ListTile(
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
          title: Image.asset('assets/acmlogo1.png'),
          actions: [
            FlatButton(
                onPressed: (){},
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    Text("Events")
                  ],
                )
            ),
            FlatButton(
                onPressed: (){},
                child: Row(
                  children: [
                    Icon(Icons.leaderboard),
                    Text("Leadership Board")
                  ],
                )
            )
          ],
        ),
        body: Row(
          children: [
            Container(
              height: 200,
              color: Colors.white,
            ),
            retriveLeadershipBoard()
          ],
        ),
      ),
    );
  }

  Widget retriveLeadershipBoard(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("leadershipBoard").orderBy("points", descending: true).snapshots(),
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
}
