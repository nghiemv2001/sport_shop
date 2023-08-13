import 'package:demo_sogin_signup_firebase/constants/routes.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/favorite_view/favorite_view.dart';
import 'package:demo_sogin_signup_firebase/screens/change_password/change_password.dart';
import 'package:demo_sogin_signup_firebase/screens/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase/firebase_helper/firebase_auth_helper.dart';
import '../../../provider/provider_model.dart';

class account_view extends StatefulWidget {
  const account_view({Key? key}) : super(key: key);

  @override
  State<account_view> createState() => _account_viewState();
}

class _account_viewState extends State<account_view> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    appProvider.getUserInfoFireBase();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              appProvider.getUserInformation.image == null
                  ? Icon(
                      Icons.person,
                      size: 100,
                    )
                  : CircleAvatar(
                      backgroundImage:
                          NetworkImage(appProvider.getUserInformation.image!),
                      radius: 70,
                    ),
              Text(
                appProvider.getUserInformation.name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              ElevatedButton(
                onPressed: () {
                  Routes.instance.push(widget: edit_prfile(), context: context);
                },
                child: const Text('Edit Profile'),
              ),
            ],
          )),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.shopping_bag),
                    title: Text("Your Order"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: favorite_view(), context: context);
                    },
                    leading: Icon(Icons.favorite_outline),
                    title: Text("Favourite"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.info),
                    title: Text("About us"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.contact_support),
                    title: Text("Support"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: changePassword(), context: context);
                    },
                    leading: Icon(Icons.change_circle_outlined),
                    title: Text("Change Password"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      setState(() {});
                    },
                    leading: Icon(Icons.logout),
                    title: Text("Log out"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Version 1.0.0")
                ],
              ))
        ],
      ),
    );
  }
}
