import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:main_project/components/Dialogs.dart';
import 'package:main_project/constant/url_system.dart';
import 'package:main_project/screens/store/listStore.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


class editStore extends StatelessWidget {
  editStore(this._storeDetails);
  // Dialogs dialogs = new Dialogs();
  final _storeDetails;
  DialogsInformation dialog = new DialogsInformation();

  TextEditingController ctrproduct = TextEditingController();
  TextEditingController ctrunit= TextEditingController();
  TextEditingController ctrpriceunit = TextEditingController();
  TextEditingController ctrpricetotal = TextEditingController();

  @override
  Widget build(BuildContext context) {

    ctrproduct.text = _storeDetails.product;
    ctrunit.text = _storeDetails.unit.toString();
    ctrpriceunit.text = _storeDetails.priceunit.toString();
    ctrpricetotal.text = _storeDetails.pricetotal.toString();
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


    Future<Null> updateStore() async {

      if (ctrproduct.text == '' || ctrunit.text == '' || ctrpriceunit.text == '' || ctrpricetotal.text == '' ) {
        dialog.information(context, 'แจ้งเตือน','ไม่สามารถแก้ไขข้อมูลได้');
      }
      else {

        SharedPreferences prefs = await SharedPreferences.getInstance();

        var jsonStore = json.encode({
          'productname': ctrproduct.text,
          'unit': int.parse(ctrunit.text),
          'priceunit': double.parse(ctrpriceunit.text),
          'pricetotal': double.parse(ctrpricetotal.text),
          'username':prefs.getString('username'),
          'rank':prefs.getString('rank')
        });

        final response = await http.put(url_stock_byid+_storeDetails.id, headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')},body: jsonStore);

        final responseJson = json.decode(response.body);

       // print(responseJson);

        if(responseJson['status'] == 'true'){
          /// todo ทำเชค หน้าลบรายการ

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => listStore()),
          );
        }
        else {
          // Navigator.pop(context);
          dialog.information(context, 'แจ้งเตือน','ไม่สามารถแก้ไขข้อมูลได้');
        }
      }
    }



   /// print(_userDetails.product);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('แก้ไขรายการ'),
      ),
      body: Form(
        autovalidate: true,
        child:
      ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.content_paste),
              hintText: 'กรอกข้อมูล',
              labelText: 'ชื่อ',
            ),
            validator: (val) => val.isEmpty ? 'สร้างชื่อ อุปกรณ์' : null,
             controller: ctrproduct,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.filter_9_plus),
              hintText: 'กรอกข้อมูล',
              labelText: 'จำนวน',
            ),
            validator: (val) => val.isEmpty ? 'ระบุจำนวน อุปกรณ์' : null,
            controller: ctrunit,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.monetization_on),
              hintText: 'กรอกข้อมูล',
              labelText: 'ราคา',
            ),
            controller: ctrpriceunit,
            validator: (val) => val.isEmpty ? 'ระบุราคา อุปกรณ์' : null,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.monetization_on),
              hintText: 'กรอกข้อมูล',
              labelText: 'ราคารวม',
            ),
            validator: (val) => val.isEmpty ? 'ระบุราคารวม อุปกรณ์' : null,
            controller: ctrpricetotal,
            keyboardType: TextInputType.number,
          ),
          new Container(
              padding: const EdgeInsets.only(left: 40.0, top: 20.0),
              child: new RaisedButton(
                color: Theme.of(context).accentColor,
                child: const Text('บันทึก'),
                onPressed: () => updateStore(),
              )),
        ],
      ),
      ),
    );
  }

}

