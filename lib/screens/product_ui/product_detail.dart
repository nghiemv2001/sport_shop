import 'package:demo_sogin_signup_firebase/constants/routes.dart';
import 'package:demo_sogin_signup_firebase/models/product_model.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/Cart_UI/CartView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance
                    .push(widget: const Cart_View(), context: context);
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        children: [
          Image.network(
            widget.singleProduct.image,
            height: 250,
            width: 250,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  widget.singleProduct.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.singleProduct.isFavourite =
                          !widget.singleProduct.isFavourite;
                    });
                  },
                  icon: Icon(widget.singleProduct.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(widget.singleProduct.description),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: CircleAvatar(
                    child: Icon(Icons.remove),
                  ),
                  onPressed: () {
                    setState(() {
                      if (qty >= 1) {
                        qty--;
                      }
                    });
                  }),
              SizedBox(
                width: 20,
              ),
              Text(qty.toString()),
              SizedBox(
                width: 20,
              ),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  }),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(onPressed: () {}, child: Text("ADD TO CART")),
              const SizedBox(
                width: 24,
              ),
              SizedBox(
                height: 38,
                width: 140,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("BUY"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
