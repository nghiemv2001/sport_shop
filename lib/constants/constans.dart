import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDiaLog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Color(0xffe16555),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loading..."),
              )
            ],
          ),
        );
      },
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorcode) {
  switch (errorcode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already use. Go to login page.";
    case "account-exists-with-different-credential":
      return "Email already use. Go to login page.";
    case "email-already-in-use":
      return "Email already use. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong Password";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email.";
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
      return "User disabled";
    case "user-disabled":
      return "User Disabled";
    case "ERROR_TOO_MANY_REQUESTS":
      return "too many request to log in into this account";
    case "operation-not-allowed":
      return "too many request to log in into this account";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Too many requests to long into this account.";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid";
    case "invalid-email":
      return "Email address is invalid.";
    case "CONFIGURATION_NOT_FOUND":
      return "user not found";
    default:
      return "Login failed. PLease try again.";
  }
}

bool loginVaildation(String email, String password) {
  if (email.isEmpty) {
    showMessage("EMAIL EMPTY");
    return false;
  }
  if (password.isEmpty) {
    showMessage("EMAIL EMPTY");
    return false;
  }
  return true;
}

bool signupVaildation(String username, String email, String phone,
    String password, String confim) {
  if (username.isEmpty) {
    showMessage("USERNAME EMPTY");
    return false;
  }
  if (email.isEmpty) {
    showMessage("EMAIL EMPTY");
    return false;
  }
  if (phone.isEmpty) {
    showMessage("PHONE EMPTY");
    return false;
  }
  if (password.isEmpty) {
    showMessage("Password EMPTY");
    return false;
  }
  return true;
}
