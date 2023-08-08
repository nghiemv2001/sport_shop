import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/models/category_model.dart';
import 'package:demo_sogin_signup_firebase/models/product_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();
      List<Category> categoriesList =
          querySnapshot.docs.map((e) => Category.fromJson(e.data())).toList();
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<Product>> getCategoriesViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();
      List<Product> categoriesViewProductList =
          querySnapshot.docs.map((e) => Product.fromJson(e.data())).toList();
      return categoriesViewProductList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<Product>> getBestProductList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();
      for (var element in querySnapshot.docs) {
        print(element.data());
      }
      List<Product> bestProductList =
          querySnapshot.docs.map((e) => Product.fromJson(e.data())).toList();
      return bestProductList;
    } catch (e) {
      print(e.toString());
      showMessage(e.toString());
      return [];
    }
  }
}
