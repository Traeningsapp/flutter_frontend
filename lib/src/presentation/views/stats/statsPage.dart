import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/settings/settingsPage.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.teal,
        centerTitle: true,
        title: const Text('Home'),
        backgroundColor: Colors.black,
        shape: const Border(
            bottom: BorderSide(
              color: Colors.teal,
              //width: 4
            )
        ),
        elevation: 4,
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }),
        ],
      ),
      body: const Text('Stats Page',
        style: TextStyle(
            fontSize: 60),
      ),
    );
  }
}