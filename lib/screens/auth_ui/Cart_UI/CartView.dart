import 'package:flutter/material.dart';

class Cart_View extends StatefulWidget {
  const Cart_View({Key? key}) : super(key: key);

  @override
  State<Cart_View> createState() => _Cart_ViewState();
}

class _Cart_ViewState extends State<Cart_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "CART",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.builder(
            itemCount: 4,
            padding: const EdgeInsets.all(12),
            itemBuilder: (ctx, index) {
              return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 3)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 140,
                          color: Colors.red.withOpacity(0.5),
                          child: Image.network(
                              "https://www.punchequipment.com/wp-content/uploads/2022/01/PBG7LACEBL10V322.png"),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 140,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      )
                    ],
                  ));
            }));
  }
}
