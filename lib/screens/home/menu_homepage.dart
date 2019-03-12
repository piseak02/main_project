import 'package:flutter/material.dart';
import 'package:main_project/components/menu_left.dart';
import 'package:main_project/constant/size_const.dart';
import 'package:main_project/screens/changePart/listPart.dart';
import 'package:main_project/screens/store/listStore.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าหลัก', style: TextStyle(fontSize: TEXT_LARGE_SIZE)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black, width: 1.0)),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 7.0, left: 16.0, bottom: 0.0),
                        child: Text(
                          'รายการเปลี่ยนอะไหล่ซ่อม',
                          style: TextStyle(fontSize: TEXT_LARGE_SIZE),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: Text(
                          '22 รายการ',
                          style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
                        ),
                        subtitle: Text(
                          'จำนวนข้อมูลรายการเปลี่ยนอะไหล่งานซ่อม',
                          style: TextStyle(fontSize: TEXT_SMALL_SIZE),
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => listPart()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black, width: 1.0)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 7.0, left: 16.0, bottom: 0.0),
                        child: Text(
                          'รายการอะไหล่ทั้งหมด',
                          style: TextStyle(fontSize: TEXT_LARGE_SIZE),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: Text(
                          '100 รายการ',
                          style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
                        ),
                        subtitle: Text(
                          'จำนวนรายการอะไหล่ทั้งหมด',
                          style: TextStyle(fontSize: TEXT_SMALL_SIZE),
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => listStore()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: menuLeft(),
    );
  }
}
