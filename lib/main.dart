import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tofo_fb/demoScreens/homeScree.dart';
import 'package:tofo_fb/mainScreens/home_page.dart';
import 'package:tofo_fb/mainScreens/login.dart';
import 'package:tofo_fb/mainScreens/signup.dart';
import 'package:tofo_fb/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyC0iH4WIqplEPe65vO-16Fq5ZUcGfugJnQ",
      authDomain: "todo-app-fbe59.firebaseapp.com",
      projectId: "todo-app-fbe59",
      storageBucket: "todo-app-fbe59.appspot.com",
      messagingSenderId: "150581867160",
      appId: "1:150581867160:web:c96201d492f58fa2be16ed",
      measurementId: "G-SZS8T028BD",
    ));
  } else {
    await Firebase.initializeApp();
  }
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(), debugShowCheckedModeBanner: false,
      // home: HScreen()
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login & Signup'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Signup'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              LoginCard(),
              SignupCard(),
            ],
          ),
        ),
      ),
    );
  }
}
