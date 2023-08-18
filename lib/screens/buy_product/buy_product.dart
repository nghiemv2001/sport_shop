import 'package:demo_sogin_signup_firebase/firebase/firebase_firestore/firebase_firebasestore.dart';
import 'package:demo_sogin_signup_firebase/screens/buy_product/single_productbuy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../models/product_model.dart';
import '../../provider/provider_model.dart';
import '../custom_bottom_bar/custom_bottom_bar.dart';

class checkout extends StatefulWidget {
  final Product singleProduct;
  const checkout({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  int groupvalue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider approvider = Provider.of<AppProvider>(context, listen: false);
    approvider.getCartProductList;
    print(approvider.getCartProductList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            approvider.getCartProductList.isEmpty
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
                : Expanded(
                    flex: 2,
                    child: ListView.builder(
                        itemCount: approvider.getCartProductList.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (ctx, index) {
                          return SingGle_productbuy_item(
                            singProduct: approvider.getCartProductList[index],
                          );
                        }),
                  ),
            Expanded(
              flex: 1,
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
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
                        approvider.addBuyProduct(widget.singleProduct);
                        bool value = await FirebaseFireStoreHelper.instance
                            .upLoadOrderProductFirebase(
                                approvider.getBuyProductList,
                                context,
                                groupvalue == 1 ? "Cash an Delivery" : "Paid");
                        approvider.clearBuyProduct();
                        if (value) {
                          Future.delayed(Duration(seconds: 2), () {
                            Routes.instance.push(
                                widget: CustomBottomBar(), context: context);
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadio extends StatefulWidget {
  final int value;
  final int groupValue;
  final void Function(int) onChanged;
  const CustomRadio(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Colors.white : Colors.grey[200]),
        child: Icon(
          Icons.circle,
          size: 30,
          color: selected ? Colors.deepPurple : Colors.grey[200],
        ),
      ),
    );
  }
}
