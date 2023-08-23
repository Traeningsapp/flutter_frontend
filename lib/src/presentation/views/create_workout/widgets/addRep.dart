import 'package:flutter/material.dart';

class AddSetWidget extends StatefulWidget {
  final int ctn;
  const AddSetWidget({required this.ctn, super.key});

  @override
  State<AddSetWidget> createState() => _AddSetWidgetState();
}

class _AddSetWidgetState extends State<AddSetWidget> {
  late int setnr;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    setnr = widget.ctn;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
            child: Text('Set $setnr')),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.17, 0, 0, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.03,
            child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.07, 0, 0, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.03,
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
