import 'package:demo_sogin_signup_firebase/screens/auth_ui/sign_in/login.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets_image.dart';
import '../../../constants/asstes_colors.dart';
import '../../../reusable_widget/reusable_widget.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                reusable_Textfile("Enter password", Icons.password, false,
                    _passwordController),
                SizedBox(
                  height: 10,
                ),
                reusable_Textfile("Enter confirm password", Icons.password,
                    false, _confirmpasswordController),
                SizedBox(
                  height: 10,
                ),
                Button_Login(context, "SIGNUP", () {}),
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
