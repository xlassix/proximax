import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximax/screens/loadingScreen.dart';
import 'package:proximax/screens/loginScreen.dart';
import 'package:proximax/screens/registrationScreen.dart';
import 'package:proximax/screens/taskScreen.dart';
import "package:firebase_core/firebase_core.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        TaskScreen.id: (context) => TaskScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen()
      },
    );
  }
}
