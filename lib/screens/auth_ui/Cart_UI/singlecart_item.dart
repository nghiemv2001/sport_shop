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
    AppProvider approvider = Provider.of<AppProvider>(context, listen: false);
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(qty.toString()),
                                    SizedBox(
                                      width: 10,
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
                                Row(
                                  children: [
                                    CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          if (!approvider.getfavoriteProductList
                                              .contains(widget.singProduct)) {
                                            approvider.addfavoriteProduct(
                                                widget.singProduct);
                                            showMessage("Add to favouritelist");
                                          } else {
                                            approvider.removefavoriteProduct(
                                                widget.singProduct);
                                            showMessage("Removed to wishlist");
                                          }
                                        },
                                        child: Text(
                                          approvider.getfavoriteProductList
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
                          Text(
                            "${widget.singProduct.price}\$",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            AppProvider approvider = Provider.of<AppProvider>(
                                context,
                                listen: false);
                            approvider.removeCartProduct(widget.singProduct);
                            showMessage("Remove from cart");
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
