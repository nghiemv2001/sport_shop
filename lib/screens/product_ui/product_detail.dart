import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/constants/routes.dart';
import 'package:demo_sogin_signup_firebase/models/product_model.dart';
import 'package:demo_sogin_signup_firebase/provider/provider_model.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/Cart_UI/CartView.dart';
import 'package:demo_sogin_signup_firebase/screens/buy_product/buy_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    AppProvider approvider = Provider.of<AppProvider>(context, listen: false);
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
                  "",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
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
                  icon: Icon(approvider.getfavoriteProductList
                          .contains(widget.singleProduct)
                      ? Icons.favorite
                      : Icons.favorite_border)),
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
          SizedBox(
            height: 10,
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
              OutlinedButton(
                  onPressed: () {
                    Product product = widget.singleProduct.copyWith(qty: qty);
                    approvider.addCartProduct(product);
                    showMessage("ADD CART");
                  },
                  child: Text("ADD TO CART")),
              const SizedBox(
                width: 24,
              ),
              SizedBox(
                height: 38,
                width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    Product product = widget.singleProduct.copyWith(qty: qty);
                    Routes.instance.push(
                        widget: checkout(
                          singleProduct: product,
                        ),
                        context: context);
                  },
                  child: Text("BUY"),
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
