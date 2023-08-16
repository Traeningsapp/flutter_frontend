import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/home/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          HomeWidget(),
        ],
      )
    );
  }
}




/*
appBar: AppBar(
        leading: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0,3),
                  blurRadius: 8,
                )
              ]
            ),
            child: RiveAnimation.asset('',
              onInit: (artboard) {},
            ),
          ),
        ),
        shadowColor: Colors.blue,
        centerTitle: true,
        title: const Text('Home',
          style: TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w400
          ),
        ),
        backgroundColor: Colors.black,
        shape: const Border(
            bottom: BorderSide(
              color: Colors.blue,
              //width: 4
            )
        ),
        elevation: 4,
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }),
        ],
      ),
      body: HomeWidget(),
 */
