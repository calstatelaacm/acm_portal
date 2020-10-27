import 'package:acm_web/Screens/Events/Events.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccount extends StatefulWidget {
  static const String route = '/signup';
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _createAccount = new GlobalKey<FormState>();
  TextEditingController email, pwd, name, classStanding, major;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = new TextEditingController();
    pwd = new TextEditingController();
    name = new TextEditingController();
    classStanding = new TextEditingController();
    major = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: createAccount(),
      )
    );
  }

  Widget createAccount(){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/sideshow1.png'),
              fit: BoxFit.cover
          )
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _createAccount,
            child: Column(
              children: [
                Image.asset('assets/acmlogo1.png', height: 100,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        filled: true,
                        // fillColor: Colors.white.withOpacity(.85),
                        labelStyle: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        )

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: 'email',
                        filled: true,
                        // fillColor: Colors.white.withOpacity(.85),
                        labelStyle: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        )

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: TextFormField(
                    controller: pwd,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Must be 6+ characters',
                        filled: true,
                        // fillColor: Colors.white.withOpacity(.85),
                        labelStyle: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: TextFormField(
                    controller: major,
                    decoration: InputDecoration(
                        labelText: 'Major',
                        filled: true,
                        // fillColor: Colors.white.withOpacity(.85),
                        labelStyle: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        )

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: TextFormField(
                    controller: classStanding,
                    decoration: InputDecoration(
                        labelText: 'Class Standing',
                        filled: true,
                        // fillColor: Colors.white.withOpacity(.85),
                        labelStyle: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        )

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: submitForm,
                  child: Text("Create Account", style: GoogleFonts.openSans(),),
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm() async{
    if(_createAccount.currentState.validate()){
      try{
        FirebaseAuth.instance.
        createUserWithEmailAndPassword(email: email.text, password: pwd.text)
            .then((currUser) => {
           FirebaseFirestore.instance.collection("users")
          .add({
             "name": name.text,
             "email": email.text,
             "major": major.text,
             "classStanding": classStanding.text,
             "points": 10,
             "membership": false,
             "uid": currUser.user.uid,
           }).whenComplete(() => {
             Navigator.of(context).popUntil((route) => route.isFirst),
             Navigator.of(context).pushReplacementNamed('/events')
           })
        });
      }
      catch(e){
        debugPrint(e.toString());
      }
    }
  }
}
