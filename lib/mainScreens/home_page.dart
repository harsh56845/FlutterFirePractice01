import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tofo_fb/demoScreens/homeScree.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.docId, required this.name, super.key});
  String name;
  String docId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HScreen(docId: widget.docId))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "WELCOM ${widget.name}",
                style: const TextStyle(color: Colors.purple, fontSize: 100),
              )
            ],
          ),
        ),
      ),
    );
  }
}
