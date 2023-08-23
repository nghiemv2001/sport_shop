import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constans.dart';
import '../../../models/product_model.dart';
import '../../../provider/provider_model.dart';

class SingGle_cart_item extends StatefulWidget {
  final Product singProduct;
  const SingGle_cart_item({Key? key, required this.singProduct})
      : super(key: key);

  @override
  State<SingGle_cart_item> createState() => SingGle_cart_itemState();
}

class SingGle_cart_itemState extends State<SingGle_cart_item> {
  int qty = 0;
  @override
  void initState() {
    qty = widget.singProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProved = Provider.of<AppProvider>(context, listen: false);
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
                color: Colors.white.withOpacity(0.5),
                child: Image.network(widget.singProduct.image),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 140,
                color: Colors.white.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    widget.singProduct.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Text(
                                        "x${qty.toString()}",
                                        style: TextStyle(fontSize: 23),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, left: 80),
                                      child: Text(
                                        "${widget.singProduct.price * qty}\$",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          if (!appProved.getFavoriteProductList
                                              .contains(widget.singProduct)) {
                                            appProved.addfavoriteProduct(
                                                widget.singProduct);
                                            showMessage("Add to favouritelist");
                                          } else {
                                            appProved.removefavoriteProduct(
                                                widget.singProduct);
                                            showMessage("Removed to wishlist");
                                          }
                                        },
                                        child: Text(
                                          appProved.getFavoriteProductList
                                                  .contains(widget.singProduct)
                                              ? "Remove to wishlist"
                                              : "Add to favouritelist",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.lightBlue,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                )
                              ]),
                        ],
                      ),
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            print("1");
                            appProved.removeCartProduct(widget.singProduct);
                            print("5");
                            showMessage("Remove from cart");
                            print("6");
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            maxRadius: 13,
                            child: Icon(
                              Icons.delete,
                              color: Colors.black,
                              size: 17,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
    ;
  }
}
