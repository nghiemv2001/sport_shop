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
        appBar: AppBar(
          title: const Text(
            "CART",
            style: TextStyle(color: Colors.black),
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
