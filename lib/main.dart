import 'package:flutter/material.dart';
// import 'package:pilot/first.dart';
import 'package:mobile/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOBILE',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xffb00B274),
        ),
        scaffoldBackgroundColor: Colors.grey.shade300,
      ),
      home: Splash(),
    );
  }
}
