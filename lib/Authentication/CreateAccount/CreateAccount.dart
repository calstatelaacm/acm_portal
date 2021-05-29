import 'package:acm_web/Screens/Navigation.dart';
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
  String userPhotoUrl = '';
  var mobileSize, webSize;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    email = new TextEditingController();
    pwd = new TextEditingController();
    name = new TextEditingController();
    classStanding = new TextEditingController();
    major = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    mobileSize = (MediaQuery.of(context).size.width*9)/(10);
    webSize = MediaQuery.of(context).size.width/2;

    if(MediaQuery.of(context).size.width < 600){
      return SafeArea(
        child: Scaffold(
          body: mobileForm(),
        )
      );
    }
    return SafeArea(
      child: Scaffold(
        body: webForm(),
      )
    );
  }

  Widget mobileForm(){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/sideshow1.png'),
              fit: BoxFit.cover
          )
      ),
      child: isLoading? Center(
        child: CircularProgressIndicator(),
      ) : Center(
        child: SingleChildScrollView(
          child: Form(
            key: _createAccount,
            child: Column(
              children: [
                Image.asset('assets/acmlogo1.png', height: 100,),
                SizedBox(
                  width: mobileSize,
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
                  width: mobileSize,
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
                  width: mobileSize,
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
                  width: mobileSize,
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
                  width: mobileSize,
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
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      isLoading = true;
                    });
                    submitForm();
                  },
                  child: Text("Create Account", style: GoogleFonts.openSans(),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget webForm(){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/sideshow1.png'),
              fit: BoxFit.cover
          )
      ),
      child: isLoading? Center(
        child: CircularProgressIndicator(),
      ) : Center(
        child: SingleChildScrollView(
          child: Form(
            key: _createAccount,
            child: Column(
              children: [
                Image.asset('assets/acmlogo1.png', height: 100,),
                SizedBox(
                  width: webSize,
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
                  width: webSize,
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
                  width: webSize,
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
                  width: webSize,
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
                  width: webSize,
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
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      isLoading = true;
                    });
                    submitForm();
                  },
                  child: Text("Create Account", style: GoogleFonts.openSans(),),
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
           .doc(currUser.user.uid)
          .set({
             "name": name.text,
             "email": email.text,
             "major": major.text,
             "classStanding": classStanding.text,
             "points": 10,
             "membership": false,
             "uid": currUser.user.uid,
           })
        });
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => Navigation()));
      }
      catch(e){
        debugPrint(e.toString());
      }
    }
  }

  // getWebImage() async{
  //   File fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.file);

  //   if(fromPicker != null){
  //     uploadToFirebase(fromPicker);
  //   }
  // }

  // uploadToFirebase(File imageFile) async {
  //   fb.StorageReference ref = fb.storage().ref().child('profile/$imageFile');
  //   fb.UploadTaskSnapshot upload = await ref.put(imageFile).future;
  //   var downloadURL = await upload.ref.getDownloadURL();
  //   setState(() {
  //     userPhotoUrl = downloadURL.toString();
  //   });
  // }
}
