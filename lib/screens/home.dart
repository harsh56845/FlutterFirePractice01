import 'package:flutter/material.dart';
import 'package:tofo_fb/screens/create.dart';
import 'package:tofo_fb/screens/read.dart';

class Home extends StatelessWidget {
  Home({super.key});
  List<User> mainList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateScreen(
                              mainList: mainList,
                            ))),
                child: const Text(
                  "Create Data Screen",
                  style: TextStyle(fontSize: 35),
                )),
            const SizedBox(height: 100),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReadScreen())),
              child: const Text(
                "Read Data Screen",
                style: TextStyle(fontSize: 35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
