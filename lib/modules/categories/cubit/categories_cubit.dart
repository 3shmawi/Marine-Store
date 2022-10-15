import 'package:beauty_supplies_project/models/category.dart';
import 'package:beauty_supplies_project/services/firestore_services.dart';
import 'package:beauty_supplies_project/utilities/firebase_collections_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  final FirestoreServices _service = FirestoreServices.instance;

  Stream<List<CategoryModel>> categoryStream() => _service.collectionsStream(
        path: FirebaseCollectionPath.category(),
        builder: (data, documentId) => CategoryModel.fromMap(data!, documentId),
      );
}
