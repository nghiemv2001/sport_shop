import 'package:demo_sogin_signup_firebase/models/category_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../constants/routes.dart';
import '../../../firebase/firebase_firestore/firebase_firebasestore.dart';
import '../../../models/product_model.dart';
import '../../product_ui/product_detail.dart';

class CategoryView extends StatefulWidget {
  final Category category;
  const CategoryView({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Product> bestproductlist = [];
  bool isLoading = false;

  Future<void> getCategoryList() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); //
    setState(() {
      isLoading = true;
    });
    bestproductlist = await FirebaseFirestoreHelper.instance
        .getCategoriesViewProduct(widget.category.id);
    bestproductlist.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: kToolbarHeight * 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const BackButton(),
                          Text(
                            widget.category.name,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    bestproductlist.isEmpty
                        ? const Center(
                            child: Text("Top sale Empty"),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10, bottom: 10),
                            child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: bestproductlist.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.7,
                                        crossAxisSpacing: 25,
                                        mainAxisSpacing: 25),
                                itemBuilder: (ctx, index) {
                                  Product singleProduct =
                                      bestproductlist[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.yellow.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          singleProduct.image,
                                          scale: 9,
                                          height: 110,
                                          width: 150,
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          singleProduct.name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Price: ${singleProduct.price} \$",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 140,
                                          child: OutlinedButton(
                                              onPressed: () {
                                                Routes.instance.push(
                                                    widget: ProductDetail(
                                                        singleProduct:
                                                            singleProduct),
                                                    context: context);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                  foregroundColor:
                                                      Colors.black45,
                                                  side: const BorderSide(
                                                      color: Colors.red)),
                                              child: const Text(
                                                "BUY",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                  ],
                ),
              ));
  }
}
