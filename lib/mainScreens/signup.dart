import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignupCard extends StatefulWidget {
  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> saveData() async {
    try {
      CollectionReference user = FirebaseFirestore.instance.collection("users");
      final json = {
        'Name': nameController.text,
        'Password': passController.text,
        'Email': emailController.text,
      };
      user.add(json);
      setState(() {
        nameController.clear();
        passController.clear();
        emailController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your Data is Saved Susssessfully')));
    } catch (e) {
      String str = e.toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error -> $str")));
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
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
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
                onPressed: () => saveData(),
                child: const Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
