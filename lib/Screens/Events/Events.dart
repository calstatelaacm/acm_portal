import 'package:acm_web/Screens/Leadershipboard/LeadershipBoard.dart';
import 'package:acm_web/Screens/Profile/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class Events extends StatefulWidget {
  static const String route = '/events';
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isWeb && MediaQuery.of(context).size.width < 600) {
      return mobileDisplay();
    }
    return webDisplay();
  }

  Widget mobileDisplay() {
    return SafeArea(
      child: Scaffold(
        body: events(),
      ),
    );
  }

  Widget webDisplay() {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Image.asset('assets/acmlogo1.png', width: 100),
        //   actions: [
        //     FlatButton(
        //         onPressed: null,
        //         child: Row(
        //           children: [
        //             Icon(Icons.calendar_today),
        //             Text(
        //               " Events",
        //               style: GoogleFonts.roboto(),
        //             )
        //           ],
        //         )),
        //     FlatButton(
        //         onPressed: () {
        //           // Navigator.of(context).popUntil((route) => route.isFirst);
        //           Navigator.of(context).push(new MaterialPageRoute(builder: (context) => LeadershipBoard()));
        //         },
        //         child: Row(
        //           children: [
        //             Icon(Icons.leaderboard,),
        //             Text(
        //               " Leadership Board",
        //               style: GoogleFonts.roboto(),
        //             )
        //           ],
        //         )),
        //     FlatButton(
        //         onPressed: () {
        //           Navigator.of(context).push(new MaterialPageRoute(builder: (context) => Profile()));
        //         },
        //         child: Row(
        //           children: [
        //             Icon(
        //               Icons.account_circle,
        //             ),
        //             Text(
        //               "Profile",
        //               style: GoogleFonts.roboto(),
        //             )
        //           ],
        //         ))
        //   ],
        // ),
        
        body: Padding(
          child: events(),
          padding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  Widget events() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text(
                    "Fetching Data",
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            );
          }
          // Mobile View
          if (MediaQuery.of(context).size.width < 600) {
            return ListView(
              shrinkWrap: true,
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return ListTile(
                  onTap: () {
                    if (canLaunch(document['url']) != null) {
                      launch(document['url']);
                    }
                  },
                  leading: Image.network(
                    document['image'],
                    height: 150,
                    width: 100,
                  ),
                  title: Text(
                    document['eventName'],
                    // style: Theme.of(context).textTheme.headline4,
                    // overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                  ),
                  subtitle: Text(
                    document['eventDate'],
                    // style: Theme.of(context).textTheme.subtitle1,
                    // overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                  ),
                );
              }).toList(),
            );
          } else {
            return GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 4 / 2,
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Column(
                                            children: [
                                              Image.network(
                                                document['image'],
                                                height: 150,
                                                width: 100,
                                              ),
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    document['image'],
                                    width: 100,
                                    height: 150,
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: document['eventName'],
                                    // style:
                                    //     Theme.of(context).textTheme.headline3,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                ),
                                // SizedBox(height: 2),
                                Text.rich(
                                  TextSpan(
                                    text: document['eventDate'],
                                    // style:
                                    //     Theme.of(context).textTheme.headline4,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                ),
                                //RSVP BUTTON
                                RaisedButton(
                                  onPressed: () {
                                    if (canLaunch(document['url']) != null) {
                                      launch(document['url']);
                                    }
                                  },
                                  child: Text("RSVP"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        });
  }
}
