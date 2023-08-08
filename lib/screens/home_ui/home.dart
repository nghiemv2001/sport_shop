import 'package:demo_sogin_signup_firebase/firebase/firebase_firestore/firebase_firebasestore.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/category_ui/category_viewproducts.dart';
import 'package:demo_sogin_signup_firebase/screens/product_ui/product_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';

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
    getCategoryList();
    super.initState();
  }

  Future<void> getCategoryList() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); //
    setState(() {
      isLoading = true;
    });
    categorieslist = await FirebaseFirestoreHelper.instance.getCategories();

    bestproductlist =
        await FirebaseFirestoreHelper.instance.getBestProductList();
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
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sport Shop",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            labelStyle: TextStyle(color: Colors.black45),
                            filled: true,
                            labelText: "Search ...",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    width: 2, style: BorderStyle.none)),
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
                                Product singleProduct = bestproductlist[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.withOpacity(0.3),
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
                                                foregroundColor: Colors.black45,
                                                side: const BorderSide(
                                                    color: Colors.red)),
                                            child: const Text(
                                              "BUY",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
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
