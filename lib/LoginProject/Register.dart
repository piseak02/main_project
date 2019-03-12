import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_project/LoginProject/FormLogin.dart';
import 'package:main_project/components/Dialogs.dart';
import 'package:main_project/constant/url_system.dart';


class Register  extends StatefulWidget {
  Register ({Key key, this.contact}) : super(key: key);
  final String contact;

  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register > {
  DialogsInformation dialog = new DialogsInformation();
  DialogShow dialognext = new DialogShow();

  TextEditingController ctrusername = TextEditingController();
  TextEditingController ctrpassword = TextEditingController();
  TextEditingController ctrname = TextEditingController();
  TextEditingController ctrrank = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _dep = '';
  List<DepDetail> _deps = [];
  List<String> _deps_all = <String>[''];

  Future<Null> getDataLoad() async {

    final getrankurl = await http.get(url_select_department);
    final responseJson = await json.decode(getrankurl.body);
    final responseJsonData = await json.decode(responseJson['data']);

   // print(responseJsonData);
    //print(responseJsonData[0]['name']);
    //_deps.clear();
    //_deps_all.clear();

    setState(() {
      for (Map deppp in responseJsonData) {
        _deps.add(DepDetail.fromJson(deppp));
      }

      for(int i=0; i <= (_deps.length-1); i++ ){
        _deps_all.add(_deps[i].name);
      }
      //print(_deps_all);
    });
  }


  Future<Null> AddRegister() async {

    if (ctrusername.text == '' || ctrpassword.text == '' || ctrname.text == '' || ctrrank.text == '' ) {
      dialog.information(context, 'แจ้งเตือน','ไม่สามารถแก้ไขข้อมูลได้');
    }
    else {
      String jsonRejister = json.encode({
        'username': ctrusername.text,
        'password': ctrpassword.text,
        'name': ctrname.text,
        'rank': ctrrank.text,
      });

      final response = await http.post(url_create_user, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer '
      }, body: jsonRejister);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'true') {
          print('conncet action');
        } else {
          //login error
          print('no action');
        }
      } else {
        //login error
        print('no noaction');
      }
      dialognext.nextpage(context, '', 'บันทึกสำเร็จ');
    }
  }

  @override
  void initState() {
    super.initState();

    getDataLoad();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('สมัครสมาชิก'),
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
                      icon: const Icon(Icons.person),
                      hintText: 'สร้างผู้ใช้',
                      labelText: 'ผู้ใช้',
                    ),
                    controller: ctrusername,
                    validator: (val) =>
                    val.isEmpty
                        ? 'กรุณาสร้างชื่อ ผู้ใช้'
                        : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.vpn_key),
                      hintText: 'สร้างรหัสผ่าน',
                      labelText: 'รหัสผ่าน',
                    ),
                    controller: ctrpassword,
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>
                    val.isEmpty
                        ? 'กรุณาสร้าง รหัสผ่าน'
                        : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.font_download),
                      hintText: 'สร้าง ชื่อผู้เข้าใช้งาน',
                      labelText: 'ชื่อผู้เข้าใช้งาน',
                    ),
                    controller: ctrname,
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>
                    val.isEmpty
                        ? 'กรุณาสร้าง ชื่อผู้เข้าใช้งาน'
                        : null,
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.color_lens),
                          labelText: 'แผนก',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _dep == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            hint: new Text("กรุณาเลือก"),
                            value: _dep,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _dep = newValue;
                                state.didChange(newValue);
                                ctrrank.text = newValue;
                              });
                            },
                            items: _deps_all.map((String value) {
                              return new DropdownMenuItem(
                                child: new Text(value),
                                value: value,
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (val) {
                      return val != '' ? null : 'Please select a color';
                    },
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        color: Theme.of(context).accentColor,
                        child: const Text('บันทึก'),
                        onPressed: () => AddRegister(),
                      )),
                ],
              ))),
    );
  }
}

//List<DepDetail> _depdetail = [];

class DepDetail {
  final String  name;


  DepDetail({this.name});

  factory DepDetail.fromJson(Map<String, dynamic> json) {
    return new DepDetail(
      name: json ['name'],
    );
  }
}


class DialogShow {
  nextpage(BuildContext context, String titel, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                ),
                child: Text('ตกลง'),
              )
            ],
          );
        }
    );
  }
}




