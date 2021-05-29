import 'package:acm_web/Authentication/Login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/Navigation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ACM Portal',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: _getLandingPage(),
      // initialRoute: '/',
      // routes: {
      //   '/login': (context) => Login(),
      //   '/signup': (context) => CreateAccount(),
      //   '/events': (context) => Events(),
      //   '/leadershipBoard': (context) => LeadershipBoard(),
      //   '/profile': (context) => Profile()
      // },
    );
  }

  Widget _getLandingPage() {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        // if(ConnectionState.waiting != null){
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        if (snapshot.hasData) {
          if (snapshot.data.providerData.length == 1) {
            // logged in using email and password
            // if(UniversalPlatform.isWeb && MediaQuery.of(context).size.width < 600){
            //   return Navigation();
            // }
            return Navigation();
          } else {
            // don't remove this
            // if(UniversalPlatform.isWeb && MediaQuery.of(context).size.width < 600){
            //   return Navigation();
            // }
            return Navigation();
          }
        } else {
          return Login();
        }
      },
    );
  }
}
