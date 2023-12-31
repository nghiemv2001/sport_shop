import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/Cart_UI/singlecart_item.dart';
import 'package:demo_sogin_signup_firebase/screens/buy_product/buyProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';
import '../../../provider/provider_model.dart';

class Cart_View extends StatefulWidget {
  const Cart_View({Key? key}) : super(key: key);

  @override
  State<Cart_View> createState() => _Cart_ViewState();
}

class _Cart_ViewState extends State<Cart_View> {
  @override
  Widget build(BuildContext context) {
    AppProvider approvider = Provider.of<AppProvider>(context);
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 200,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: approvider.getCartProductList.isEmpty
                ? Container()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${approvider.totalPrice().toString()}\$",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.lightBlue,
                          boxShadow: const [
                            BoxShadow(color: Colors.white, spreadRadius: 1),
                          ],
                        ),
                        child: TextButton(
                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            approvider.addBuyProductCartList();
                            approvider.clearCart();
                            if (approvider.getBuyProductList.isEmpty) {
                              showMessage("Cart is empty");
                            } else {
                              Routes.instance.push(
                                widget: const buyProduct(),
                                context: context,
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
          ),
        ),
        appBar: AppBar(
          title: const Center(
            child: Text(
              "CART",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: approvider.getCartProductList.isEmpty
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
                itemCount: approvider.getCartProductList.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (ctx, index) {
                  print("đã goi");
                  return SingGle_cart_item(
                    singProduct: approvider.getCartProductList[index],
                  );
                }));
  }
}
