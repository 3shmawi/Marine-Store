import 'package:beauty_supplies_project/models/rate.dart';
import 'package:beauty_supplies_project/models/user.dart';
import 'package:beauty_supplies_project/services/firestore_services.dart';
import 'package:beauty_supplies_project/shared/user_data_cubit/user_state.dart';
import 'package:beauty_supplies_project/utilities/firebase_collections_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  UserModel? userModel;

  void getUserData() {}

  final FirestoreServices _service = FirestoreServices.instance;

  void setRate({required RateModel valueRate, required String productId}) {
    emit(SetRateLoadingState());
    _service
        .setData(
            path: FirebaseCollectionPath.setRate(productId),
            data: valueRate.toMap())
        .then((value) {
      emit(SetRateSuccessState());
    }).catchError((error) {
      emit(SetRateErrorState());
    });
  }
}
