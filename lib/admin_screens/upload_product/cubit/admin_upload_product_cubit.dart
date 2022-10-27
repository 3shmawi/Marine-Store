import 'dart:convert';
import 'dart:io';

import 'package:beauty_supplies_project/models/product.dart';
import 'package:beauty_supplies_project/services/firestore_services.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utilities/firebase_collections_path.dart';
import 'admin_upload_product_state.dart';

class AdminUploadProductViewCubit extends Cubit<AdminUploadProductViewState> {
  AdminUploadProductViewCubit() : super(AdminViewInitialState());
  File? imageFile; // picked image will be store here.
  final ImagePicker _picker = ImagePicker(); //instance of image_picker
  String? base64String;

  void resetBase64() {
    base64String = null;
    emit(AdminViewResetImageState());
  }

  void pickImageBase64() async {
    try {
      // pick image from gallery, change ImageSource.camera if you want to capture image from camera.
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      // read picked image byte data.
      Uint8List imageBytes = await image.readAsBytes();
      // using base64 encoder convert image into base64 string.
      base64String = base64.encode(imageBytes);
      if (kDebugMode) {
        print(base64String);
      }

      final imageTemp = File(image.path);

      imageFile =
          imageTemp; // setState to image the UI and show picked image on screen.

      emit(AdminViewPickedImagesSuccessState());
    } on PlatformException catch (e) {
      emit(AdminViewPickedImageErrorState());
      if (kDebugMode) {
        print('error $e');
      }
    }
  }

  String selectedCategory = '';

  void changeSelectedCategory(String newCategory) {
    selectedCategory = newCategory;
    emit(AdminViewChangeSelectedCategoryState());
  }

  final FirestoreServices _service = FirestoreServices.instance;

  String? newId;

  void createNewIdState() {
    newId = createNewId();
    emit(AdminViewCreateNewIdState());
  }

  void setProductAtPathAdmin(ProductModel productModel) {
    emit(AdminViewPostProductAtAdminPathLoadingState());

    _service
        .setData(
            path: FirebaseCollectionPath.setAdminProducts(
              newId!,
            ),
            data: productModel.toMap())
        .then((value) {
      emit(AdminViewPostProductAtAdminPathSuccessState());
      _service
          .setData(
              path: FirebaseCollectionPath.setProductsAtProductsPath(productModel.id),
              data: productModel.toMap())
          .then((value) {
        emit(AdminViewPostProductAtProductsPathSuccessState());
        _service
            .setData(
                path: FirebaseCollectionPath.setProductsAtCategoryProductsPath(
                  productModel.category,
                  productModel.id,
                ),
                data: productModel.toMap())
            .then((value) {
          emit(AdminViewPostProductAtCategoryPathSuccessState());
        }).catchError((error) {
          showToast(text: error.toString(), color: Colors.red);
          print('errorrrrrrrrrrrrrrr1${error.toString()}');
          emit(AdminViewPostProductAtCategoryPathErrorState());
        });
      }).catchError((error) {
        showToast(text: error.toString(), color: Colors.red);
        print('errorrrrrrrrrrrrrrr2${error.toString()}');

        emit(AdminViewPostProductAtProductsPathErrorState());
      });
    }).catchError((error) {
      print('errorrrrrrrrrrrrrrr3${error.toString()}');

      showToast(text: error.toString(), color: Colors.red);
      emit(AdminViewPostProductAtAdminPathErrorState());
    });
  }

  // void setProductAtPathProducts(ProductModel productModel) {
  //   emit(AdminViewPostProductAtProductsPathLoadingState());
  //
  //
  // }
  //
  // void setProductAtPathCategory(ProductModel productModel) {
  //   emit(AdminViewPostProductAtCategoryPathLoadingState());
  //
  //
  // }
  //
  // void postProduct(ProductModel productModel) {
  //   setProductAtPathAdmin(productModel);
  //   setProductAtPathProducts(productModel);
  //   setProductAtPathCategory(productModel);
  // }

  void deleteProduct(String productId, String category) {
    _service
        .deleteData(
      path: FirebaseCollectionPath.deleteAdminProduct(productId),
    )
        .then((value) {
      showToast(text: 'Product deleted successfully', color: Colors.red);
      _service
          .deleteData(
        path: FirebaseCollectionPath.deleteProductFromAllProducts(productId),
      )
          .then((value) {
        _service
            .deleteData(
              path: FirebaseCollectionPath.deleteProductFromCategories(
                  category, productId),
            )
            .then((value) {});
      });
    });
  }
}
