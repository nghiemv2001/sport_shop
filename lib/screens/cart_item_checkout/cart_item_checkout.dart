import 'package:demo_sogin_signup_firebase/firebase/firebase_firestore/firebase_firebasestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../provider/provider_model.dart';
import '../custom_bottom_bar/custom_bottom_bar.dart';

class cartItemCheckOut extends StatefulWidget {
  const cartItemCheckOut({Key? key}) : super(key: key);

  @override
  State<cartItemCheckOut> createState() => _cartItemCheckOutState();
}

class _cartItemCheckOutState extends State<cartItemCheckOut> {
  int groupvalue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider approvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupvalue,
                      onChanged: (value) {
                        setState(() {
                          groupvalue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    "Cash an Delivery",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupvalue,
                      onChanged: (value) {
                        setState(() {
                          groupvalue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    "Credit Card",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 45,
              child: ElevatedButton(
                child: Text(
                  "Continues",
                ),
                onPressed: () async {
                  bool value = await FirebaseFireStoreHelper.instance
                      .upLoadOrderProductFirebase(
                          approvider.getBuyProductList,
                          context,
                          groupvalue == 1 ? "Cash an Delivery" : "Paid");
                  if (value) {
                    Future.delayed(Duration(seconds: 2), () {
                      Routes.instance
                          .push(widget: CustomBottomBar(), context: context);
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
