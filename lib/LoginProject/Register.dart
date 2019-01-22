import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class RrgisterU extends StatefulWidget {
  RrgisterU({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RrgisterUState createState() => _RrgisterUState();
}

class _RrgisterUState extends State<RrgisterU> {

  Contact newContact = new Contact();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];

  String _color = '';
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
        title: new Text(widget.title),
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
                      icon: const Icon(Icons.laptop),
                      hintText: 'Enter your first and last Text',
                      labelText: 'Text',
                    ),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Enter your date of birth',
                      labelText: 'date',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.color_lens),
                          labelText: 'Color',
                        ),
                        isEmpty: _color == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _color,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                newContact.favoriteColor = newValue;
                                _color = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _colors.map((String value) {
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
                  Container(
                    child: _image==null
                        ? new Text('No img')
                        : new Image.file(_image),
                  ),
                  RaisedButton(
                    child: Icon(Icons.add_a_photo),
                    onPressed: getImageCamera,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('SAVE'),
                        onPressed: null,
                      )),
                ],
              ))),
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