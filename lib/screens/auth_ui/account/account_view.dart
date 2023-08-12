import 'package:flutter/material.dart';

class account_view extends StatelessWidget {
  const account_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Icon(
                Icons.person,
                size: 100,
              ),
              Text(
                "VO TRONG NGHIEM",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
              ),
              Text(
                "nghiemV2001@gmail.com",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Edit Profile'),
              ),
            ],
          )),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.shopping_bag),
                    title: Text("Your Order"),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite_outline),
                    title: Text("Favourite"),
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("About us"),
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_support),
                    title: Text("Support"),
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
