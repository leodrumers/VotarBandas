import 'package:flutter/material.dart';

import 'file:///C:/Users/Leo/Documents/flutter/bands/lib/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('My flutter app'), centerTitle: true),
        body: Home(),
      ),
    );
  }
}
