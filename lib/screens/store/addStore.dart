
import 'package:flutter/material.dart';



class Addstore extends StatefulWidget {
  @override
  _AddstoreState createState() => _AddstoreState();
}

class _AddstoreState extends State<Addstore> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('เพิ่มอะไหล่'),
        ),
        body: ListView(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.content_paste),
                hintText: 'กรอกข้อมูล',
                labelText: 'ชื่อ',
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.filter_9_plus),
                hintText: 'กรอกข้อมูล',
                labelText: 'จำนวน',
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.monetization_on),
                hintText: 'กรอกข้อมูล',
                labelText: 'ราคา',
              ),
            ),
            new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0,right: 40.0),
                child: new RaisedButton(
                  textColor: Colors.red,
                  child: const Text('Save'),
                )),
          ],
        ),
    );
  }
}



class Contact {
  String name;
  DateTime dob;
  String phone = '';
  String email = '';
  String favoriteColor = '';
}