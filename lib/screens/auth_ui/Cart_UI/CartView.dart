import 'package:demo_sogin_signup_firebase/screens/auth_ui/Cart_UI/singlecart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${approvider.totalPrice().toString()}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    child: Text(
                      "Checkout",
                    ),
                    onPressed: () {
                      // approvider.getBuyProductList.clear();
                      // approvider.addBuyProduct(widget.s)
                      // Routes.instance
                      //     .push(widget: checkout(singleProduct: ,), context: context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Center(
            child: const Text(
              "CART",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: approvider.getCartProductList.isEmpty
            ? const Center(
                child: Text("Empty"),
              )
            : ListView.builder(
                itemCount: approvider.getCartProductList.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (ctx, index) {
                  return SingGle_cart_item(
                    singProduct: approvider.getCartProductList[index],
                  );
                }));
  }
}
