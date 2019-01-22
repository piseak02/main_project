import 'package:flutter/material.dart';
import 'Register.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/pop.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 100.0 , vertical: 150.00),
          children: <Widget>[
            new TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'UserEnter',
                labelText: 'user',
              ),
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.local_parking),
                hintText: 'PasswordEnter',
                labelText: 'Password',
              ),
            ),
            new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Login'),
                  onPressed: null,
                )),
            new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RrgisterU()),
                );
                },
              child: new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Text('สมัครสมาชิก'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

