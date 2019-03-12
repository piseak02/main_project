import 'package:flutter/material.dart';
import 'package:main_project/LoginProject/FormLogin.dart';
import 'package:main_project/LoginProject/Register.dart';
import 'package:main_project/screens/home/menu_homepage.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ระบบแจ้งเปลี่ยนอะไหล่งานซ่อม',
      theme: ThemeData(
      ),
      home: MyHomePage(),
    );
  }
}





