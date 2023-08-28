import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/profile/widgets/profileAccount.dart';
import 'package:projekt_frontend/src/presentation/views/settings/settingsPage.dart';

class ProfileAccountPage extends StatefulWidget {
  const ProfileAccountPage({Key? key}) : super(key: key);

  @override
  State<ProfileAccountPage> createState() => _ProfileAccountPageState();
}

class _ProfileAccountPageState extends State<ProfileAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text('Profile'),
        backgroundColor: Colors.orange,
        shape: const Border(
            bottom: BorderSide(
              color: Colors.orangeAccent,
              //width: 4
            )
        ),
        elevation: 4,
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }),
        ],
      ),
      body: const ProfileAccountWidget(),
    );
  }
}
