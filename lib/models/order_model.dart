import 'package:demo_sogin_signup_firebase/models/product_model.dart';
//
// Order productFromJson(String str) => Order.fromJson(json.decode(str));
//
// String productToJson(Order data) => json.encode(data.toJson());

class orderModel {
  orderModel(
      {required this.totalPrice,
      required this.orderId,
      required this.payment,
      required this.products,
      required this.status});
  String payment;
  String status;
  List<Product> products;
  double totalPrice;
  String orderId;

  factory orderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return orderModel(
        orderId: json["orderId"],
        products: productMap.map((e) => Product.fromJson(e)).toList(),
        totalPrice: json["totalPrice"],
        status: json["status"],
        payment: json["payment"]);
  }
}
