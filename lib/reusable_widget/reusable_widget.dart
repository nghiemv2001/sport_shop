import 'package:flutter/material.dart';

Image logoWidget(String s) {
  return Image.asset(
    s,
    fit: BoxFit.fitWidth,
    height: 240,
    width: 240,
    color: Colors.white,
  );
}

TextField reusable_Textfile(String text, IconData icon, bool ispasswordtype,
    TextEditingController textEditingController) {
  return TextField(
    controller: textEditingController,
    obscureText: ispasswordtype,
    enableSuggestions: !ispasswordtype,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: ispasswordtype
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container Button_Login(BuildContext context, String Textname, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 65,
    margin: const EdgeInsets.fromLTRB(40, 10, 40, 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        Textname,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}
