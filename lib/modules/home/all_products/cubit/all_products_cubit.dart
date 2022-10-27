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


}
