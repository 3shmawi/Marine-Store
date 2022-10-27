import 'package:beauty_supplies_project/models/admins.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/firestore_services.dart';
import '../../../../utilities/firebase_collections_path.dart';
import 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit() : super(AllProductsInitial());

  final FirestoreServices _service = FirestoreServices.instance;

  Stream<List<ProductModel>> allProductsStream() => _service.collectionsStream(
        path: 'products',
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );

  // Stream<List<ProductModel>> allProductsStreams() => _service.documentsStream(
  //       path: FirebaseCollectionPath.allProducts(),
  //       builder: (data, documentId) {
  //         List<ProductModel> productsData = [];
  //         data!.forEach((key, value) {
  //           productsData.add(value);
  //         });
  //         return productsData;
  //       },
  //     );

  List<ProductModel> products = [];

  Future<void> getAllProducts() async {
    emit(GetAllProductsLoadingState());
    FirebaseFirestore.instance
        .collection('usr')
        .doc('41yKO3ID3jkZkqQtrSbx')
        .collection('admin')
        .get()
        .then((value) {
      print('docs of length is =>  ${value.docs.length}');

      for (var element in value.docs) {
        element.reference.collection('products').get().then((value) {
          products.add(ProductModel.fromMap(element.data(), element.id));
          print('Number of length is =>  ${products.length}');
        }).catchError((error) {
          if (kDebugMode) {
            print('kkkkkkk5648kkkkkkkkkkkkk     ${error.toString()}');
          }
        });
      }
      // if (kDebugMode) {
      //   print(products[0].toString());
      // }
      emit(GetAllProductsSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('kkkkkkkkkkkkkkkkkkkkkkkkkkkk     ${error.toString()}');
      }
      emit(GetAllProductsErrorState());
    });
  }
}
