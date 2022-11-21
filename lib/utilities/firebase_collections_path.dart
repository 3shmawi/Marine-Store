
import '../services/cache_helper_services.dart';
import 'enums.dart';

class FirebaseCollectionPath {
  static String userId = CacheHelper.getData(key: SharedKeys.id);

  static String carousel() => 'layout_image/';

  static String category() => 'category/';

  static String setProductsAtProductsPath(String productId) =>
      'products/$productId';

  static String setProductsAtCategoryProductsPath(
    String category,
    String productId,
  ) =>
      '$category/$productId';

  static String setAdminProducts(
    String productId,
  ) =>
      'admins/$userId/products/$productId';

  static String getAdminProducts() => 'admins/$userId/products/';

  static String getAllProducts() => 'products/';

  static String getCategoryProducts(String category) => '$category/';

  static String deleteAdminProduct(
    String productId,
  ) =>
      'admins/$userId/products/$productId';

  static String deleteProductFromAllProducts(
    String productId,
  ) =>
      'products/$productId';

  static String deleteProductFromCategories(
    String category,
    String productId,
  ) =>
      '$category/$productId';

  static String deliveryMethods() => 'deliveryMethods/';

  static String clientUser(String uid) => 'usr/$uid';



  static String addAdminProduct({
    required String adminId,
    required String newId,
  }) =>
      'usr/41yKO3ID3jkZkqQtrSbx/admin/$adminId/products/$newId';

  static String setRate(
    String productId,
  ) =>
      'products/$productId/rates/$userId';

  static String getRates(
    String productId,
  ) =>
      'products/$productId/rates/';

  // static String getAdminProducts() =>
  //     'usr/41yKO3ID3jkZkqQtrSbx/admin/$userId/products/';

  static String deleteAdminProducts(String id) =>
      'usr/41yKO3ID3jkZkqQtrSbx/admin/$userId/products/$id';

  static String addToCart(String uid, String addToCartId) =>
      'users/$uid/cart/$addToCartId';

  static String myProductsCart(String uid) => 'users/$uid/cart/';
}
