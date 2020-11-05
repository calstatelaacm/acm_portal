import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:firebase/firebase.dart' as fb;

class CompleteProfile extends StatefulWidget {
  final userUid;

  CompleteProfile({this.userUid});

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  bool isLoading = false;
  File profile;
  // html.File profileImg;


  Future getImage() async{
    FilePickerResult result = await FilePicker.platform.pickFiles();
    var tempImg = File(result.files.single.path);

    setState(() {
      profile = tempImg;
    });
  }

  Future getWebImage() async{
    FilePickerResult result = await FilePicker.platform.pickFiles();
    var tempImg = File(result.files.single.path);

    setState(() {
      profile = tempImg;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
    getWebImage();
  }

  @override
  Widget build(BuildContext context) {
    if(UniversalPlatform.isAndroid){
      return SafeArea(
          child: Scaffold(
            body: Center(
              child: profile == null ? Text("Choose Profile Pic") :
              enableUpload(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Choose Image',
              child: new Icon(Icons.upload_rounded),
            ),
          )
      );
    }
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: profile == null ? Text("Choose Profile Pic") :
            webUpload(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: getWebImage,
            tooltip: 'Choose Image',
            child: new Icon(Icons.upload_rounded),
          ),
        )
    );
  }

  Widget webUpload(){
    return isLoading? Center(
      child: CircularProgressIndicator(),
    ) : Center(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.file(profile),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: () async{
                setState(() {
                  isLoading = true;
                });
                fb.StorageReference ref = fb.storage().ref().child('profile/WebTest');
                fb.UploadTaskSnapshot upload = await ref.put(profile).future;
                var downloadURL = await upload.ref.getDownloadURL();
                FirebaseFirestore.instance.collection("users")
                    .doc(widget.userUid).update({
                  "profile": downloadURL.toString()
                });
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacementNamed('/events');
              },
              child: Text("Upload"),
            )
          ],
        ),
      ),
    );
  }

  Widget enableUpload(){
    return isLoading? Center(
      child: CircularProgressIndicator(),
    ) : Center(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.file(profile),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: () async{
                setState(() {
                  isLoading = true;
                });
                StorageReference ref = FirebaseStorage.instance.ref()
                    .child('profile/${widget.userUid}');
                StorageUploadTask upload = ref.putFile(profile);
                var downloadURL = await (await upload.onComplete).ref.getDownloadURL();
                FirebaseFirestore.instance.collection("users")
                    .doc(widget.userUid).update({
                  "profile": downloadURL.toString()
                });
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacementNamed('/events');
              },
              child: Text("Upload"),
            )
          ],
        ),
      ),
    );
  }
}
