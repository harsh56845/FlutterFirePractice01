import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({required this.mainList, super.key});
  List<User> mainList;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();

  List<User> listuser = [];

  @override
  void initState() {
    // listuser = widget.mainList;
    readData();
    super.initState();
  }

  Future<void> addData() async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    final json = {'Name': nameController.text, 'Password': passController.text};
    // user.add(json);
    String id = user.doc().id;
    user.doc(id).set(json);
    // setState(() {
    //   listuser.add(
    //       User(id: id, name: nameController.text, pass: passController.text));
    // });
  }

  Future<void> upddateData(String thisName) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    final json = {'Name': updateNameController.text};
    String? id;

    for (int i = 0; i < listuser.length; i++) {
      if (listuser[i].name == thisName) {
        id = listuser[i].id;
        listuser[i].name = updateNameController.text;
        break;
      }
    }
    print(id);

    user.doc(id).update(json);
  }

  Future<void> deleteData(String thisName) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');

    String? id;

    for (int i = 0; i < listuser.length; i++) {
      if (listuser[i].name == thisName) {
        id = listuser[i].id;
      }
    }
    user.doc(id).delete();
  }

  Future<void> readData() async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    // for (int i = 0; i < listuser.length; i++) {
    //   print("Name = ${listuser[i].name} and Pass = ${listuser[i].pass}");
    // }
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    _usersStream.forEach((element) {
      element.docs
          .map((e) => {
// print(e['Name'] + "  " + e['Password'] + " " + e.id)
                setState(() {
                  listuser.add(
                      User(id: e.id, name: e['Name'], pass: e['Password']));
                })
              })
          .toList();
    });

    for (int i = 0; i < listuser.length; i++) {
      print(listuser[i].name + " " + listuser[i].pass + " " + listuser[i].id);
    }

    // _usersStrea

    // print(user
    //     .get()
    //     .asStream()
    //     .map((event) => print(event.docs.map((e) => print(e.data())))));
  }

  String name = "Enter Name and Password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text("${nameController.text} and ${passController.text}"),
          Text(name),
          const SizedBox(height: 30),
          SizedBox(
            width: 200,
            child: TextField(
                // onChanged: (value) {
                //   setState(() {
                //     // name = value;
                //     name =nameController.
                //   });
                // },
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: const InputDecoration(hintText: "Enter Your Name")),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 200,
            child: TextField(
                controller: passController,
                decoration:
                    const InputDecoration(hintText: "Enter Your Password")),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent)),
            onPressed: () {
              addData();
            },
            child: const Text(
              "Add Data",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent)),
            onPressed: () {
              readData();
              // nameController.clear();
            },
            child: const Text(
              "Read Data",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: 200,
            child: TextField(
                controller: updateNameController,
                decoration:
                    const InputDecoration(hintText: "Enter Your update name")),
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent)),
            onPressed: () {
              upddateData(nameController.text);
              // nameController.clear();
            },
            child: const Text(
              "Update Data",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30 / 2),

          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent)),
            onPressed: () {
              deleteData(nameController.text);
              // upddateData(nameController.text);
              // nameController.clear();
            },
            child: const Text(
              "Delete Data",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class User {
  String id;
  String pass;
  String name;
  User({required this.id, required this.name, required this.pass});
}
