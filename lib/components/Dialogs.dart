library main_project.components.Dialogs;

import 'package:flutter/material.dart';
import 'package:main_project/screens/changePart/listPart.dart';
import 'package:main_project/screens/store/listStore.dart';

class Dialogs {

  _confirmResult(bool isYes, BuildContext context){
    if(isYes){
      print('delete action');
      Navigator.pop(context);
    }
    else {
      print('No action');
      Navigator.pop(context);
    }
  }

  confirm(BuildContext context, String title, String description){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog (
            title: Text(''),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _confirmResult(false,context),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => _confirmResult(true,context),
                child: Text('Yes'),
              )
            ],
          );
        }
    );
  }
}

class DialogsInformation {
  information(BuildContext context, String titel, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('คำเตือน'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ตกลง'),
              )
            ],
          );
        }
    );
  }
}

class DialogAddstore {

  _confirmResult(bool isYes, BuildContext context){
    if(isYes){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => listStore()),
      );
    }

  }

  confirm(BuildContext context, String title, String description){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog (
            title: Text(''),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _confirmResult(true,context),
                child: Text('ตกลง'),
              )
            ],
          );
        }
    );
  }
}

class DialogAddpart {

  _confirmResult(bool isYes, BuildContext context){
    if(isYes){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => listPart()),
      );
    }

  }

  nextPage(BuildContext context, String title, String description){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog (
            title: Text(''),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _confirmResult(true,context),
                child: Text('ตกลง'),
              )
            ],
          );
        }
    );
  }
}
