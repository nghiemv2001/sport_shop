import 'package:demo_sogin_signup_firebase/constants/routes.dart';
import 'package:demo_sogin_signup_firebase/firebase/firebase_helper/firebase_auth_helper.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/sign_in/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets_image.dart';
import '../../../constants/constans.dart';
import '../../../reusable_widget/reusable_widget.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.black45,
          Colors.blueGrey,
          Colors.blueGrey,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Image.asset(
                  AssetsImages.instance.home_VNT,
                )),
                const Text("You can signup here ->",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 30,
                ),
                reusable_Textfile("Enter username", Icons.person_outline, false,
                    _usernameController),
                SizedBox(
                  height: 10,
                ),
                reusable_Textfile(
                    "Enter email", Icons.email, false, _emailController),
                SizedBox(
                  height: 10,
                ),
                reusable_Textfile(
                    "Enter phone", Icons.phone, false, _phoneController),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isShowPassword,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password_sharp,
                      color: Colors.white,
                    ),
                    suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      child: !isShowPassword
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black45,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.black45,
                            ),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    labelText: "EnterPassword",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmpasswordController,
                  obscureText: isShowConfirmPassword,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password_sharp,
                      color: Colors.white,
                    ),
                    suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowConfirmPassword = !isShowConfirmPassword;
                        });
                      },
                      child: !isShowConfirmPassword
                          ? const Icon(Icons.visibility, color: Colors.black45)
                          : const Icon(Icons.visibility_off,
                              color: Colors.black45),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    labelText: "Confirm Password",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Button_Login(context, "SIGNUP", () async {
                  bool Vaildation = signupVaildation(
                      _usernameController.text,
                      _emailController.text,
                      _phoneController.text,
                      _passwordController.text,
                      _confirmpasswordController.text);

                  if (Vaildation) {
                    bool isSignup = await FirebaseAuthHelper.instance.sigup(
                        _usernameController.text,
                        _emailController.text,
                        _phoneController.text,
                        _passwordController.text,
                        context);
                    if (isSignup) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: Login(), context: context);
                    }
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have account?",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Sign Ip",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
