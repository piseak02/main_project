import 'package:flutter/material.dart';
import 'package:main_project/screens/home/menu_homepage.dart';
import 'LoginProject/FormLogin.dart';
import 'package:main_project/screens/changePart/addPart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo010000',
      theme: ThemeData(
      ),
      home: Home(),
    );
  }
}





