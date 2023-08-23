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
  final List<Product> _favoriteProductlist = [];

  List<Product> get getCartProductList => _cartProductlist;
  List<Product> get getBuyProductList => _buyProductlist;
  List<Product> get getFavoriteProductList => _favoriteProductlist;

  //CartProductList-----------------------------------------------------------
  void addCartProduct(Product product) {
    _cartProductlist.add(product);
    notifyListeners();
  }

  void removeCartProduct(Product product) {
    print("2");
    _cartProductlist.remove(product);
    print("3");
    notifyListeners();
    print("4");
  }

  void clearCart() {
    _cartProductlist.clear();
    notifyListeners();
  }

  void updateQty(Product product, int qty) {
    int index = _cartProductlist.indexOf(product);
    _cartProductlist[index].qty = qty;
  }

  //TOTAL PRICE
  double totalPrice() {
    double totalprice = 0.0;
    for (var element in _cartProductlist) {
      totalprice += element.price * element.qty!;
    }
    return totalprice;
  }
  //BuyProductList-----------------------------------------------------------

  void addBuyProduct(Product product) {
    _buyProductlist.add(product);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductlist.addAll(_cartProductlist);
    notifyListeners();
  }

  void addOneBuyProduct(product) {
    _buyProductlist.add(product);
    notifyListeners();
  }

  void removeBuyProduct(Product product) {
    print("3");
    _buyProductlist.remove(product);
    print("4");
    notifyListeners();
    print("5");
  }

  void clearBuyProduct() {
    _buyProductlist.clear();
    notifyListeners();
  }

  double totalPriceBuyProduct() {
    double totalprice = 0.0;
    for (var element in _buyProductlist) {
      totalprice += element.price * element.qty!;
    }
    return totalprice;
  }

  //FavouriteList-----------------------------------------------------------
  void addfavoriteProduct(Product product) {
    _favoriteProductlist.add(product);
    notifyListeners();
  }

  void removefavoriteProduct(Product product) {
    _favoriteProductlist.remove(product);
    notifyListeners();
  }

  //User-----------------------------------------------------------
  Future<void> getUserInfoFireBase() async {
    _userModel = await FirebaseFireStoreHelper.instance.getUserInForm();
    notifyListeners();
  }

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
}
