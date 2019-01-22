import 'package:flutter/material.dart';

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