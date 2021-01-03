import 'package:acm_web/Screens/Events/Events.dart';
import 'package:acm_web/Screens/Leadershipboard/LeadershipBoard.dart';
import 'package:acm_web/Screens/Profile/Profile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return mobileUI();
  }

  Widget mobileUI(){
    int _selectedPage = 0;
    final _pages = [
      Events(),
      LeadershipBoard(),
      Profile(),
    ];

    void _onItemTapped(int index){
      setState(() {
        _selectedPage = index;
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _pages[_selectedPage]
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Events'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              activeIcon: Icon(Icons.leaderboard),
              label: 'Leadership Board'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'
            ),
          ],
          currentIndex: _selectedPage,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}