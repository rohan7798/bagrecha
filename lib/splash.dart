import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile/provider/database.dart';
import 'package:mobile/first.dart';
import 'package:mobile/homepage.dart';
import 'package:mobile/model/userModel.dart';
import 'package:mobile/registration.dart';


class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  // final PermissionHandler _permissionHandler = PermissionHandler();

  bool isPermissionGrant = false;

  @override
  void initState() {
    reqPermission();
    super.initState();
  }

  reqPermission() async {
    await _requestPermission();
    while (!isPermissionGrant) {
      await _requestPermission();
    }
    // user status
    checkUserStatus();
  }

  Future<void> _requestPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.location]);

    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    print('permission:${permission.value}');

    if (permission.value == 0) {
      setState(() {
        isPermissionGrant = false;
      });
    } else {
      setState(() {
        isPermissionGrant = true;
      });
    }
  }

  void checkUserStatus() async {
    await databaseProvider.init();
    FirebaseUser user = databaseProvider.getCurrentUser();
    if (user == null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (builder) => First()));
    } else if (currentUser == null || currentUser.name == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (builder) => Registration()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (builder) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xffb00B274),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/logo.png",
                        color: Colors.white,
                        height: 200,
                        width: 200,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                        ),
                      ),
                      Text(
                        "Pilot",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Times New Roman",
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LinearProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      ),
                    ),
                    Text(
                      "Please Wait..",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
