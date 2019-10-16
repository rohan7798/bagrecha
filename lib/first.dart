import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/Provider/database.dart';
import 'package:mobile/homepage.dart';
import 'package:mobile/model/userModel.dart';
import 'package:mobile/phoneauth.dart';
import 'registration.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// FirebaseAuth _auth = FirebaseAuth.instance;

class First extends StatefulWidget {
  @override
  _First createState() => _First();
}

class _First extends State<First> {
  // GoogleSignIn _googleSignIn = GoogleSignIn();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loading = true;
  // bool _success;
  // String _userID;
  FacebookLogin fblogin = FacebookLogin();

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  void checkUserStatus() async {
    await databaseProvider.init();
    FirebaseUser user = databaseProvider.getCurrentUser();
    if (user == null) {
      setState(() {
        _loading = false;
      });
    } else {
      Map<String, dynamic> response = await databaseProvider.getUserProfile();
      setState(() {
        _loading = false;
      });
      if (response == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (builder) => Registration(phone: user.phoneNumber)),
        );
      } else {
        response["uid"] = user.uid;
        currentUser.phoneNumber = user.phoneNumber;
        currentUser = UserModal.fromJson(response);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (builder) => HomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              color: Color(0xffb00B274).withOpacity(0.8),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(
                    2.5,
                  ),
                  // color: Colors.white,
                  child: Image.asset(
                    "images/logo.png",
                    color: Colors.white,
                    height: 180,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: RaisedButton.icon(
                    icon: Icon(MdiIcons.phone),
                    label: Text("Login With Phone Number"),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color(0xffb00B274).withOpacity(0.5),
                    textColor: Colors.white,
                    elevation: 15,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (builder) => PhoneAuth()));
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: RaisedButton.icon(
                    icon: Icon(MdiIcons.facebook),
                    label: Text('Login With Facebook'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 15,
                    onPressed: () {
                      fblogin.logInWithReadPermissions(
                          ['email', 'public_profile']).then((result) {
                        switch (result.status) {
                          case FacebookLoginStatus.loggedIn:
                            AuthCredential credential =
                                FacebookAuthProvider.getCredential(
                                    accessToken: result.accessToken.token);
                            FirebaseAuth.instance
                                .signInWithCredential(credential)
                                .then((signedInUser) async {
                              print('Signed in as ${signedInUser.displayName}');
                              print("UID: ${signedInUser.uid}");

                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                  'Logged In Successfully.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor:
                                    Color(0xffb00B274).withOpacity(0.45),
                                duration: Duration(seconds: 3),
                              ));
                              await Future.delayed(Duration(seconds: 2));

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (builder) => Registration()));
                            }).catchError((e) {
                              print(e);
                            });
                            break;

                          case FacebookLoginStatus.cancelledByUser:
                            break;

                          case FacebookLoginStatus.error:
                            print(result.errorMessage);
                            break;
                        }
                      }).catchError((e) {
                        print(e);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // SizedBox(
                //   width: 250,
                //   height: 50,
                //   child: RaisedButton.icon(
                //     icon: Icon(MdiIcons.google),
                //     label: Text('Sign-In with Google'),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30)),
                //     color: Colors.red,
                //     textColor: Colors.white,
                //     elevation: 15,
                //     onPressed: () {
                //       _signInWithGoogle();
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void _signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //     print("google: ${googleUser.email}");
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     print("googleAuth: ${googleAuth.idToken}");
  //     final AuthCredential credential = GoogleAuthProvider.getCredential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     print("credential: ${credential.toString()}");
  //     final FirebaseUser user = await _auth.signInWithCredential(credential);
  //     print("user: ${user.email}");

  //     // assert(user.email != null);
  //     // assert(user.displayName != null);
  //     // assert(!user.isAnonymous);
  //     // assert(await user.getIdToken() != null);

  //     // final FirebaseUser currentUser = await _auth.currentUser();
  //     // assert(user.uid == currentUser.uid);
  //     setState(() {
  //       if (user != null) {
  //         _success = true;
  //         _userID = user.uid;
  //         print("user:-$_userID");
  //       } else {
  //         _success = false;
  //       }
  //     });
  //   } catch (e) {
  //     print('err:$e');
  //   }
  // }
}
