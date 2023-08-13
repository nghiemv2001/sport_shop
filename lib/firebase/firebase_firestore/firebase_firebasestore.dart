import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/models/category_model.dart';
import 'package:demo_sogin_signup_firebase/models/product_model.dart';
import 'package:demo_sogin_signup_firebase/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFireStoreHelper {
  static FirebaseFireStoreHelper instance = FirebaseFireStoreHelper();
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
      List<Product> bestProductList =
          querySnapshot.docs.map((e) => Product.fromJson(e.data())).toList();
      return bestProductList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInForm() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapShot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return UserModel.fromJson(querySnapShot.data()!);
  }
}
