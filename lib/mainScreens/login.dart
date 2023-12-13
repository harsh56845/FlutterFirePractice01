import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tofo_fb/mainScreens/home_page.dart';

class LoginCard extends StatefulWidget {
  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> login() async {
    try {
      String? pass;
      Stream<QuerySnapshot<Map<String, dynamic>>> users =
          FirebaseFirestore.instance.collection('users').snapshots();
      // bool isEmailFount = false;
      users.forEach((element) {
        element.docs
            .map((data) => {
                  if (data['Email'] == emailController.text)
                    {
                      // print(data['Email']),
                      // print(data['Password']),
                      pass = data['Password'],
                      if (data['Password'] == passController.text)
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => HomePage(
                                        name: data['Name'],
                                      ))),
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Your Email or Id Verfied'))),
                        }
                    }
                })
            .toList();
      });

//       _usersStream.forEach((element) {
//         element.docs
//             .map((e) => {
// // print(e['Name'] + "  " + e['Password'] + " " + e.id)
//                   setState(() {
//                     listuser.add(
//                         User(id: e.id, name: e['Name'], pass: e['Password']));
//                   })
//                 })
//             .toList();
//       });

      // print(pass.toString());
      // if (pass == passController.text) {
      //   // Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      // } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your Email or Id doesnot Match')));
      // }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error -> $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => login(),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
