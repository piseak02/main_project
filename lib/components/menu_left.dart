import 'dart:io';
import 'package:flutter/material.dart';
import 'package:main_project/constant/size_const.dart';
import 'package:main_project/screens/changePart/listPart.dart';
import 'package:main_project/screens/home/profile.dart';
import 'package:main_project/screens/store/listStore.dart';
import 'package:main_project/screens/home/menu_homepage.dart';
import 'package:main_project/screens/changePart/listPart.dart';

class menuLeft extends StatefulWidget {
  @override
  _menuLeftState createState() => _menuLeftState();
}

class _menuLeftState extends State<menuLeft> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    'N.T.H',
                    style: TextStyle(fontSize: TEXT_LARGE_SIZE),
                  ),
                ),
                accountEmail: Text(
                  'Non Thai Hospital',
                  style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
                ),
                /*decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/bg-head.jpg'))),*/
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border(
                        bottom: BorderSide(width: 1.1, color: Colors.black))),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: AssetImage('assets/nth1.jpg'),
                )),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'หน้าหลัก',
                style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.list),
              title: Text(
                'รายการเปลี่ยนอะไหล่ซ่อม',
                style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => listPart()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text(
                'รายการอะไหล่ทั้งหมด',
                style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => listStore()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                'ข้อมูลส่วนตัว',
                style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => listProfile()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'การตั้งค่า',
                style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
              ),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'ออกจากระบบ',
                style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
              ),
              onTap: () {
                exit(0);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
