import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/screens/store/addStore.dart';
import 'package:main_project/screens/store/detailStore.dart';

class listStore extends StatefulWidget {
  @override
  _listStoreState createState() => _listStoreState();
}

class _listStoreState extends State<listStore> {
  String url = 'https://randomuser.me/api/?results=15';
  List data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["results"];
    });
  }

  @override
  void initState() {      // ดาวเวอร์ ชั้นขี3ขีด
    this.makeRequest();
  }





  @override
  Widget build(BuildContext context) {

    Widget floatingAction = FloatingActionButton(
      backgroundColor: Colors.blueAccent,
      onPressed: () async {
        var response = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => Addstore()));

        print(response['name']);
      },
      child: Icon(Icons.add),
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('รายการอะไหล่'),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, i) {
            return new ListTile(
              title: new Text(data[i]["name"]["first"]),
              subtitle: new Text(data[i]["phone"]),
              leading: new CircleAvatar(
                backgroundImage:
                new NetworkImage(data[i]["picture"]["thumbnail"]),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new SecondPage(data[i])));
              },
            );
          }
      ),
      floatingActionButton: floatingAction,
    );
  }
}


