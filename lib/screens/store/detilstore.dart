import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:main_project/LoginProject/Register.dart';
import 'package:main_project/constant/url_system.dart';
import 'package:main_project/screens/store/editStore.dart';
import 'package:main_project/screens/store/listStore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:main_project/components/Dialogs.dart';

class detilstore extends StatelessWidget {
  detilstore(this._storeDetails);
 // Dialogs dialogs = new Dialogs();
  final _storeDetails;
DialogsInformation dialog = new DialogsInformation();


  _confirmResult(bool isYes, BuildContext context){
    if(isYes){
      print('delete action');
      // Navigator.pop(context);
      //print(_storeDetails.product);
      Future<Null> deletestore() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final response = await http.delete(url_stock_byid+_storeDetails.id, headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')});
        final responseJson = json.decode(response.body);

        print(responseJson);
        print(responseJson['status']);
        if(responseJson['status'] == 'true'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => listStore()),
          );
        }
        else {
          // Navigator.pop(context);
          dialog.information(context, 'แจ้งเตือน','ไม่สามารถลบข้อมูลได้');
        }
      }

      deletestore();
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
                child: Text('No',style: TextStyle(color: Colors.black),),
              ),
              FlatButton(
                onPressed: () => _confirmResult(true,context),
                child: Text('Yes',style: TextStyle(color: Colors.red),),
              )
            ],
          );
        }
    );
  }


  /*Future<Null> getListStoer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(url_get_stock_rank+prefs.getString('rank'), headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')});
    final responseJson = json.decode(response.body);
    //print(responseJson);
    //print(responseJson['data']);
    _userDetails.clear();
  } */
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(title: new Text('รายการละเอียด')),
    body: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0,top: 20,bottom: 50.0,right: 17.0),
          alignment: Alignment.topLeft,
          child: Table(
              children: [
            TableRow(children: [
              Text('ชื่ออะไหล่',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
              Text(_storeDetails.product,style: TextStyle(fontSize: 20.0,color: Colors.black),),
            ]),
            TableRow(children:[
              Text('จำนวนอะไหล่',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
              Text(_storeDetails.unit.toString(),style: TextStyle(fontSize: 20.0,color: Colors.black),),
            ]),
            TableRow(children:[
              Text('ราคาอะไหล่',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
              Text(_storeDetails.priceunit.toString(),style: TextStyle(fontSize: 20.0,color: Colors.black),),
            ]),
            TableRow(children:[
              Text('ราคารวมสุทธิ',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
              Text(_storeDetails.pricetotal.toString(),style: TextStyle(fontSize: 20.0,color: Colors.black),),
            ]),
          ]),
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
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new editStore(_storeDetails)));
                    },
                    child: Text('แก้ไขข้อมูล'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: ()  {
                     confirm(context,'This is a tutle','ต้องการลบใช่หรือไม่');
                    },
                    child: Text('ลบข้อมูล',style: TextStyle(color: Colors.red),),
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



