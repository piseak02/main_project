import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:main_project/components/Dialogs.dart';
import 'package:main_project/constant/url_system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:main_project/components/loader.dart';

class Addstore  extends StatefulWidget {
  Addstore ({Key key, this.contact}) : super(key: key);
  final String contact;

  @override
  _AddstoreState createState() => new _AddstoreState();
}

class _AddstoreState extends State<Addstore > {
  TextEditingController ctrproduct = TextEditingController();
  TextEditingController ctrunit= TextEditingController();
  TextEditingController ctrpriceunit = TextEditingController();
  TextEditingController ctrpricetotal = TextEditingController();
  DialogsInformation dialog = new DialogsInformation();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Future<Null> addstore() async {


    if (ctrproduct.text == '' || ctrunit.text == '' || ctrpriceunit.text == '' || ctrpricetotal.text == '' ) {
      dialog.information(context, 'แจ้งเตือน','ไม่สามารถเพิ่มมูลได้');
    }

    else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //String json = _toJson(contact,prefs.getString('username'),prefs.getString('rank'));
      print('start addstore');
      var jsonStore = json.encode({
        'productname': ctrproduct.text,
        'unit': int.parse(ctrunit.text),
        'priceunit': double.parse(ctrpriceunit.text),
        'pricetotal': double.parse(ctrpricetotal.text),
        'username':prefs.getString('username'),
        'rank':prefs.getString('rank')
      });
      //print(jsonStore);
      // print(prefs.getString('token'));
      final response = await http.post(url_stock, headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')}, body: jsonStore);
      // print(response.body);
      DialogsInformation dialogs = new DialogsInformation();
      DialogAddstore dialogsStore  = new DialogAddstore ();
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        if(jsonResponse['status'] == 'true'){
          dialogsStore.confirm(context, 'ข้อความ', 'บันทึกข้อมูลสำเร็จ');
          //ColorLoader();
        }
        else{
          //login error
          //print('no login');
          dialogs.information(context, 'ข้อความ','ไม่สามารถบันทึกข้อมูลได้');
        }
      }
      else {
        //login error
        dialogs.information(context, 'ข้อความ','ไม่สามารถบันทึกข้อมูลได้');
        //print('no login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('เพิ่มสต็อก'),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.content_paste),
                      hintText: 'กรอก ชื่ออุปกรณ์',
                      labelText: 'ชื่ออุปกรณ์',
                    ),
                    controller: ctrproduct,
                    validator: (val) => val.isEmpty ? 'กรุณาสร้างชื่อ อุปกรณ์' : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.filter_9_plus),
                      hintText: 'กรอกจำนวนอุปกรณ์',
                      labelText: 'จำนวนอุปกรณ์',
                    ),
                    controller: ctrunit,
                    keyboardType: TextInputType.number,
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'กรุณากรอกจำนวนอุปกรณ์' : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.monetization_on),
                      hintText: 'กรอกราคา',
                      labelText: 'ราคา',
                    ),
                    controller: ctrpriceunit,
                    keyboardType: TextInputType.number,
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'กรุณากรอกราคา' : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.monetization_on),
                      hintText: 'กรอกราคารวม',
                      labelText: 'ราคารวม',
                    ),
                    controller: ctrpricetotal,
                    keyboardType: TextInputType.number,
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'กรุณากรอกราคารวม' : null,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        color: Theme.of(context).accentColor,
                        child: const Text('บันทึก'),
                        onPressed: () => addstore(),
                      )),
                ],
              ))),
    );
  }
}





/*class ContactService {

  Future<Contact> createContact(Contact contact) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String json = _toJson(contact,prefs.getString('username'),prefs.getString('rank'));
      
      const _serviceUrl = 'https://project-changepart.herokuapp.com/stock';
      
     // print(prefs.getString('token'));
      final response = await http.post(_serviceUrl,
          headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')}, body: json);
      //var jsonResponse = json.decode(response.body);
      //if(jsonResponse['status'] == 'true'){}
      print(response.body[0]);
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }


}*/