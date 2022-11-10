import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:saving_data_when_offline/home_page_not_logged_in.dart';
import 'package:saving_data_when_offline/question_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map controllers = {};

  //We check if any questions have been added while they were offline
  //if the questions were added then we post those questions to firebase
  addQuestionToDatabase() async {
    var box = await Hive.openBox('questions');
    //we open the "box", this is where the questions would be saved if they filled the questions while offline
    if(box.isNotEmpty){//if the box is not empty, meaning the
      for(int i = 0;i<box.length;i++){
        var questionAnswered = box.get('$i');
        print(questionAnswered);
        questionAnswered.length;
        DocumentReference docRef = FirebaseFirestore.instance.collection('questions').doc();
        for(int j = 0;j<2;j++){
          if(j==0){
            await docRef.set({
              "Quesiton${j+1}":{
                "Question":questionAnswered[j].question,
                "Answers":questionAnswered[j].answers,
              }
            });
          } else {
            await docRef.update({
              "Quesiton${j+1}":{
                "Question":questionAnswered[j].question,
                "Answers":questionAnswered[j].answers,
              }
            });
          }
        }
        box.delete('$i');
      }
    }

  }


  @override
  void initState(){
  controllers = {
    "question1":TextEditingController(),
    "question2":{
      "a":TextEditingController(),
      "b":TextEditingController(),
      "c":TextEditingController(),
    }
  };
  addQuestionToDatabase();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page Logged In'),
      ),
      body: Center(
        child: ElevatedButton(onPressed:() async {
          FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => HomePageNotLoggedIn(),
            ),
                (route) => false,
          );
        }, child: Text('LOG OUT')),
      ),
    );
  }
}
