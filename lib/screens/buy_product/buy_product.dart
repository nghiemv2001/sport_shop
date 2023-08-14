import 'package:demo_sogin_signup_firebase/firebase/firebase_firestore/firebase_firebasestore.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      // bottomNavigationBar: SizedBox(
      //   height: 200,
      //   child: Padding(
      //     padding: const EdgeInsets.all(8),
      //     child: Column(
      //       children: [
      //         const Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               "Total",
      //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //             ),
      //             Text(
      //               "\$150",
      //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //             )
      //           ],
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         SizedBox(
      //           width: 350,
      //           height: 60,
      //           child: ElevatedButton(
      //             child: Text(
      //               "Finish",
      //             ),
      //             onPressed: () {},
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
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
                    "Cash an Delivery",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
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
                    "Credit Card",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 45,
              child: ElevatedButton(
                child: Text(
                  "Continues",
                ),
                onPressed: () async {
                  approvider.getBuyProductList.clear();
                  approvider.addBuyProduct(widget.singleProduct);
                  bool value = await FirebaseFireStoreHelper.instance
                      .upLoadOrderProductFirebase(
                          approvider.getBuyProductList,
                          context,
                          groupvalue == 1 ? "Cash an Delivery" : "Paid");
                  if (value) {
                    Future.delayed(Duration(seconds: 2), () {
                      Routes.instance
                          .push(widget: CustomBottomBar(), context: context);
                    });
                  }
                },
              ),
            )
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
