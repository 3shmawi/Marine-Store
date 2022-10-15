import 'package:beauty_supplies_project/services/firestore_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product.dart';
import '../../../utilities/firebase_collections_path.dart';
import 'admin_view_all_products_state.dart';

class AdminViewAllProductsCubit extends Cubit<AdminViewAllProductsState> {
  AdminViewAllProductsCubit() : super(AdminViewAllProductsInitial());

  final FirestoreServices _service = FirestoreServices.instance;

  Stream<List<ProductModel>> getAllProductsStream() =>
      _service.collectionsStream(
        path: FirebaseCollectionPath.getAdminProducts(),
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );
}
