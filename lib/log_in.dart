import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saving_data_when_offline/home_page_logged_in.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => HomePage(),
                    ),
                        (route) => false,
                  );
                } catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not login with these credentials')));
                }
              }, child: Text('LOG-IN'),),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          TextField(
            controller: email,
            decoration: InputDecoration(
              labelText: 'Email'
            ),
          ),
          SizedBox(height: 5,),
          TextField(
            controller: password,
            decoration: InputDecoration(
                labelText: 'Password'
            ),
          )
        ],
      ),
    );
  }
}
