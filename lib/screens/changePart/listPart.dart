import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:main_project/components/menu_left.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/constant/url_system.dart';
import 'package:main_project/screens/changePart/addPart.dart';
import 'package:main_project/screens/changePart/detailPart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class listPart extends StatefulWidget {
  @override
  _listPartState createState() => _listPartState();
}

class _listPartState extends State<listPart> {
  TextEditingController controller = new TextEditingController();


  // Get json result and convert it to model. Then add   ********************************************************
  Future<Null> getListPart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(url_select_list_part+prefs.getString('rank'), headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')});
    final responseJson = json.decode(response.body);

    _changDetails.clear();
    setState(() {
      for (Map datacheng in json.decode(responseJson['data'])) {
        _changDetails.add(CheangDetails.fromJson(datacheng));
      }
    // print(responseJson['data']);
    });
  }

  @override
  void initState() {
    super.initState();


    getListPart();
  }

  @override
  Widget build(BuildContext context) {
    Widget floatingAction = FloatingActionButton(
      backgroundColor: Colors.blueAccent,
      onPressed: () async {
        var response = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddPart()));

       // print(response['name']);
      },
      child: Icon(Icons.add),
    );



    return new Scaffold(
      appBar: new AppBar(
        title: new Text('รายการแจ้งเปลี่ยนอะไหล่ซ่อม'),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new Card(
                  child: new ListTile(
                    leading: const Icon(Icons.local_hospital),
                    title: Text(_searchResult[i].story ,style: TextStyle(fontSize: 19.0,color: Colors.black)),
                    subtitle: Text('วันที่  '+(_searchResult[i].date).toString() ,style: TextStyle(fontSize: 16.0,color: Colors.teal),),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new DetailChang(_changDetails[i]),
                          ));
                    },
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            )
                : new ListView.builder(
              itemCount: _changDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                  child: new ListTile(
                    leading: const Icon(Icons.brightness_1),
                    title: new Text(_changDetails[index].story ,style: TextStyle(fontSize: 19.0,color: Colors.black)),
                    //subtitle: Text('วันที่  '+(_changDetails[index].date.substring(8,10)).toString() +(_changDetails[index].date.substring(4,8)).toString()+(_changDetails[index].date.substring(0,4)).toString() + ' ผู้บันทึก ' + _changDetails[index].namelangh.toString()  ,style: TextStyle(fontSize: 16.0,color: Colors.black45), ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('วันที่  '+(_changDetails[index].date.substring(8,10)).toString() +(_changDetails[index].date.substring(4,8)).toString()+(_changDetails[index].date.substring(0,4)).toString()
                            ,style: TextStyle(fontSize: 16.0,color: Colors.black45),textAlign: TextAlign.left),
                        ),
                        Container(
                         child: Text('แผนก  '+(_changDetails[index].depratment),style: TextStyle(fontSize: 16.0,color: Colors.black45),),
                        ),
                        Container(
                          child: Text('ผู้บันทึก  '+(_changDetails[index].namelangh),style: TextStyle(fontSize: 16.0,color: Colors.black45),),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new DetailChang(_changDetails[index]),
                          ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: floatingAction,
      drawer: menuLeft(),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _changDetails.forEach((changDetail) {
      if (changDetail.story.contains(text))
        _searchResult.add(changDetail);
    });

    setState(() {});
  }
}

List<CheangDetails> _searchResult = [];

List<CheangDetails> _changDetails = [];


class CheangDetails {
  final String id, story, depratment, symptom, productname, date ,namelangh ,picturenew ,pictureold, username, name, rank   ;
  final int  unit , priceunit ;



  CheangDetails({this.id,this.story, this.depratment, this.symptom, this.productname, this.unit, this.priceunit, this.date,this.namelangh ,this.picturenew,this.pictureold,this.username,this.name,this.rank });

  factory CheangDetails.fromJson(Map<String, dynamic> json) {
    return new CheangDetails(
      id: json['id'],
      story: json['title'],
      depratment: json ['department'],
      symptom: json ['symptom'],
      productname: json ['part']['productname'],
      unit: json ['unit'],
      priceunit: json ['part']['priceunit'],
      date: json ['date'],
      namelangh: json ['recordname']['name'],
      picturenew: json ['picturenew'],
      pictureold: json ['pictureold'],
      username: json ['username'],
      name: json ['name'],
      rank: json ['rank'],

    );
  }
}





