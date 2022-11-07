import 'package:beauty_supplies_project/models/product.dart';


class CartModel {
  ProductModel? productModel;
  int number = 1;

  CartModel({
    required this.productModel,
    required this.number,
  });

  CartModel.fromJson(Map<String, dynamic>? json) {
    number = json!['number'] ?? 1;
    productModel = ProductModel.fromMapWithoutId(json['productModel']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['productModel'] = productModel!.toMap();
    return data;
  }
}