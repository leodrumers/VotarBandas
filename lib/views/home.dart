import 'dart:io';

import 'package:bands/model/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String routeName = '/home';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Bands',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (_, index) => _buildBandListTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 2,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _buildBandListTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Delete band',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue.shade100,
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {},
      ),
      onDismissed: (direction) {
        print('direction $direction');
        print('bandId ${band.id}');
      },
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      return showCupertinoDialog(
        context: context,
        builder: (_) {
          return _buildcupertinoAlertDialog(textController);
        },
      );
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return _buildAndroidDialog(textController);
          });
    }
  }

  AlertDialog _buildAndroidDialog(TextEditingController textController) {
    return AlertDialog(
      title: Text('New band name'),
      content: TextField(controller: textController),
      actions: [
        MaterialButton(
          child: Text('Add'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => addBandNameToList(textController.text),
        )
      ],
    );
  }

  CupertinoAlertDialog _buildcupertinoAlertDialog(
      TextEditingController textController) {
    return CupertinoAlertDialog(
      title: Text('New band name'),
      content: CupertinoTextField(
        controller: textController,
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Add'),
          isDefaultAction: true,
          onPressed: () => addBandNameToList(textController.text),
        ),
        CupertinoDialogAction(
          child: Text(
            'Dismiss',
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void addBandNameToList(String bandName) {
    if (bandName.length > 1) {
      // Agregar nuevo nombre a la lista de bandas
      Band newBand =
          Band(id: DateTime.now().toString(), name: bandName, votes: 0);
      bands.add(newBand);
    }
    Navigator.pop(context);
  }
}
