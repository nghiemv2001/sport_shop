import 'package:demo_sogin_signup_firebase/firebase/firebase_firestore/firebase_firebasestore.dart';
import 'package:demo_sogin_signup_firebase/models/order_model.dart';
import 'package:flutter/material.dart';

class order_view extends StatelessWidget {
  const order_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Order",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFireStoreHelper.instance.getUserOrder(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return Center(
              child: Text("No order found"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              orderModel order = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red, width: 2.3)),
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red, width: 2.3)),
                  title: Row(
                    children: [
                      Container(
                        height: 155,
                        width: 155,
                        color: Colors.red.withOpacity(0.5),
                        child: Image.network(order.products[0].image),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 140,
                          color: Colors.white.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      order.products[0].name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  order.products.length > 1
                                      ? SizedBox.fromSize()
                                      : Column(
                                          children: [
                                            Text(
                                              "${order.products[0].qty.toString()}\$",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "${order.totalPrice.toString()}\$",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "${order.status}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                  children: order.products.length > 1 ? [Text("Hello")] : [],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
