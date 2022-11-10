import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:saving_data_when_offline/home_page_logged_in.dart';
import 'package:saving_data_when_offline/log_in.dart';
import 'package:saving_data_when_offline/question_model.dart';

class HomePageNotLoggedIn extends StatefulWidget {
  const HomePageNotLoggedIn({Key? key}) : super(key: key);

  @override
  State<HomePageNotLoggedIn> createState() => _HomePageNotLoggedInState();
}

class _HomePageNotLoggedInState extends State<HomePageNotLoggedIn> {
  Map controllers = {};
  late double width;
  String question1 ='How many times...';
  String question2 ='What do you think about...';

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
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page Not Logged In'),
        actions: [
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogIn()),
              );
            },
            child: Center(child: Padding(
              padding: EdgeInsets.only(right: 5),
              child: Text('Log-In',style: TextStyle(fontSize: 15),),
            )),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 50,
          width: width,
          child: UnconstrainedBox(
            child: Container(
              height: 40,
              width: width*0.99,
              child: ElevatedButton(onPressed:() async {
                try{
                  List<Question> questions= [Question(question: question1, answers: {'a':controllers['question1'].text}),Question(question: question2, answers:
                  {
                    "a":controllers['question2']['a'].text,
                    "b":controllers['question2']['b'].text,
                    "c":controllers['question2']['c'].text,
                  })];
                  var box = await Hive.openBox('questions');
                  if(box.length>=3){
                    print('its 3');
                    throw Exception();
                  } else if(box.isEmpty){
                    print('it does for 0');
                    box.put('0',questions);
                  }else{
                    print('${box.length}');
                    box.put('${box.length}',questions);
                  }
                  controllers['question2']['a'].clear();
                  controllers['question2']['b'].clear();
                  controllers['question2']['c'].clear();
                  controllers['question1'].clear();



                } catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pleas log-In to save')));

                }
              }, child: Text('SAVE'),),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          QuestionField(width: width,controller: controllers['question1'],hint: question1,),
          SizedBox(height: 5,),
          QuestionFieldMultipleAnswers(width: width, controller1: controllers['question2']['a'],controller2: controllers['question2']['b'],controller3: controllers['question2']['c'],hint: question2,),
        ],
      ),
    );
  }
}

class QuestionField extends StatelessWidget {
  QuestionField({required this.width,required this.controller,required this.hint});
  double width;
  TextEditingController controller;
  String hint;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width*0.98,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xffe4e4e4),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 5,right: 5),
          child: Center(
            child: TextField(
              controller: controller,
              decoration: InputDecoration.collapsed(hintText: hint),
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionFieldMultipleAnswers extends StatelessWidget {
  QuestionFieldMultipleAnswers({required this.width,required this.controller1,required this.controller2,required this.controller3,required this.hint});
  double width;
  TextEditingController controller1;
  TextEditingController controller2;
  TextEditingController controller3;
  String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(hint),
        ),
        Column(
          children: [
            Center(
              child: Container(
                width: width*0.98,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xffe4e4e4),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  child: Center(
                    child: TextField(
                      controller: controller1,
                      decoration: InputDecoration.collapsed(hintText: 'Answer 1'),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: width*0.98,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xffe4e4e4),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  child: Center(
                    child: TextField(
                      controller: controller2,
                      decoration: InputDecoration.collapsed(hintText: 'Answer 2'),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: width*0.98,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xffe4e4e4),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  child: Center(
                    child: TextField(
                      controller: controller3,
                      decoration: InputDecoration.collapsed(hintText: 'Answer 3'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

