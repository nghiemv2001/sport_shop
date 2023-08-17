import 'package:demo_sogin_signup_firebase/provider/provider_model.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/category_ui/category_viewproducts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../firebase/firebase_firestore/firebase_firebasestore.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../product_ui/product_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  List<Category> categorieslist = [];
  List<Product> bestproductlist = [];
  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFireBase();
    getCategoryList();
    super.initState();
  }

  Future<void> _runFilter(String enterkeyword) async {
    List<Product> results = [];
    bestproductlist =
        await FirebaseFireStoreHelper.instance.getBestProductList();
    if (enterkeyword.isEmpty) {
      results = bestproductlist;
    } else {
      results = bestproductlist
          .where((product) =>
              product.name.toLowerCase().contains(enterkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      bestproductlist = results;
    });
  }

  Future<void> getCategoryList() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); //
    setState(() {
      isLoading = true;
    });
    FirebaseFireStoreHelper.instance.updateTokeFromFirebase();
    categorieslist = await FirebaseFireStoreHelper.instance.getCategories();
    bestproductlist =
        await FirebaseFireStoreHelper.instance.getBestProductList();
    bestproductlist.shuffle();
    setState(() {
      isLoading = false;
    });
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Sport Shop",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          onChanged: (value) => _runFilter(value),
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                            labelStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            labelText: "Search ...",
                            fillColor: Colors.white.withOpacity(0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Đặt giá trị bo tròn tại đây
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Categories...",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  categorieslist.isEmpty
                      ? const Center(
                          child: Text("Categories empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categorieslist
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CupertinoButton(
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget: CategoryView(category: e),
                                            context: context);
                                      },
                                      child: Card(
                                          color: Colors.white,
                                          elevation: 13.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            child: SizedBox(
                                              height: 90,
                                              width: 90,
                                              child: Image.network(e.image),
                                            ),
                                          )),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 10, top: 10, right: 0, bottom: 0),
                    child: Text(
                      "Top Sales ...",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              padding: EdgeInsets.only(bottom: 50),
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
                                Product singleProduct = bestproductlist[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20)),
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
                                        "${singleProduct.price}\$",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.blue,
                                                spreadRadius: 3),
                                          ],
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: ProductDetail(
                                                    singleProduct:
                                                        singleProduct),
                                                context: context);
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "BUY",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.shopping_cart,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                ],
              ),
            ),
    );
  }
}
