import 'dart:io';

import 'package:bands/model/band.dart';
import 'package:bands/services/socket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/piechart.dart';

class Home extends StatefulWidget {
  static String routeName = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Band> bands = [];

  @override
  void initState() {
    final socketService =
        Provider.of<SocketServiceProvider>(context, listen: false);
    socketService.socket.on('active-bands', _handlePayloadServer);
    super.initState();
  }

  _handlePayloadServer(dynamic payload) {
    this.bands = (payload as List).map((band) => Band.from(band)).toList();
    setState(() {});
  }

  @override
  void dispose() {
    final socketService =
        Provider.of<SocketServiceProvider>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketServiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Bands',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.error, color: Colors.red),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: PieChartBand(
              bands: bands,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (_, index) => _buildBandListTile(bands[index])),
          ),
          SizedBox(height: 64)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 2,
        onPressed: _addNewBand,
      ),
    );
  }

  Widget _buildBandListTile(Band band) {
    final socketService =
        Provider.of<SocketServiceProvider>(context, listen: false);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => socketService.emit('delete-band', {'id': band.id}),
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
        onTap: () => socketService.socket.emit('vote-band', {'id': band.id}),
      ),
    );
  }

  _addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      return showCupertinoDialog(
        context: context,
        builder: (_) => _buildcupertinoAlertDialog(textController),
      );
    } else {
      return showDialog(
          context: context,
          builder: (_) => _buildAndroidDialog(textController));
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
      final socketService =
          Provider.of<SocketServiceProvider>(context, listen: false);
      // Agregar nuevo nombre a la lista de bandas
      socketService.socket.emit('add-band', {'name': bandName});
    }
    Navigator.pop(context);
  }
}
