import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/model/userModel.dart';
import 'package:mobile/updateprofilephoto.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController bloodController = new TextEditingController();
  TextEditingController uniqueIdController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  void initState() {
    uniqueIdController.text = currentUser.uid;
    nameController.text = currentUser.name;
    bloodController.text = currentUser.bloodGroup;
    phoneController.text = currentUser.phoneNumber;
    print('NUMBER:-${currentUser.phoneNumber}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: ('Edit Profile'),
            icon: Icon(
              MdiIcons.accountEdit,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Material(
                color: Colors.grey.shade300,
                elevation: 10.0,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: ClipOval(
                      child: Image.network(
                        currentUser.profileUrl,
                        scale: 0.2,
                        width: 220,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: IconButton(
                  icon: Icon(
                    MdiIcons.camera,
                    size: 45,
                    color: Color(0xffb00B274),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => UpdateProfile()));
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 6.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    enabled: false,
                    controller: uniqueIdController,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(
                        MdiIcons.accountCardDetails,
                        color: Colors.grey,
                        size: 35,
                      ),
                      labelText: 'Unique Id',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 6.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: nameController,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(
                        MdiIcons.accountBox,
                        color: Colors.grey,
                        size: 35,
                      ),
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 6.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    enabled: false,
                    controller: phoneController,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(
                        MdiIcons.phone,
                        color: Colors.grey,
                        size: 35,
                      ),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 6.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    enabled: false,
                    controller: bloodController,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(
                        MdiIcons.invertColors,
                        color: Colors.grey,
                        size: 35,
                      ),
                      labelText: 'Blood Group',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
