import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/components/Dialogs.dart';
import 'package:main_project/constant/url_system.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddPart extends StatefulWidget {
  AddPart({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddPartState createState() => _AddPartState();
}


class _AddPartState extends State<AddPart> {

  /// ******  Get department ******* สร้างตัวแปล รับ ลิตดรอปดาว
  String _deppart = '';
  List<DepPart> _depart = [];
  List<String> _deps_all = <String>[''];

  /*/// ******  Get stook ******* สร้างตัวแปล รับ ลิตสต็อค /// */

  String _stockpart = '';
  List<StockPart> _stockparts = [];
  List<String> _stock_all = <String>[''];


  TextEditingController ctrStory = TextEditingController();
  TextEditingController ctrdepratment = TextEditingController();
  TextEditingController ctrsymptom = TextEditingController();
  TextEditingController ctrstock = TextEditingController();
  TextEditingController ctrunit = TextEditingController();
  TextEditingController ctrprice = TextEditingController();

  DialogsInformation dialog = new DialogsInformation();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  File _image1;
  File _image2;

  Future<Null> getDatadep() async {
    // todo ฟังชั่น get department
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final getdepartment = await http.get(url_select_department, headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')});
    final responseJson_GetDepartment = await json.decode(getdepartment.body);
    final responseJsonData_Department = await json.decode(responseJson_GetDepartment['data']);

    //print(responseJsonData_Department);
    //print(responseJsonData_Department[0]['name']);

    setState(() {
      for (Map deppart in responseJsonData_Department) {
        _depart.add(DepPart.fromJson(deppart));
      }

      for(int i=0; i <= (_depart.length-1); i++ ){
        _deps_all.add(_depart[i].name);
      }
      //print(_deps_all);
    });
  }

  Future<Null> getDataStock() async {
    // todo ฟังชั่น get stock
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final getStock = await http.get(url_get_stock_rank+prefs.getString('rank'), headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')});
    final responseJson_getStock = await json.decode(getStock.body);
    final responseJsonData_stock = await json.decode(responseJson_getStock['data']);

    //print(responseJsonData_stock[0]['productname']);
    // print(responseJsonData_stock);
    //print(StockPart);

    setState(() {
      for (Map stockdata in responseJsonData_stock) {
        _stockparts.add(StockPart.fromJson(stockdata));
      }

      for(int i=0; i <= (_stockparts.length-1); i++ ){
        _stock_all.add(_stockparts[i].name);
      }
      //print(_stock_all);
    });
  }

  @override
  void initState() {
    super.initState();

    getDatadep();
    getDataStock();
  }



    Future getImage1() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _image1 = image;
      });
    }

    Future getImage2() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _image2 = image;
      });
    }



  @override
    Widget build(BuildContext context) {
///*****
    Future<Null> addpart() async {
      //todo ฟังชั่นเซฟ

      if (ctrStory.text == '' || ctrdepratment.text == '' || ctrsymptom.text == '' || ctrstock.text == '' || ctrunit.text == '' || ctrprice.text == '' || _image1 == null ) {
        dialog.information(context, 'แจ้งเตือน','ไม่สามารถเพิ่มมูลได้');
      }
      else {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        var jsonAddPart = json.encode({
          'title': ctrStory.text,
          'department': ctrdepratment.text,
          'symptom': ctrsymptom.text,
          'productname': ctrstock.text,
          'unit': int.parse(ctrunit.text),
          'priceunit': double.parse(ctrprice.text),
          'username':prefs.getString('username'),
          'rank':prefs.getString('rank'),
          'name':prefs.getString('name'),

        });

        final response = await http.post(url_insert_part, headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')}, body: jsonAddPart);

        //  print(response.body);

        DialogsInformation dialogs = new DialogsInformation();
        DialogAddpart nextPagepart  = new DialogAddpart ();
        if(response.statusCode == 200){
          var jsonResponse = json.decode(response.body);
          if(jsonResponse['status'] == 'true'){

            var jsonResponseData = json.decode(jsonResponse['data']);

            // print(jsonResponseData['id']);

            var dataId = jsonResponseData['id'];
            var typeImg = '';
            if(_image1 != null ) {
              typeImg = 'new';

              Map<String, String> headers = {
                "Authorization": "Bearer "+prefs.getString('token'),
                "Content-Type": "multipart/form-data"
              };

              var stream = new http.ByteStream(DelegatingStream.typed(_image1.openRead()));
              final length = await _image1.length();
              var uri = Uri.parse(url_upload_part);
              var request = new http.MultipartRequest("POST", uri);
              request.headers.addAll(headers);
              request.fields['data_id'] = dataId;
              request.fields['typeImg'] = typeImg;
              request.files.add(new http.MultipartFile('file', stream, length, filename: basename(_image1.path)));

              http.Response response = await http.Response.fromStream(await request.send());
              //print("Result: ${response.body}");

            }//end if _image1

            if(_image2 != null){
              typeImg = 'old';

              Map<String, String> headers = {
                "Authorization": "Bearer "+prefs.getString('token'),
                "Content-Type": "multipart/form-data"
              };

              var stream = new http.ByteStream(DelegatingStream.typed(_image2.openRead()));
              final length = await _image2.length();
              var uri = Uri.parse(url_upload_part);
              var request = new http.MultipartRequest("POST", uri);
              request.headers.addAll(headers);
              request.fields['data_id'] = dataId;
              request.fields['typeImg'] = typeImg;
              request.files.add(new http.MultipartFile('file', stream, length, filename: basename(_image2.path)));

              http.Response response = await http.Response.fromStream(await request.send());
            }//end if _image1

            nextPagepart.nextPage(context, 'ข้อความ', 'บันทึกข้อมูลสำเร็จ');
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

      // jsonAddPart
    }
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('เพิ่มรายการ'),
        ),
        body: new SafeArea(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: ListView(
              padding: EdgeInsets.only(right: 20.0,left: 20.0),
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.content_paste),
                    hintText: 'กรอกข้อมูล',
                    labelText: 'เรื่อง',
                  ),
                  controller: ctrStory,
                  validator: (val) => val.isEmpty ? 'กรุณาสร้างชื่อ เรื่อง' : null,
                ),
                new FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.accessibility),
                        labelText: 'แผนก',
                        errorText: state.hasError ? state.errorText : null,
                      ),
                      isEmpty: _deppart == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton<String>(
                          hint: new Text("กรุณาเลือก"),
                          value: _deppart,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _deppart = newValue;
                              state.didChange(newValue);
                              ctrdepratment.text = newValue;
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
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.fiber_manual_record),
                    hintText: 'กรอกข้อมูล',
                    labelText: 'อาการ',
                  ),
                  controller: ctrsymptom,
                  validator: (val) => val.isEmpty ? 'กรุณาระบุ อาการ' : null,
                ),
               new FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.build),
                        labelText: 'อะไหล่',
                        errorText: state.hasError ? state.errorText : null,
                      ),
                      isEmpty: _stockpart == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton<String>(
                          hint: new Text("กรุณาเลือก"),
                          value: _stockpart,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _stockpart = newValue;
                              state.didChange(newValue);
                              ctrstock.text = newValue;
                            });
                          },
                          items: _stock_all.map((String value) {
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
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.filter_9_plus),
                    hintText: 'กรอกข้อมูล',
                    labelText: 'จำนวน',
                  ),
                  controller: ctrunit,
                  keyboardType: TextInputType.number,
                  validator: (val) => val.isEmpty ? 'กรุณาระบุ จำนวน' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.monetization_on),
                    hintText: 'กรอกข้อมูล',
                    labelText: 'ราคา',
                  ),
                  controller: ctrprice,
                  keyboardType: TextInputType.number,
                  validator: (val) => val.isEmpty ? 'กรุณาระบุ ราคา' : null,
                ),
                new Container(
                    padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                    width: 120.0,
                    height: 80.0,
                    child: new RaisedButton(
                      color: Colors.amber,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.camera_alt),
                          Text("(รูปอุปกรณ์ใหม่)")
                        ],
                      ),
                      onPressed: getImage1,
                    )),
                Container(
                  height: _image1 == null
                      ? 0.0
                      : 200.0,
                  child: Center(
                    child: _image1 == null
                        ? Text('')
                        : Image.file(_image1),
                  ),
                ),


                new Container(
                    padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                    width: 120.0,
                    height: 80.0,
                    child: new RaisedButton(
                      color: Colors.amber,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.camera_alt),
                          Text("(รูปอุปกรณ์เก่า)")
                        ],
                      ),
                      onPressed: getImage2,
                    )),
                Container(
                  height: _image2 == null
                      ? 0.0
                      : 200.0,
                  child: Center(
                    child: _image2 == null
                        ? Text('')
                        : Image.file(_image2),
                  ),
                ),
                new Container(
                    padding: const EdgeInsets.only(left: 40.0, top: 20.0 ,bottom: 20.0),
                    child: new RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: const Text('บันทึก'),
                      onPressed: () => addpart(),
                    )),
              ],
            ),
          ),
        ),
      );
    }
  }


class DepPart {
  final String  name;


  DepPart({this.name});

  factory DepPart.fromJson(Map<String, dynamic> json) {
    return new DepPart(
      name: json ['name'],
    );
  }
}

class StockPart {
  final String  name;
  StockPart({this.name});
  factory StockPart.fromJson(Map<String, dynamic> json) {
    return new StockPart(
      name: json ['productname'],
    );
  }
}


///editPart