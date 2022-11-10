import 'package:beauty_supplies_project/models/product.dart';

const String tableEcommerceCart = 'cart';
const String tableEcommerceFavorite = 'fav';

class ProductFields {
  static final List<String> values = [
    /// Add all fields
    dbId,
    id,
    discountValue,
    category,
    title,
    description,
    price,
    imgUrl,
    rate,
    count
  ];

  static const String dbId = 'dbId';

  static const String id = 'productId';
  static const String title = 'title';
  static const String description = 'description';
  static const String imgUrl = 'imgUrl';
  static const String discountValue = 'discountValue';
  static const String category = 'category';
  static const String rate = 'rate';
  static const String price = 'price';
  static const String count = 'count';
}

class CartProductModel extends ProductModel {
  int? dbId;
  int count;

  CartProductModel({
    required String productId,
    required String title,
    required String category,
    required String imgUrl,
    required String description,
    required int price,
    required int discountValue,
    required int rate,
    this.dbId,
    this.count = 1,
  }) : super(
          id: productId,
          title: title,
          description: description,
          price: price,
          imgUrl: imgUrl,
          category: category,
          discountValue: discountValue,
          rate: rate,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'description': description,
      'discountValue': discountValue,
      'category': category,
      'rate': rate,
      'dbId': dbId,
      'count': count,
    };
  }

  @override
  factory CartProductModel.fromMapWithoutId(Map<String, dynamic> map) {
    return CartProductModel(
      productId: map['id'] as String,
      title: map['title'] as String,
      price: map['price'] as int,
      imgUrl: map['imgUrl'] as String,
      description: map['description'] as String,
      discountValue: map['discountValue'] as int,
      category: map['category'] as String,
      rate: map['rate'] as int,
      count: map['count'] as int,
      dbId: map['dbId'] as int,
    );
  }

  CartProductModel copy({
    String? productId,
    String? title,
    String? category,
    String? imgUrl,
    String? description,
    int? price,
    int? discountValue,
    int? rate,
    int? count,
    int? dbId,
  }) =>
      CartProductModel(
        dbId: dbId ?? this.dbId,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        imgUrl: imgUrl ?? this.imgUrl,
        price: price ?? this.price,
        productId: productId ?? id,
        discountValue: discountValue ?? this.discountValue!,
        rate: rate ?? this.rate!,
        count: count ?? this.count,
      );
}

class FavProductModel extends ProductModel {
  int? dbId;

  FavProductModel({
    required String productId,
    required String title,
    required String category,
    required String imgUrl,
    required String description,
    required int price,
    required int discountValue,
    required int rate,
    this.dbId,
  }) : super(
          id: productId,
          title: title,
          description: description,
          price: price,
          imgUrl: imgUrl,
          category: category,
          discountValue: discountValue,
          rate: rate,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'description': description,
      'discountValue': discountValue,
      'category': category,
      'rate': rate,
      'dbId': dbId,
    };
  }

  @override
  factory FavProductModel.fromMapWithoutId(Map<String, dynamic> map) {
    return FavProductModel(
      productId: map['id'] as String,
      title: map['title'] as String,
      price: map['price'] as int,
      imgUrl: map['imgUrl'] as String,
      description: map['description'] as String,
      discountValue: map['discountValue'] as int,
      category: map['category'] as String,
      rate: map['rate'] as int,
      dbId: map['dbId'] as int,
    );
  }

  FavProductModel copy({
    String? productId,
    String? title,
    String? category,
    String? imgUrl,
    String? description,
    int? price,
    int? discountValue,
    int? rate,
    int? dbId,
  }) =>
      FavProductModel(
        dbId: dbId ?? this.dbId,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        imgUrl: imgUrl ?? this.imgUrl,
        price: price ?? this.price,
        productId: productId ?? id,
        discountValue: discountValue ?? this.discountValue!,
        rate: rate ?? this.rate!,
      );
}
