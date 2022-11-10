import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saving_data_when_offline/home_page_logged_in.dart';
import 'package:saving_data_when_offline/home_page_not_logged_in.dart';
import 'package:saving_data_when_offline/question_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter((QuestionAdapter()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final currentUser = FirebaseAuth.instance.currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Here we check if the user has been logged in then we go to the corresponding page
      home: (currentUser==null)?HomePageNotLoggedIn():HomePage(),
    );
  }
}
