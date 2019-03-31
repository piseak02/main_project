//listProfile
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/constant/url_system.dart';
import 'package:main_project/screens/changePart/detailPart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class listProfile extends StatefulWidget {
  @override
  _listProfileState createState() => _listProfileState();

}

class _listProfileState extends State<listProfile> {
  TextEditingController controller = new TextEditingController();

  String showuser='';
  String showname='';
  String showdate='';
  String showrank='';
//username name date

  Future<Null> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(url_user_byid+prefs.getString('id'), headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')});
    final responseJson = json.decode(response.body);
    //_profileDetails.clear();
    setState(() {
      Map<String, dynamic>  dataProfile = jsonDecode(responseJson['data']);
      showuser = dataProfile['username'];
      showname = dataProfile['name'];
      showrank = dataProfile['rank'];
      showdate = dataProfile['date'];
      showdate = showdate.substring(8,10) +(showdate.substring(4,8)).toString()+(showdate.substring(0,4));


    });
    //print(showdate);
   // print(responseJson['data']);
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(title: new Text('ข้อมูลส่วนตัว')),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0,top: 20,bottom: 50.0,right: 17.0),
            alignment: Alignment.topLeft,
            child: Table(
                children: [
                  TableRow(children:[
                    Text('ชื่อผู้ใช้',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text((showuser == null) ? '' : showuser, style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('ชื่อ-สกุล',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text((showname == null) ? '' : showname, style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('ตำแหน่ง',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text((showrank == null) ? '' : showrank, style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),
                  TableRow(children:[
                    Text('วันที่สร้าง',style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                    Text((showdate == null) ? '' : showdate, style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  ]),

                ]),
          ),
        ],
      ),
    );


  /*  return new Scaffold(
      appBar: new AppBar(
        title: new Text('ข้อมูลส่วนตัว'),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child:  new ListView.builder(
              itemCount: _changDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                  child: new ListTile(
                    leading: const Icon(Icons.person),
                    title: new Text('ชื่อผู้ใช้  '+_changDetails[index].username ,style: TextStyle(fontSize: 19.0,color: Colors.black)),
                    //subtitle: Text('วันที่  '+(_changDetails[index].date.substring(8,10)).toString() +(_changDetails[index].date.substring(4,8)).toString()+(_changDetails[index].date.substring(0,4)).toString() + ' ผู้บันทึก ' + _changDetails[index].namelangh.toString()  ,style: TextStyle(fontSize: 16.0,color: Colors.black45), ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('วันที่  '+(_changDetails[index].date.substring(8,10)).toString() +(_changDetails[index].date.substring(4,8)).toString()+(_changDetails[index].date.substring(0,4)).toString()
                              ,style: TextStyle(fontSize: 16.0,color: Colors.black45),textAlign: TextAlign.left),
                        ),
                        Container(
                          child: Text('แผนก  '+(_changDetails[index].name),style: TextStyle(fontSize: 16.0,color: Colors.black45),),
                        ),
                        Container(
                          child: Text('ผู้บันทึก  '+(_changDetails[index].rank),style: TextStyle(fontSize: 16.0,color: Colors.black45),),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );*/
  }


}


//List<ProfileDetails> _profileDetails = [];



/*class ProfileDetails {
  final String id, story, depratment, symptom, productname, date ,namelangh ,picturenew ,pictureold, username, name, rank   ;
  final int  unit , priceunit ;



  ProfileDetails({this.id,this.story, this.depratment, this.symptom, this.productname, this.unit, this.priceunit, this.date,this.namelangh ,this.picturenew,this.pictureold,this.username,this.name,this.rank });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return new ProfileDetails(

      id: json['id'],
      username: json['username'],
      name: json ['name'],
      rank: json ['rank'],
      date: json ['date'],

    );
  }
}*/





