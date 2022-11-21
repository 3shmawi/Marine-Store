import 'package:beauty_supplies_project/models/rate.dart';
import 'package:beauty_supplies_project/models/user.dart';

import '../models/carousel_slider.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../services/firestore_services.dart';
import '../utilities/firebase_collections_path.dart';

abstract class DatabaseController {
  Stream<List<CarouselSliderModel>> getCarouselSliderImagesStream();

  Stream<List<CategoryModel>> getCategoryStream();

  Stream<List<ProductModel>> getAdminProductsStream();

  Stream<List<ProductModel>> getAllProductsStream();

  Stream<List<ProductModel>> getCategoryProductsStream(String category);

  Stream<List<RateModel>> getRateProductStream(String productId);

  Stream<UserModel> getUserDataStream(String uid);

  Future<void> deleteUser(String path);
}

class FireStoreDataBase implements DatabaseController {
  final _service = FirestoreServices.instance;

  @override
  Stream<List<CarouselSliderModel>> getCarouselSliderImagesStream() =>
      _service.collectionsStream(
        path: FirebaseCollectionPath.carousel(),
        builder: (data, documentId) =>
            CarouselSliderModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<CategoryModel>> getCategoryStream() => _service.collectionsStream(
        path: FirebaseCollectionPath.category(),
        builder: (data, documentId) => CategoryModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<ProductModel>> getAdminProductsStream() =>
      _service.collectionsStream(
        path: FirebaseCollectionPath.getAdminProducts(),
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<ProductModel>> getAllProductsStream() =>
      _service.collectionsStream(
        path: FirebaseCollectionPath.getAllProducts(),
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<ProductModel>> getCategoryProductsStream(String category) =>
      _service.collectionsStream(
        path: FirebaseCollectionPath.getAllProducts(),
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('category', isEqualTo: category),
      );

  @override
  Stream<List<RateModel>> getRateProductStream(String productId) =>
      _service.collectionsStream(
        path: FirebaseCollectionPath.getRates(productId),
        builder: (date, documentId) => RateModel.fromMap(date!, documentId),
      );

  @override
  Stream<UserModel> getUserDataStream(String uid) => _service.documentsStream(
      path: FirebaseCollectionPath.clientUser(uid),
      builder: (data, documentId) => UserModel.fromMap(data!, documentId));

  @override
  Future<void> deleteUser(String path) => _service.deleteData(path: path);
}
