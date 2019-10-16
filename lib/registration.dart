import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/imagepicker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/Provider/database.dart';
import 'package:mobile/model/userModel.dart';

class Registration extends StatefulWidget {
  Registration({this.phone});

  final String phone;

  _Registration createState() => _Registration();
}

class _Registration extends State<Registration> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController controller = new TextEditingController();
  TextEditingController blood = new TextEditingController();
  TextEditingController dtype = new TextEditingController();

  FocusNode _nameFieldFocus = FocusNode();
  FocusNode _addressFieldFocus = FocusNode();
  FocusNode _aadharFieldFocus = FocusNode();
  FocusNode _licenseFieldFocus = FocusNode();
  FocusNode _marriageField = FocusNode();
  FocusNode _bloodField = FocusNode();
  // FocusNode _type = FocusNode();
  bool _autoValidate = false;

  List<String> bloodGroups = new List<String>();
  List<String> marriagestatus = List<String>();
  List<String> type = List<String>();

  UserModal user = UserModal();


  @override
  void initState() {
    bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    marriagestatus = ['SINGLE', 'MARRIED'];
    type = ['OWNER', 'DRIVER'];
    user.uid = databaseProvider.getCurrentUser().uid;
    user.phoneNumber = databaseProvider.getCurrentUser().phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: true,
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 6.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
                    focusNode: _nameFieldFocus,
                    keyboardType: TextInputType.text,
                    validator: validateName,
                    onSaved: (String val) {
                      user.name = val;
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        MdiIcons.account,
                        color: Colors.grey,
                        size: 30,
                      ),
                      labelText: 'Full Name',
                      hintText: 'Enter your full name here..',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 6.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,),
                    focusNode: _addressFieldFocus,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    autovalidate: _autoValidate,
                    validator: validateAdd,
                    onSaved: (String val) {
                      user.address = val;
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        MdiIcons.home,
                        color: Colors.grey,
                        size: 30,
                      ),
                      labelText: "Address",
                      hintText: 'Same as aadhar card..',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 6.0),
                  child: GestureDetector(
                    child: AbsorbPointer(
                      child: TextFormField(
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,),
                        autovalidate: _autoValidate,
                        // focusNode: _marriageStatus,
                        controller: controller,
                        decoration: InputDecoration(
                          icon: Icon(
                            MdiIcons.menuDown,
                            color: Colors.grey,
                            size: 30,
                          ),
                          labelText: 'Marriage Status',
                          labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                        onSaved: (String value) {
                          user.marriageStatus = value;
                        },
                      ),
                    ),
                    onTap: () => mainBottomSheet(context),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 6.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,),
                    focusNode: _aadharFieldFocus,
                    autovalidate: _autoValidate,
                    // maxLength: 12,
                    keyboardType: TextInputType.phone,
                    validator: validateAadhar,
                    onSaved: (String val) {
                      user.aadharNo = val;
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        MdiIcons.card,
                        color: Colors.grey,
                        size: 30,
                      ),
                      hintText: 'Enter the number here',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      labelText: 'Aadhar Number',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 6.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,),
                    focusNode: _licenseFieldFocus,
                    autovalidate: _autoValidate,
                    // maxLength: 13,
                    keyboardType: TextInputType.emailAddress,
                    validator: validateLicense,
                    onSaved: (String val) {
                      user.licenseNo = val;
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        MdiIcons.car,
                        color: Colors.grey,
                        size: 30,
                      ),
                      labelText: 'License Number',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: "Enter the number here",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 6.0),
                  child: GestureDetector(
                    child: AbsorbPointer(
                      child: TextFormField(
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,),
                        autovalidate: _autoValidate,
                        controller: blood,
                        decoration: InputDecoration(
                          icon: Icon(
                            MdiIcons.invertColors,
                            color: Colors.grey,
                            size: 30,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          labelText: 'Blood Group',
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                        onSaved: (String value) {
                          user.bloodGroup = value;
                        },
                      ),
                    ),
                    onTap: () => bloodBottomSheet(context),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 6.0),
                  child: GestureDetector(
                    child: AbsorbPointer(
                      child: TextFormField(
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,),
                        autovalidate: _autoValidate,
                        controller: dtype,
                        decoration: InputDecoration(
                          icon: Icon(
                            MdiIcons.car,
                            color: Colors.grey,
                            size: 30,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          labelText: 'Type',
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                        onSaved: (String value) {
                          user.driverType = value;
                        },
                      ),
                    ),
                    onTap: () => driverBottomSheet(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.white,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            await Future.delayed(Duration(seconds: 1));
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                'Added Successfully..',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ));

            await Future.delayed(Duration(seconds: 2));
            databaseProvider.registerUser(user).then((v) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (builder) => Imagepicker()));
            }).catchError((onError) {});
          } else {
            setState(() {
              _autoValidate = true;
            });
          }
        },
        child: Icon(
          Icons.keyboard_arrow_right,
          size: 50,
          color: Color(0xffbff6d00),
        ),
      ),
    );
  }

  mainBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Select Marriage Status",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: marriagestatus.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        _nameFieldFocus.unfocus();
                        // _aadharFieldFocus.unfocus();
                        _addressFieldFocus.unfocus();
                        setState(() {
                          controller.text = marriagestatus[index];
                        });
                      },
                      title: Text(marriagestatus[index]),
                    );
                  }),
            ],
          );
        });
  }

  bloodBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Select bloodgroup..",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: bloodGroups.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          _licenseFieldFocus.unfocus();
                          _aadharFieldFocus.unfocus();
                          setState(() {
                            blood.text = bloodGroups[index];
                          });
                        },
                        title: Text(bloodGroups[index]),
                      );
                    }),
              ),
            ],
          );
        });
  }

  driverBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Select The Type",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: type.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        _marriageField.unfocus();
                        // _aadharFieldFocus.unfocus();
                        _bloodField.unfocus();
                        setState(() {
                          dtype.text = type[index];
                        });
                      },
                      title: Text(type[index]),
                    );
                  }),
              // ),
            ],
          );
        });
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (value.length < 3) {
      return "NAME MUST NOT CONTAIN 2 LETTERS";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateAdd(String value) {
    if (value.length == 0) {
      return "Address is Required";
    } else if (value.length <=25) {
      return "Address should be correct";
    }
    return null;
  }

  String validateAadhar(String value) {
    if (value.length != 12) {
      return "Minimum 12 digits are required";
    }
    return null;
  }

  String validateLicense(String value) {
    if (value.length != 13) {
      return "Minimum 13 digits are required";
    }
    return null;
  }
}
