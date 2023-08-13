import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/firebase/firebase_helper/firebase_auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmnewpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            TextFormField(
              controller: _newpasswordController,
              obscureText: isShowPassword,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password_sharp,
                  color: Colors.black,
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
                hintText: "Enter new password",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _confirmnewpasswordController,
              obscureText: isShowConfirmPassword,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password_sharp,
                  color: Colors.black,
                ),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowConfirmPassword = !isShowConfirmPassword;
                    });
                  },
                  child: !isShowConfirmPassword
                      ? const Icon(Icons.visibility, color: Colors.black45)
                      : const Icon(Icons.visibility_off, color: Colors.black45),
                ),
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                hintText: "Enter confirm password",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_newpasswordController.text.isEmpty) {
                    showMessage("New password is not match");
                  } else if (_confirmnewpasswordController.text.isEmpty) {
                    showMessage("Confirm Password is not match");
                  } else {
                    if (_confirmnewpasswordController.text ==
                        _newpasswordController.text) {
                      FirebaseAuthHelper.instance
                          .changePassword(_newpasswordController.text, context);
                    } else {
                      showMessage("Confirm Password is not match");
                    }
                  }
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}
