import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/constants/routes.dart';
import 'package:demo_sogin_signup_firebase/models/product_model.dart';
import 'package:demo_sogin_signup_firebase/provider/provider_model.dart';
import 'package:demo_sogin_signup_firebase/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_ui/Cart_UI/CartView.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.singleProduct})
      : super(key: key);
  final Product singleProduct;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider approvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance
                    .push(widget: const Cart_View(), context: context);
              },
              icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: Column(
        children: [
          Image.network(
            widget.singleProduct.image,
            height: 250,
            width: 250,
          ),
          const Divider(
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  "",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      });
                      if (widget.singleProduct.isFavourite) {
                        approvider.addfavoriteProduct(widget.singleProduct);
                      } else {
                        approvider.removefavoriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(
                      approvider.getfavoriteProductList
                              .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 44,
                    )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              widget.singleProduct.description,
              maxLines: 11,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: 37,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: Icon(Icons.remove),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (qty >= 1) {
                        qty--;
                      }
                    });
                  }),
              const SizedBox(
                width: 20,
              ),
              Text(qty.toString()),
              const SizedBox(
                width: 20,
              ),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: 37,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: Icon(Icons.add),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  }),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 146,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.black, spreadRadius: 1),
                  ],
                ),
                child: TextButton(
                    onPressed: () {
                      Product product = widget.singleProduct.copyWith(qty: qty);
                      approvider.addCartProduct(product);
                      showMessage("ADD CART");
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "ADD TO CART ",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                        Icon(Icons.add_shopping_cart)
                      ],
                    )),
              ),
              const SizedBox(
                width: 24,
              ),
              SizedBox(
                height: 38,
                width: 140,
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.black, spreadRadius: 1),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      // approvider.clearBuyProduct();
                      // approvider.addBuyProductCartList();
                      // approvider.clearCart();
                      Product product = widget.singleProduct.copyWith(qty: 1);
                      approvider.addOneBuyProduct(product);
                      Routes.instance.push(
                          widget: cartItemCheckOut(
                              product: approvider.getCartProductList),
                          context: context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "BUY",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                        Icon(Icons.shopping_cart)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
