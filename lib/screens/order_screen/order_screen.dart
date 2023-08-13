import 'package:flutter/material.dart';

class order_view extends StatelessWidget {
  const order_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Order",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
