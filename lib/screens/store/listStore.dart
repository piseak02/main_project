import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/components/menu_left.dart';

import 'package:main_project/screens/store/addStore.dart';
import 'package:main_project/screens/store/detilstore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:main_project/constant/url_system.dart';

class listStore extends StatefulWidget {
  @override
  _listStoereState createState() => _listStoereState();
}

class _listStoereState extends State<listStore> {
  TextEditingController controller = new TextEditingController();


  // Get json result and convert it to model. Then add
  Future<Null> getListStoer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(url_get_stock_rank+prefs.getString('rank'), headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer '+prefs.getString('token')});
    final responseJson = json.decode(response.body);
   // print('xxxxxxx');
   // print(responseJson['data']);
    _storeDetails.clear();
    setState(() {
     for (Map user in json.decode(responseJson['data'])) {
       _storeDetails.add(StoreDetails.fromJson(user));
     }
    });
  }

  @override
  void initState() {
    super.initState();

    getListStoer();
  }

  @override
  Widget build(BuildContext context) {

    Widget floatingAction = FloatingActionButton(
      backgroundColor: Colors.blueAccent,
      onPressed: () async {
        var response = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => Addstore()));
      },
      child: Icon(Icons.add),
    );



    return new Scaffold(
      appBar: new AppBar(
        title: new Text('รายการอะไหล่'),
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
                   // title: new Text(_searchResult[i].product + ' ' + (_searchResult[i].unit).toString()),
                    leading: const Icon(Icons.assignment),
                    title: Text(_searchResult[i].product ,style: TextStyle(fontSize: 19.0,color: Colors.black),),
                    subtitle: Text('ยอดคงเหลือ  '+(_searchResult[i].unit).toString(),style: TextStyle(fontSize: 16.0,color: Colors.red),),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new detilstore(_storeDetails[i])));
                    },
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            )
                : new ListView.builder(
              itemCount: _storeDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                child: ListTile(
                  leading: const Icon(Icons.assignment),
                  title: Text(_storeDetails[index].product ,style: TextStyle(fontSize: 19.0,color: Colors.black)),
                  subtitle: Text('ยอดคงเหลือ  '+(_storeDetails[index].unit).toString(),style: TextStyle(fontSize: 16.0,color: Colors.red),),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new detilstore(_storeDetails[index])));
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

    _storeDetails.forEach((userDetail) {
      if (userDetail.product.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<StoreDetails> _searchResult = [];

List<StoreDetails> _storeDetails = [];

class StoreDetails {
  final String id, product ,date;
  final int  unit , priceunit ,pricetotal;

  StoreDetails({this.id,this.product, this.unit, this.priceunit, this.pricetotal , this.date});

  factory StoreDetails.fromJson(Map<String, dynamic> json) {
    return new StoreDetails(
      id: json['id'],
      product: json['productname'],
      unit: json['unit'],
      priceunit: json ['priceunit'],
      pricetotal: json ['pricetotal'],
      date: json ['date'],
    );
  }
}