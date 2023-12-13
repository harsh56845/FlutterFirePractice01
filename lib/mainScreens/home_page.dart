import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.name, super.key});
  String name;

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
                "WELCOM $name",
                style: const TextStyle(color: Colors.purple, fontSize: 100),
              )
            ],
          ),
        ),
      ),
    );
  }
}
