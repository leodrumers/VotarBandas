import 'package:bands/services/socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  static String routeName = '/status';
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketServiceProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              socketService.serverStatus.toString(),
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketService.socket
              .emit("emitir-mensaje", {'name': "hello from flutter"});
          print('Termina de emitir mensaje');
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
