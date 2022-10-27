import '../models/carousel_slider.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../services/firestore_services.dart';
import '../utilities/firebase_collections_path.dart';

abstract class DatabaseController {
  Stream<List<CarouselSliderModel>> carouselSliderImagesStream();

  Stream<List<CategoryModel>> categoryStream();

  Stream<List<ProductModel>> allProductsStream();
// Stream<List<Product>> newProductsStream();
// Stream<List<AddToCartModel>> myProductsCart();
// Stream<List<DeliveryMethod>> deliveryMethodsStream();
// Stream<List<ShippingAddress>> getShippingAddresses();
//
// Future<void> setUserData(UserData userData);
// Future<void> addToCart(AddToCartModel product);
// Future<void> saveAddress(ShippingAddress address);

}

class FireStoreDataBase implements DatabaseController {
  final _service = FirestoreServices.instance;

  @override
  Stream<List<CarouselSliderModel>> carouselSliderImagesStream() =>
      _service.collectionsStream(
        path: FirebaseCollectionPath.carousel(),
        builder: (data, documentId) =>
            CarouselSliderModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<CategoryModel>> categoryStream() => _service.collectionsStream(
        path: FirebaseCollectionPath.category(),
        builder: (data, documentId) => CategoryModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<ProductModel>> allProductsStream() => _service.collectionsStream(
        path: FirebaseCollectionPath.products(),
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );
}
