import 'package:demo_sogin_signup_firebase/reusable_widget/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sing Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.blueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusable_Textfile("Enter User Name", Icons.person_outline,
                    false, _usernameController),
                const SizedBox(
                  height: 20,
                ),
                reusable_Textfile("Enter Email", Icons.person_outline, false,
                    _emailController),
                const SizedBox(
                  height: 20,
                ),
                reusable_Textfile("Enter Password", Icons.lock_outline, false,
                    _passwordController),
                const SizedBox(
                  height: 20,
                ),
                Button_Login(context, "SIGNUP", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) {
                    print("Create Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home_Page()));
                  }).onError((error, stackTrace) {
                    print("${error.toString()}");
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
