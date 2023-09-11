import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/utils/constants.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';


class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBarWidget({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarWidgetState createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.title,
              style: TextStyle(
                color: SelectedTextColor,
                fontWeight: FontWeight.bold
              ),
          ),
          backgroundColor: SelectedSecondaryColor,
          centerTitle: true,
        )
    );
  }
}
