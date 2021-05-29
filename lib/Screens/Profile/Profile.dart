import 'package:acm_web/Authentication/Login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  static const String route = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User currUser;
  String userUid;

  void retrieveUid() {
    currUser = FirebaseAuth.instance.currentUser;
    setState(() {
      userUid = currUser.uid;
    });
  }

  Future<DocumentSnapshot> getUserDoc() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .get();
  }

  @override
  void initState() {
    super.initState();
    retrieveUid();
    getUserDoc();
  }

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
      body: FutureBuilder(
          future: getUserDoc(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 70,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, size: 50,),
                          radius: 60,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        snapshot.data.data()['name'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Class Standing: ' +
                            snapshot.data.data()['classStanding'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Major: ' + snapshot.data.data()['major'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Email: ' + snapshot.data.data()['email'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          child: snapshot.data.data()['membership']
                              ? Text(
                                  "Membership: Active",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 25),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (canLaunch(
                                            'https://acm-calstatela.com/membership') !=
                                        null) {
                                      launch(
                                          'https://acm-calstatela.com/membership');
                                    }
                                  },
                                  child: Text(
                                    "Membership: We are reviewing you're account. If you haven't bought a membership click here",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 25),
                                  ),
                                )),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              _signOut();
                            },
                            child: Text("Log out"),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                });
          }),
    ));
  }

  Widget webDisplay() {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
          future: getUserDoc(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 70,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, size: 50,),
                          radius: 60,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        snapshot.data.data()['name'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Class Standing: ' +
                            snapshot.data.data()['classStanding'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Major: ' + snapshot.data.data()['major'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Email: ' + snapshot.data.data()['email'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                          child: snapshot.data.data()['membership']
                              ? Text(
                                  "Membership: Active",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 25),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (canLaunch(
                                            'https://acm-calstatela.com/membership') !=
                                        null) {
                                      launch(
                                          'https://acm-calstatela.com/membership');
                                    }
                                  },
                                  child: Text(
                                    "Membership: We are reviewing you're account. If you haven't bought a membership click here",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 25),
                                  ),
                                )),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              _signOut();
                            },
                            child: Text("Log out"),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                });
          }),
    ));
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    } catch (e) {
      print(e);
    }
  }
}
