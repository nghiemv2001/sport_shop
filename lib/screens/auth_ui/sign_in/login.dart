import 'package:demo_sogin_signup_firebase/constants/assets_image.dart';
import 'package:demo_sogin_signup_firebase/constants/asstes_colors.dart';
import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/sign_up/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/routes.dart';
import '../../../firebase/firebase_helper/firebase_auth_helper.dart';
import '../../../reusable_widget/reusable_widget.dart';
import '../../home_ui/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isShowPassword = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          App_colors.primaryColor,
          App_colors.textColor,
          App_colors.textColor,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                const Text("Wellcome",
                    style:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 12,
                ),
                const Text("We're happy when you're satisfied",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: Image.asset(
                  AssetsImages.instance.home_VNT,
                )),
                reusable_Textfile("Enter Username", Icons.person_outline, false,
                    _emailController),
                const SizedBox(
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
                          ? const Icon(Icons.visibility, color: Colors.black45)
                          : const Icon(Icons.visibility_off,
                              color: Colors.black45),
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
                const SizedBox(
                  height: 10,
                ),
                Button_Login(context, "LOGIN", () async {
                  bool isVaildated = loginVaildation(
                      _emailController.text, _passwordController.text);
                  if (isVaildated) {
                    bool isLogined = await FirebaseAuthHelper.instance.login(
                        _emailController.text,
                        _passwordController.text,
                        context);
                    if (isLogined) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: const Home(), context: context);
                    }
                  }
                  // FirebaseAuth.instance
                  //     .signInWithEmailAndPassword(
                  //         email: _emailController.text,
                  //         password: _passwordController.text)
                  //     .then((value) {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => const Home()));
                  // }).onError((error, stackTrace) {
                  //   showMessage(error.toString());
                  // });
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "------------------------------",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "or",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                    Text("------------------------------",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                Button_Login(context, "SINGUP", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Signup()));
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.facebook,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Text("or"),
                    CupertinoButton(
                        child: Image.asset(
                          AssetsImages.instance.google,
                          scale: 23.0,
                        ),
                        onPressed: () {})
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
