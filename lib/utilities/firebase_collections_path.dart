import 'package:beauty_supplies_project/utilities/constants.dart';

class FirebaseCollectionPath {
  static String products() => 'products/';

  static String category() => 'category/';

  static String carousel() => 'layout_image/';

  static String deliveryMethods() => 'deliveryMethods/';

  static String clientUser(String uid) => 'usr/client/$uid';

  static String addAdminProduct({
    required String adminId,
    required String newId,
  }) =>
      'usr/NmNa78EEMS4WLDi5r5Jy/admin/$adminId/products/$newId';

  static String getAdminProducts() =>
      'usr/NmNa78EEMS4WLDi5r5Jy/admin/$userId/products/';

  static String addToCart(String uid, String addToCartId) =>
      'users/$uid/cart/$addToCartId';

  static String myProductsCart(String uid) => 'users/$uid/cart/';
}
