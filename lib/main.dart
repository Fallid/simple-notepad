import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplenotepad/HomeScreen.dart';
import 'package:simplenotepad/NoteEditor.dart';
import 'package:simplenotepad/SplashScreen.dart';
import 'package:simplenotepad/UserProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Notepad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/NoteEditor': (BuildContext context) {
          return const NoteEditor();
        },
        '/HomeScreen': (BuildContext context) {
          return const HomeScreen();
        },
        '/UserProfile': (BuildContext context) {
          return const UserProfile();
        }
      },
    );
  }
}
