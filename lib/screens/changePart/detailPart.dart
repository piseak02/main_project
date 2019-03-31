import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:main_project/constant/url_system.dart';
import 'package:main_project/screens/changePart/editPart.dart';
import 'package:main_project/components/Dialogs.dart';
import 'package:main_project/screens/changePart/listPart.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';  //_changDetails  DetailChang

class DetailChang  extends StatelessWidget {
  DetailChang (this._changDetails);
  Dialogs dialogs = new Dialogs();
  final _changDetails;
  DialogsInformation dialog = new DialogsInformation();

  _confirmResult(bool isYes, BuildContext context){
    if(isYes){
      print('delete action');
      // Navigator.pop(context);
      Future<Null> deletestore() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final response = await http.delete(url_delate_chang+_changDetails.id, headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')});
        final responseJson = json.decode(response.body);

       // print(responseJson);
       // print(responseJson['status']);
        if(responseJson['status'] == 'true'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => listPart()),
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

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(title: new Text('รายการละเอียด')),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0,top: 20,bottom: 50.0,right: 18.0),
            alignment: Alignment.topLeft,
           child: Table(
                children: [
                  TableRow(children: [
                    Text('ชื่อเรื่อง',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text(_changDetails.story,style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('แผนก',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text(_changDetails.depratment.toString(),style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('อาการ',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text(_changDetails.symptom.toString(),style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('อะไหล่',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text(_changDetails.productname.toString(),style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('จำนวน',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text(_changDetails.unit.toString(),style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('ราคา',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text(_changDetails.priceunit.toString(),style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('รูปอุปกรณ์ใหม่',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    (_changDetails.picturenew == null) ? Text('') : Image.network(_changDetails.picturenew, width: 150.0, height: 150.0,),
                  ]),
                  TableRow(children:[
                    Text('',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text(''),
                  ]),
                  TableRow(children:[
                    Text('รูปอุปกรณ์เก่า',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    ( _changDetails.pictureold == null) ? Text('') : Image.network(_changDetails.pictureold, width: 150.0, height: 150.0,),
                  ]),
                ]),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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

}


