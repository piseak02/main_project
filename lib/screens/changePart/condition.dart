import 'package:flutter/material.dart';

class alertInput {

  confirms(BuildContext context, String title, String description){
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
          );
        }
    );
  }
}