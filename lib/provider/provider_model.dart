import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class AppProvider with ChangeNotifier {
  //cart work
  final List<Product> _cartProductlist = [];
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

  List<Product> get getfavoriteProductList => _favoriteProductlist;
}
