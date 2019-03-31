
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Register.dart';
import 'dart:convert';
import 'package:main_project/components/Dialogs.dart';
import 'package:main_project/screens/home/menu_homepage.dart';
import 'package:main_project/constant/url_system.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController ctrUsername = TextEditingController();
  TextEditingController ctrPassword = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<Null> doLogin() async {
    final _headers = {'Content-Type': 'application/json'};

    print('start login');
    String jsonContact = json.encode({'username':ctrUsername.text, 'password':ctrPassword.text});
    final response = await http.post(url_login, headers: _headers, body: jsonContact);

    DialogsInformation dialogs = new DialogsInformation();

    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      if(jsonResponse['status'] == 'true'){
        //login success
          var dataResponse = json.decode(jsonResponse['data']);
         // print(dataResponse['token']);
          //print(dataResponse['access']['status']);

          if(dataResponse['access']['status'] == 'open'){
            //add to sharepreferrent
            //---todo
            //open page home
            //---todo
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token',dataResponse['token'] );
            prefs.setString('lavel',dataResponse['lavel'] );
            prefs.setString('username',dataResponse['username'] );
            prefs.setString('rank',dataResponse['rank'] );
            prefs.setString('name',dataResponse['name'] );
            prefs.setString('id',dataResponse['id'] );
           print(prefs.getString('id')); //วิธีใช้

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );

          }else{
            //login error
            //print('no login');
            dialogs.information(context, 'แจ้งเตือน','ชื่อผู้ใช้ไม่ถูกต้อง');
          }

      }else{
          //login error
        //print('no login');
        dialogs.information(context, 'แจ้งเตือน','ชื่อผู้ใช้ไม่ถูกต้อง');
      }
    }else {
      //login error
      dialogs.information(context, 'แจ้งเตือน','ชื่อผู้ใช้ไม่ถูกต้อง');
      //print('no login');
    }
  }



  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      key: _scaffoldKey,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/pop.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 50.0 , vertical: 150.00),
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'กรอกชื่อผู้ใช้งาน',
                  labelText: 'ชื่อผู้ใช้',
                ),
               controller: ctrUsername,
              ),
              new TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.local_parking),
                  hintText: 'กรอกรหัสผ่าน',
                  labelText: 'รหัสผ่าน',
                ),
                controller: ctrPassword,
              ),
              new Container(
                  padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                  child: new RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: const Text('เข้าสู่ระบบ'),
                    onPressed: () => doLogin(),
                  )),
                 new Container(
                  padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                  child: new RaisedButton(
                    child: const Text('สมัครสมาชิก'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}



