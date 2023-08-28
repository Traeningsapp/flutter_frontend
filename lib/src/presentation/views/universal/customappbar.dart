import 'package:flutter/material.dart';


class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Color themecolor;
  const CustomAppBarWidget({Key? key, required this.title, required this.themecolor})
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
          title: Text(widget.title),
          backgroundColor: widget.themecolor,
          centerTitle: true,
        )
    );
  }
}
