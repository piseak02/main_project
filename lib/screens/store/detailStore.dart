import 'package:flutter/material.dart';
import 'package:main_project/screens/store/editStore.dart';

import 'package:main_project/screens/Dialogs.dart';


class SecondPage extends StatelessWidget {
  SecondPage(this.data);
  final data;
  Dialogs dialogs = new Dialogs();
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(title: new Text('รายการละเอียด')),
    body: ListView(
      children: <Widget>[
        Container(
          width: 150.0,
          height: 150.0,
          decoration: new BoxDecoration(
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              image: new NetworkImage(data["picture"]["large"]),
              fit: BoxFit.cover,
            ),
            border: new Border.all(
              color: Colors.red,
              width: 4.0,
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: ()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => editStore()),
                      );
                    },
                    child: Text('แก้ไขข้อมูล',),

                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: ()  {
                      dialogs.confirm(context,'This is a tutle','ต้องการลบใช่หรือไม่');
                    },
                    child: Text('ลบข้อมูล'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
