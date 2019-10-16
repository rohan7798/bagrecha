import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/Provider/database.dart';
import 'package:mobile/homepage.dart';
import 'package:mobile/model/userModel.dart';
import 'package:mobile/registration.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneAuth extends StatefulWidget {
  PhoneAuth();

  @override
  _PhoneAuth createState() => _PhoneAuth();
}

class _PhoneAuth extends State<PhoneAuth> {
  UserModal user = UserModal();

  bool _loading = false;
  bool _otpSent = false;

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  String _verificationId;
  String otp;
  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
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
              color: Color(0xffb00B274).withOpacity(0.80),
            ),
          ),
          _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Positioned(
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
                        height: 30,
                      ),
                      _otpSent
                          ? Text(
                              "Please Enter The Otp",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Times New Roman'),
                            )
                          : Text(
                              'Please Enter The Phone Number',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Times New Roman'),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: _otpSent
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    TextField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.phone,
                                      controller: _otpController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 20.0,
                                        ),
                                        hintText: "Enter the OTP here..",
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                      ),
                                      onSubmitted: (v) {
                                        setState(() {
                                          otp = v;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 180,
                                      child: RaisedButton.icon(
                                        icon: Icon(MdiIcons.accountCheck),
                                        label: Text("Verify NUMBER"),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        color:
                                            Color(0xffb00B274).withOpacity(0.5),
                                        textColor: Colors.white,
                                        elevation: 5,
                                        onPressed: () {
                                          _verifyOtp();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    TextField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.phone,
                                      controller: _phoneNumberController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 20.0,
                                        ),
                                        hintText:
                                            "Enter the Mobile Number here..",
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                      ),
                                      onSubmitted: (v) {
                                        setState(() {
                                          otp = v;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 150,
                                      child: RaisedButton.icon(
                                        icon: Icon(MdiIcons.arrowRightBoldBox),
                                        label: Text("Send Otp"),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        color:
                                            Color(0xffb00B274).withOpacity(0.5),
                                        textColor: Colors.white,
                                        elevation: 5,
                                        onPressed: () {
                                          _sendOtp();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                )),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  void _sendOtp() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      print("phoneAuthCredential");
      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';
      });
      FirebaseUser user = await _auth.signInWithCredential(phoneAuthCredential);
      _scaffold.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: const Text('Logged in.'),
      ));

      await databaseProvider.setCurrentUser(user);
      if (currentUser == null || currentUser.name == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (builder) => Registration()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (builder) => HomePage()));
      }
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print("authException");
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print("codeSent");
      setState(() {
        _otpSent = true;
      });
      _scaffold.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content:
            const Text('Please check your phone for the verification code.'),
      ));
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("codeAutoRetrievalTimeout");
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumberController.text,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void _verifyOtp() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _otpController.text,
    );
    FirebaseUser user = await _auth.signInWithCredential(credential);
    _scaffold.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: const Text('Logged in.'),
    ));

    await databaseProvider.setCurrentUser(user);
    if (currentUser == null || currentUser.name == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (builder) => Registration()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (builder) => HomePage()));
    }
  }
}
