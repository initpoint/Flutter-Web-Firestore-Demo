
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;

void main() {
  initializeApp(
    apiKey: "AIzaSyCI5PSWEk0QImvlCP6wIm2-Hd9BIJcfirU",
    authDomain: "alsenedy-455c6.firebaseapp.com",
    databaseURL: "https://alsenedy-455c6.firebaseio.com",
    projectId: "alsenedy-455c6",
    storageBucket: "alsenedy-455c6.appspot.com",
  );

  fs.Firestore store = firestore();
  fs.CollectionReference users = store.collection('users');

  /*var Users = {
    'Name': 'Mohamed',
    'Password': Random.secure().nextInt(256),
    'Email': 'Malek@Camp.com'
  };*/
  //users.add(Users);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FireStore Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Flutter FireStore Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var JSrecords;
  void getUsers() {
    firestore().collection('users').onSnapshot.listen((records) {
      print('Records : ');
      JSrecords = records.docs.toList();
      records.forEach((record) {
        print(record.data());
      });
    });
   /* firestore().collection('users').get().then((values) {
      values.forEach((value) {
        //JSrecords = value.data().toString();
        print(value.data());
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Users records:',
            ),
            Text(
              '$JSrecords',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getUsers,
        tooltip: 'Show Users',
        child: Icon(Icons.data_usage),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
