import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_sogin_signup_firebase/constants/constans.dart';
import 'package:demo_sogin_signup_firebase/firebase/firebase_firestore/firebase_firebasestore.dart';
import 'package:demo_sogin_signup_firebase/models/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../firebase/firebase_firestore/firebase_storage_helper.dart';
import '../models/product_model.dart';

class AppProvider with ChangeNotifier {
  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;
  //cart work
  final List<Product> _cartProductlist = [];
  final List<Product> _buyProductlist = [];
  void addCartProduct(Product product) {
    _cartProductlist.add(product);
    notifyListeners();
  }

  void removeCartProduct(Product product) {
    _cartProductlist.remove(product);
    notifyListeners();
  }

  List<Product> get getCartProductList => _cartProductlist;
  //isfavorite
  final List<Product> _favoriteProductlist = [];
  void addfavoriteProduct(Product product) {
    _favoriteProductlist.add(product);
    notifyListeners();
  }

  void removefavoriteProduct(Product product) {
    _favoriteProductlist.remove(product);
    notifyListeners();
  }

  Future<void> getUserInfoFireBase() async {
    _userModel = await FirebaseFireStoreHelper.instance.getUserInForm();
    notifyListeners();
  }

  List<Product> get getfavoriteProductList => _favoriteProductlist;

  ///User Inform
  Future<void> updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDiaLog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDiaLog(context);
      String imageURL = await Firebase_StorageHelper.instance.upLoadImage(file);
      _userModel = userModel.copyWith(image: imageURL);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());

      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showMessage("Successfully updated profile");
    notifyListeners();
  }

  //TOTAL PRICE
  double totalPrice() {
    double totalprice = 0.0;
    for (var element in _cartProductlist) {
      totalprice += element.price * element.qty!;
    }
    return totalprice;
  }

  void updateQty(Product product, int qty) {
    int index = _cartProductlist.indexOf(product);
    _cartProductlist[index].qty = qty;
  }

  ///buy product
  void addBuyProduct(Product product) {
    _buyProductlist.add(product);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductlist.addAll(_cartProductlist);
    notifyListeners();
  }

  void clearCart() {
    _cartProductlist.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductlist.clear();
    notifyListeners();
  }

  List<Product> get getBuyProductList => _buyProductlist;
}
