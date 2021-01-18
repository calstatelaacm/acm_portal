import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:universal_platform/universal_platform.dart';

class LeadershipBoard extends StatefulWidget {
  static const String route = '/leaderboard';
  @override
  _LeadershipBoardState createState() => _LeadershipBoardState();
}

class _LeadershipBoardState extends State<LeadershipBoard> {
  @override
  Widget build(BuildContext context) {
    if(UniversalPlatform.isWeb && MediaQuery.of(context).size.width < 600){
      return mobileDisplay();
    }
    return webDisplay();
  }

  Widget mobileDisplay(){
    return SafeArea(
      child: Scaffold(
        body: retriveLeadershipBoard(),
      ),
    );
  }

  Widget webDisplay(){
    return SafeArea(
      child: Scaffold(
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
    return PaginateFirestore(
        //item builder type is compulsory.
        itemBuilderType: PaginateBuilderType.listView,
        initialLoader: LinearProgressIndicator(),
        itemsPerPage: 10,
        itemBuilder: (index, context, documentSnapshot) => Card(
          elevation: 10,
          child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Name: " + documentSnapshot.data()['name']),
            subtitle: Text("Points: " + documentSnapshot.data()['points'].toString()
            + "\nPosition: ${index + 1}"),
          ),
        ),
        // orderBy is compulsory to enable pagination
        query: FirebaseFirestore.instance.collection('users').orderBy('points', descending: true),
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
