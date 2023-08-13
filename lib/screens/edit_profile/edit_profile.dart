import 'dart:io';

import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/provider_model.dart';

class edit_prfile extends StatefulWidget {
  const edit_prfile({Key? key}) : super(key: key);

  @override
  State<edit_prfile> createState() => _edit_prfileState();
}

class _edit_prfileState extends State<edit_prfile> {
  File? image;
  Future<void> takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    print(value);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    radius: 70,
                    child: Icon(Icons.camera_alt),
                  ),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(image!),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: textEditingController,
            decoration:
                InputDecoration(hintText: appProvider.getUserInformation.name),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                UserModel userModel = appProvider.getUserInformation
                    .copyWith(name: textEditingController.text);
                appProvider.updateUserInfoFirebase(context, userModel, image);
                showMessage("Successfully update prodife");
              },
              child: Text("Update"))
        ],
      ),
    );
  }
}
