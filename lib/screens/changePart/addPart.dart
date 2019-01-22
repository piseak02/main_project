import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'contact.dart';


class AddPart extends StatefulWidget {
  AddPart({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddPartState createState() => _AddPartState();
}

class _AddPartState extends State<AddPart> {
  Contact newContact = new Contact();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _departments = <String>['', 'ไอที', 'บริหาร', 'โรงซ่อม', 'ซัพพาย'];
  List<String> _spares = <String>['', 'เมาส์', 'คีย์บอร์ด', 'หูฟัง', 'จอ'];

  String _department = '';
  String _spare = '';

  File _image;
  Future getImageCamera() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = imageFile;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('เพิ่มรายการ'),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.content_paste),
              hintText: 'กรอกข้อมูล',
              labelText: 'เรื่อง',
            ),
          ),
          FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: 'แผนก',
                ),
                isEmpty: _department == '',
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: _department,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        newContact.favoriteColor = newValue;
                        _department = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _departments.map((String value) {
                      return new DropdownMenuItem(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.fiber_manual_record),
              hintText: 'กรอกข้อมูล',
              labelText: 'อาการ',
            ),
          ),
          FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.build),
                  labelText: 'อะไหล่',
                ),
                isEmpty: _spare == '',
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: _spare,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        newContact.favoriteColor = newValue;
                        _spare = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _spares.map((String value) {
                      return new DropdownMenuItem(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.filter_9_plus),
              hintText: 'กรอกข้อมูล',
              labelText: 'จำนวน',
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.monetization_on),
              hintText: 'กรอกข้อมูล',
              labelText: 'ราคา',
            ),
          ),
          Container(
            child: Center(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('                          ')
                    ],
                  ),
                  RaisedButton(
                    textColor: Colors.deepPurple,
                    child: Icon(Icons.add_a_photo),
                    onPressed: getImageCamera,
                  ),
                  Column(
                    children: <Widget>[
                      Text('    ')
                    ],
                  ),
                  RaisedButton(
                    textColor: Colors.deepOrange,
                    child: Icon(Icons.add_a_photo),
                    onPressed: getImageCamera,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Text('หมายเหตุ** สีน้ำเงิน ของใหม่ / สีแดง ของเก่า')
            ],
          ),
          new Container(
              padding: const EdgeInsets.only(left: 40.0, top: 20.0,right: 40.0),
              child: new RaisedButton(
                textColor: Colors.red,
                child: const Text('Save'),
              )),
        ],
      ),
    );
  }
}

class Contact {
  String name;
  DateTime dob;
  String phone = '';
  String email = '';
  String favoriteColor = '';
}