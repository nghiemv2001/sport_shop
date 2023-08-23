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
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty) {
                print("1");
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
                                      height: 5,
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
                                      height: 5,
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
                                      height: 5,
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
                    children: order.products.length > 1
                        ? [
                            const Text(
                              "Details",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            ...order.products.map((singleProducts) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color: Colors.red.withOpacity(0.5),
                                          child: Image.network(
                                              singleProducts.image),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 95,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      singleProducts.name,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "${singleProducts.qty.toString()}\$",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${singleProducts.price.toString()}\$",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              } else {
                print('2');
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
