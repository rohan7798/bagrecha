import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile/homepage.dart';
import 'package:mobile/model/userModel.dart';

class Imagepicker extends StatefulWidget {
  @override
  _ImagePicker createState() => _ImagePicker();
}

class _ImagePicker extends State<Imagepicker> {
  final db = Firestore.instance;
  FirebaseUser _firebaseUser;

  File profileImage;
  File aadharCardImage;
  File licenseImage;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text('Upload Image'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Card(
                  margin:
                      EdgeInsets.only(bottom: 10, left: 5, top: 5, right: 5),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: profileImage == null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text('No Image Selected'),
                                )
                              : Image.file(
                                  profileImage,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 150,
                        width: 190,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Select Profile Picture",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            FlatButton(
                              color: Color(0xffb00B274),
                              child: Text(
                                'Select',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                mainBottomSheet(context, "P");
                              },
                            ),
                            Container(
                              width: 150.0,
                              child: Text(
                                'File size should be less than 500KB',
                                softWrap: true,
                                // overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: aadharCardImage == null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text('No Image Selected'))
                              : Image.file(
                                  aadharCardImage,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Container(
                        width: 190,
                        height: 150,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Upoad Aadhar Picture",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            FlatButton(
                              color: Color(0xffb00B274),
                              child: Text(
                                'Select',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                mainBottomSheet(context, "A");
                              },
                            ),
                            Container(
                              width: 150.0,
                              child: Text(
                                'File size should be less than 500KB',
                                softWrap: true,
                                // overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: licenseImage == null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text('No Image Selected'))
                              : Image.file(
                                  licenseImage,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 190,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Upoad License Picture",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            FlatButton(
                              color: Color(0xffb00B274),
                              child: Text(
                                'Select',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                mainBottomSheet(context, "L");
                              },
                            ),
                            Container(
                              width: 150.0,
                              child: Text(
                                'File size should be less than 500KB',
                                softWrap: true,
                                // overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 50,
                child: FlatButton(
                  child: Text(
                    'Upload',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  color: Color(0xffb00B274),
                  onPressed: _startUpload,
                ),
              ),
            ],
          ),
        ),
        loading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.35),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 35.0,
                  height: 35.0,
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  mainBottomSheet(BuildContext context, String value) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("CAMERA"),
                onTap: () => getImage(ImageSource.camera, value),
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text("GALLERY"),
                onTap: () => getImage(ImageSource.gallery, value),
              ),
            ],
          );
        });
  }

  getImage(ImageSource source, String value) async {
    Navigator.of(context).pop();
    File compressedFile;

    try {
      File img = await ImagePicker.pickImage(source: source);
      print(img.path);

      compressedFile = await FlutterNativeImage.compressImage(img.path,
          quality: 65, percentage: 65);
    } catch (e) {
      print("Error occured $e");
    }

    switch (value) {
      case "A":
        setState(() {
          aadharCardImage = compressedFile;
        });
        break;
      case "L":
        setState(() {
          licenseImage = compressedFile;
        });
        break;
      case "P":
        setState(() {
          profileImage = compressedFile;
        });
        break;
    }
  }

  void _startUpload() async {
    setState(() {
      loading = true;
    });
    try {
      _firebaseUser = await FirebaseAuth.instance.currentUser();
      String profileUrl = await uploadImage(profileImage, name: "profile.jpg");
      await uploadImage(aadharCardImage, name: "aadhar.jpg");
      await uploadImage(licenseImage, name: "license.jpg");
      currentUser.profileUrl = profileUrl;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (builder) => HomePage(),
        ),
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      loading = true;
    });
  }

  Future<String> uploadImage(File image, {String name}) async {
    FirebaseAuth.instance.currentUser();
    Completer<String> c = new Completer<String>();
    try {
      final StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(_firebaseUser.uid).child(name);
      final StorageUploadTask task = firebaseStorageRef.putFile(image);
      var downloadURL = await (await task.onComplete).ref.getDownloadURL();
      await Firestore.instance
          .collection("users")
          .document(_firebaseUser.uid)
          .updateData({name.replaceAll(".jpg", "") + "Url": downloadURL});
      c.complete(downloadURL.toString());
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
