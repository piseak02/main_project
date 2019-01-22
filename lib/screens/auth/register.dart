import 'package:flutter/material.dart';

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


  String _department = '';


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('สมัครสมาชิก'),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'กรอกข้อมูล',
              labelText: 'ชื้อผู้ใช้',
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.vpn_key),
              hintText: 'กรอกข้อมูล',
              labelText: 'รหัสผ่าน',
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.fiber_manual_record),
              hintText: 'กรอกข้อมูล',
              labelText: 'ชื่อสกุล',
            ),
          ),
          FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.account_circle),
                  labelText: 'ตำแหน่ง',
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