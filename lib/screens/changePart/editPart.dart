import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/components/Dialogs.dart';
import 'package:main_project/constant/url_system.dart';
import 'package:main_project/screens/changePart/condition.dart';
import 'package:main_project/screens/changePart/listPart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class editPart extends StatelessWidget {

  editPart(this.CheangDetails);
  // Dialogs dialogs = new Dialogs();
  final CheangDetails;
  DialogsInformation dialog = new DialogsInformation();

  TextEditingController ctrStory = TextEditingController();
  TextEditingController ctrdepratment= TextEditingController();
  TextEditingController ctrsymptom = TextEditingController();
  TextEditingController ctrstock = TextEditingController();
  TextEditingController ctrunit = TextEditingController();
  TextEditingController ctrprice = TextEditingController();

  @override
  Widget build(BuildContext context) {

    ctrStory.text = CheangDetails.story;
    ctrdepratment.text = CheangDetails.depratment;
    ctrsymptom.text = CheangDetails.symptom;
    ctrstock.text = CheangDetails.productname;
    ctrunit.text = CheangDetails.unit.toString();
    ctrprice.text = CheangDetails.priceunit.toString();
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


    Future<Null> updateStore() async {

      if (ctrStory.text == '' || ctrdepratment.text == '' || ctrsymptom.text == '' || ctrstock.text == '' || ctrunit.text == '' || ctrprice.text == '') {
        dialog.information(context, 'แจ้งเตือน','ไม่สามารถแก้ไขข้อมูลได้');
      }
      else {

        SharedPreferences prefs = await SharedPreferences.getInstance();

        var jsonStore = json.encode({
          'title': ctrStory.text,
          'department': ctrdepratment.text,
          'symptom': ctrsymptom.text,
          'productname': ctrstock.text,
          'unit': int.parse(ctrunit.text),
          'priceunit': double.parse(ctrprice.text),
          'username':prefs.getString('username'),
          'rank':prefs.getString('rank')
        });

        final response = await http.put(url_update_part+CheangDetails.id , headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')},body: jsonStore);

        final responseJson = json.decode(response.body);

      //  print(responseJson);

        if(responseJson['status'] == 'true'){
          /// todo ทำเชค หน้าลบรายการ

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => listPart()),
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
                labelText: 'ชื่อเรื่อง',
              ),
              validator: (val) => val.isEmpty ? 'แก้ไข ชื่อเรื่อง' : null,
              controller: ctrStory,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.filter_9_plus),
                hintText: 'กรอกข้อมูล',
                labelText: 'แผนก',
              ),
              validator: (val) => val.isEmpty ? 'แก้ไข แผนก' : null,
              controller: ctrdepratment,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.monetization_on),
                hintText: 'กรอกข้อมูล',
                labelText: 'อาการ',
              ),
              controller: ctrsymptom,
              validator: (val) => val.isEmpty ? 'แก้ไข อาการ' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.monetization_on),
                hintText: 'กรอกข้อมูล',
                labelText: 'อุปกรณ์',
              ),
              validator: (val) => val.isEmpty ? 'แก้ไข อุปกรณ์' : null,
              controller: ctrstock,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.monetization_on),
                hintText: 'กรอกข้อมูล',
                labelText: 'จำนวน',
              ),
              keyboardType: TextInputType.number,
              validator: (val) => val.isEmpty ? 'แก้ไข จำนวน' : null,
              controller: ctrunit,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.monetization_on),
                hintText: 'กรอกข้อมูล',
                labelText: 'ราคา',
              ),
              validator: (val) => val.isEmpty ? 'แก้ไข ราคา' : null,
              controller: ctrprice,
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
