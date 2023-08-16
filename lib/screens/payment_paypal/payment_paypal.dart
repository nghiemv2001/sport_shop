import 'package:flutter/material.dart';

class paypal_screen extends StatelessWidget {
  const paypal_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paypal_Screen"),
      ),
      body: const Column(
        children: [Center(child: Text("Success"))],
      ),
    );
  }
}
