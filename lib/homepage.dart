import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/Provider/database.dart';
import 'package:mobile/editprofile.dart';
import 'package:mobile/googlemaps.dart';
import 'package:mobile/identitycard.dart';
import 'package:mobile/trackingid.dart';
import 'first.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xffb00B274),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            MenuItem(
              name: "Petrol Station",
              icon: Icon(
                Icons.ev_station,
                size: 30.0,
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            MenuItem(
              name: "Track Friend",
              icon: Icon(
                Icons.near_me,
                size: 30.0,
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => TrackingId()));
              },
            ),
            MenuItem(
              name: "Garage",
              icon: Icon(
                MdiIcons.wrench,
                size: 30.0,
              ),
              selected: _selectedIndex == 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            MenuItem(
              name: "Hospital",
              icon: Icon(
                MdiIcons.hospital,
                size: 30.0,
              ),
              selected: _selectedIndex == 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              // Material(
              //   type: MaterialType.canvas,
              //   color: Color(0xffbff6d00),
              //   elevation: 5.0,
              //   child: SafeArea(
              //     child: Image.asset(
              //       'images/Avengers.jpg',
              //       alignment: Alignment.center,
              //       height: 300.0,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              // Divider(
              //   height: 3,
              // ),
              ListTile(
                leading: Icon(
                  MdiIcons.accountCardDetails,
                  size: 30,
                ),
                title: Text(
                  'View Id',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => FlipId(),
                  ));
                },
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                leading: Icon(
                  MdiIcons.accountBoxOutline,
                  size: 30,
                ),
                title: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => EditProfile(),
                    ),
                  );
                },
              ),
              Divider(height: 2),
              ListTile(
                leading: Icon(
                  MdiIcons.powerSettings,
                  size: 30,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  await databaseProvider.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => First()));
                },
              ),
              Divider(
                height: 2,
              ),
            ],
          ),
        ),
      ),
      body: GoogleMaps(),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final Icon icon;
  final bool selected;
  final Function onTap;
  MenuItem({
    @required this.name,
    @required this.icon,
    @required this.selected,
    @optionalTypeArgs this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon.icon,
                color: selected ? Colors.white : Colors.black,
                size: !selected ? icon.size - 7.5 : icon.size,
              ),
              Text(
                "$name",
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontSize: !selected ? 10.0 : 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
