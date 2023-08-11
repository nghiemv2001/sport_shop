import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/product_model.dart';
import '../../../../provider/provider_model.dart';

class SingGle_Favourite_item extends StatefulWidget {
  final Product singProduct;
  const SingGle_Favourite_item({Key? key, required this.singProduct})
      : super(key: key);

  @override
  State<SingGle_Favourite_item> createState() => SingGle_Favourite_itemState();
}

class SingGle_Favourite_itemState extends State<SingGle_Favourite_item> {
  @override
  Widget build(BuildContext context) {
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
                color: Colors.red.withOpacity(0.5),
                child: Image.network(widget.singProduct.image),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 140,
                color: Colors.white.withOpacity(0.5),
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Stack(alignment: Alignment.bottomRight, children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    widget.singProduct.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    CupertinoButton(
                                        child: const Text(
                                          "Removed to wishlist",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          AppProvider approvider =
                                              Provider.of<AppProvider>(context,
                                                  listen: false);
                                          approvider.removefavoriteProduct(
                                              widget.singProduct);
                                          showMessage("Removed to wish list");
                                        }),
                                  ],
                                )
                              ]),
                          Text(
                            "Price: ${widget.singProduct.price} \$",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ])),
              ),
            )
          ],
        ));
    ;
  }
}
