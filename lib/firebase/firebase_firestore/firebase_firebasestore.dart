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

  Future<List<Product>> getBestProductList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("products").get();
      for (var element in querySnapshot.docs) {
        print(element.data());
        print("object2");
      }
      // List<Product> bestProductList =
      //     querySnapshot.docs.map((e) => Product.fromJson(e.data())).toList();
      return [];
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
}
