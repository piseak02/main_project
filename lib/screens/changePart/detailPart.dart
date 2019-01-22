import 'package:flutter/material.dart';
import 'package:main_project/screens/changePart/editPart.dart';
import 'package:main_project/screens/Dialogs.dart';
import 'package:main_project/screens/changePart/listPart.dart';


class SecondPage extends StatelessWidget {
  SecondPage(this._userDetails);
  final _userDetails;
 Dialogs dialogs = new Dialogs();
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(title: new Text('รายการละเอียด')),
    body: ListView(
      children: <Widget>[
        Container(
         child: Column(
           children: <Widget>[
             Text(_userDetails.Address),
             Text(_userDetails.firstName),
             Text(_userDetails.city),
           ],
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
                        MaterialPageRoute(builder: (context) => editPart()),
                      );
                    },
                    child: Text('แก้ไขข้อมูล'),
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


