import 'package:acm_web/Screens/Events/Events.dart';
import 'package:acm_web/Screens/Leadershipboard/LeadershipBoard.dart';
import 'package:acm_web/Screens/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  
  int index = 0;

  final _pages = [
      Events(),
      LeadershipBoard(),
      Profile(),
  ];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width < 600){
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            title: Text('ACM Portal'),
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                _scaffoldKey.currentState.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),        
          ),
          drawer: NavDrawer(onTap: (ctx, i){
            setState(() {
              index = i;
              Navigator.pop(ctx);
            });
          },),
          body: _pages[index],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset('assets/acmlogo1.png', width: 100,),
          actions: [
            TextButton(
              onPressed: (){
                setState(() {
                  index = 0;
                });
              },
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  Text(
                    " Events",
                    style: GoogleFonts.roboto(),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  index = 1;
                });
              },
              child: Row(
                children: [
                  Icon(Icons.leaderboard),
                  Text(
                    " Leadership Board",
                    style: GoogleFonts.roboto(),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  index = 2;
                });
              },
              child: Row(
                children: [
                  Icon(Icons.person),
                  Text(
                    " Account",
                    style: GoogleFonts.roboto(),
                  )
                ],
              ),
            )
          ],
        ),
        body: _pages[index],
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final Function onTap;

  NavDrawer({this.onTap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        width: 140,
                        height: 130,
                        child: Image(
                          image: AssetImage('assets/acmlogo1.png'),
                        ))
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Events'),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.leaderboard),
              title: Text('Leadership Board'),
              onTap: () => onTap(context, 1),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Account'),
              onTap: () => onTap(context, 2),
            )
          ],
        ),
      ),
    );
  }
}