import 'package:demo_sogin_signup_firebase/screens/buy_product/singleProductBuy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../firebase/firebase_firestore/firebase_firebasestore.dart';
import '../../provider/provider_model.dart';
import '../custom_bottom_bar/custom_bottom_bar.dart';

class buyProduct extends StatefulWidget {
  const buyProduct({Key? key}) : super(key: key);

  @override
  State<buyProduct> createState() => _buyProductState();
}

class _buyProductState extends State<buyProduct> {
  int groupvalue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider approvider = Provider.of<AppProvider>(context);
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 250,
          child: Padding(
              padding: EdgeInsets.all(8),
              child: approvider.getBuyProductList.isEmpty
                  ? Container()
                  : Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 3.0)),
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
                                        "Cash",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 3.0)),
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
                                        "Credit_Card",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${approvider.totalPriceBuyProduct().toString()}\$",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 350,
                            height: 45,
                            child: ElevatedButton(
                              child: Text(
                                "Continues",
                              ),
                              onPressed: () async {
                                approvider.clearBuyProduct();
                                bool value = await FirebaseFireStoreHelper
                                    .instance
                                    .upLoadOrderProductFirebase(
                                        approvider.getBuyProductList,
                                        context,
                                        groupvalue == 1
                                            ? "Cash an Delivery"
                                            : "Paid");
                                approvider.clearBuyProduct();
                                if (value) {
                                  Future.delayed(Duration(seconds: 2), () {
                                    Routes.instance.push(
                                        widget: CustomBottomBar(),
                                        context: context);
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    )),
        ),
        appBar: AppBar(
          title: const Center(
            child: Text(
              "BUY PRODUCT",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: approvider.getBuyProductList.isEmpty
            ? const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitThreeInOut(
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  Text("You haven't any products in cart!"),
                ],
              ))
            : ListView.builder(
                itemCount: approvider.getBuyProductList.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (ctx, index) {
                  return singleProductBuy(
                    singProduct: approvider.getBuyProductList[index],
                  );
                }));
  }
}
