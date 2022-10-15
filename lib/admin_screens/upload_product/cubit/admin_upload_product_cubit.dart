import 'dart:convert';
import 'dart:io';

import 'package:beauty_supplies_project/models/product.dart';
import 'package:beauty_supplies_project/services/firestore_services.dart';
import 'package:beauty_supplies_project/utilities/constants.dart';
import 'package:flutter/foundation.dart';
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

  String selectedCategory = 'البويات';

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

  void postProduct(ProductModel product) {
    emit(AdminViewPostProductLoadingState());
    _service
        .setData(
            path: FirebaseCollectionPath.addAdminProduct(
              adminId: userId!,
              newId: newId!,
            ),
            data: product.toMap())
        .then((value) {
      emit(AdminViewPostProductSuccessState());
    }).catchError((error) {
      emit(AdminViewPostProductErrorState());
    });
  }

  void editProduct({
    required String id,
    required String title,
    required int price,
    required int discountValue,
    required String imgUrl,
    required String description,
    required String category,
  }) {
    emit(AdminViewEditPostProductLoadingState());
    ProductModel product = ProductModel(
      id: id,
      title: title,
      price: price,
      imgUrl: imgUrl,
      description: description,
      category: category,
      discountValue: discountValue,
    );
    _service
        .setData(
            path: FirebaseCollectionPath.addAdminProduct(
              adminId: id,
              newId: id,
            ),
            data: product.toMap())
        .then((value) {
      emit(AdminViewEditPostProductSuccessState());
    }).catchError((error) {
      emit(AdminViewEditPostProductErrorState());
    });
  }
}
