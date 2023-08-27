import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/profile/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) => const Scaffold(
    resizeToAvoidBottomInset: false,
    extendBody: true,
    body: ProfileWidget()
  );
}