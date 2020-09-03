import 'package:bands/model/band.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Band> bands = [
    Band(id: '1', name: 'Skillet', votes: 0),
    Band(id: '2', name: 'Rojo', votes: 0),
    Band(id: '3', name: 'Israel Houghton', votes: 8),
    Band(id: '4', name: 'Marcos Vidal', votes: 4),
    Band(id: '5', name: 'Hillsong', votes: 6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
