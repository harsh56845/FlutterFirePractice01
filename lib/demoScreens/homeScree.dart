import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HScreen extends StatefulWidget {
  HScreen({required this.docId, super.key});
  String docId;
  @override
  State<HScreen> createState() => _HScreenState();
}

class _HScreenState extends State<HScreen> {
  TextEditingController textContoller = TextEditingController();
  TextEditingController editContoller = TextEditingController();
  static String userId = '';
  var _todos = null;
  // final _todos = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(userId)
  //     .collection('todos');

  Color dataColor = Color.fromARGB(255, 209, 135, 38);

  List<Todo> todoLists = [];
  void add(String todoString) {
    String iid = _todos.doc().id;
    _todos.doc(iid).set({'Task': todoString});

    setState(() {
      todoLists.clear();
      // todoLists.add(Todo(id: iid, task: todoString));
    });
    textContoller.clear();
  }

  Future<void> readLists() async {
    //  FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.docId)
    //     .collection('todos');
    // Stream<QuerySnapshot<Map<String, dynamic>>> todosSnapshot =
    //     FirebaseFirestore.instance.collection('todos').snapshots();

    Stream<QuerySnapshot<Map<String, dynamic>>> todosSnapshot =
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.docId)
            .collection('todos')
            .snapshots();

    todosSnapshot.forEach((document) {
      for (var data in document.docs) {
        setState(() {
          todoLists.add(Todo(id: data.id, task: data['Task']));
        });
      }
    });
  }

  void remove(String id, int index) {
    _todos.doc(id).delete();
    setState(() {
      // todoLists.removeAt(index);

      todoLists.clear();
      // todoLists.add(Todo(id: iid, task: todoString));
      // todoLists.remove(index);
    });
  }

  void edit(int index, String id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Enter Editied task"),
              content: TextField(
                decoration: InputDecoration(
                    hintText: "Enter Your New Task",
                    hintStyle: TextStyle(color: dataColor)),
                controller: editContoller,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _todos.doc(id).update({'Task': editContoller.text});
                        // todoLists[index].task = editContoller.text;
                        todoLists.clear();
                      });
                      Navigator.of(context).pop();
                      // .elementAt(index).replaceFirst(from, to)
                    },
                    icon: const Icon(Icons.done))
              ],
            ));
    // setState(() {
    //   todoLists.removeAt(index);
    //   // todoLists.remove(index);
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    userId = widget.docId;
    _todos = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.docId)
        .collection('todos');
    readLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "To-Do's",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Enter Your Task",
                          hintStyle: TextStyle(color: dataColor)),
                      controller: textContoller,
                    )),
                Spacer(),
                IconButton(
                    onPressed: () => add(textContoller.text),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoLists.length,
              itemBuilder: (context, i) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${i + 1}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Text(
                            todoLists[i].task,
                            style: TextStyle(fontSize: 20, color: dataColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => edit(i, todoLists[i].id),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              )),
                          IconButton(
                              onPressed: () => remove(todoLists[i].id, i),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      )
                    ],
                  ),
                );
                // tile(context, todoLists[i]);
              },
            ),
          )
          // tile(context),
        ],
      )),
    );
  }
}

// Widget tile(BuildContext context, String todoText, Color dataColor) {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//     decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,
//         ),
//         borderRadius: const BorderRadius.all(Radius.circular(20))),
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     child: Row(
//       children: [
//         Text(
//           todoText,
//           style: TextStyle(fontSize: 20, color: dataColor),
//         ),
//         const Spacer(),
//         Row(
//           children: [
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.edit,
//                   color: Colors.grey,
//                 )),
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.delete,
//                   color: Colors.red,
//                 ))
//           ],
//         )
//       ],
//     ),
// );
// }

class Todo {
  String task;
  String id;
  Todo({required this.id, required this.task});
}
