import 'package:beauty_supplies_project/models/user.dart';
import 'package:beauty_supplies_project/services/firebase_auth_services.dart';
import 'package:beauty_supplies_project/services/firestore_services.dart';
import 'package:beauty_supplies_project/utilities/firebase_collections_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/cache_helper_services.dart';
import '../../../../utilities/enums.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  final FirestoreServices _service = FirestoreServices.instance;

  Future<void> createUser(UserModel clientUser) async => _service.setData(
        path: FirebaseCollectionPath.clientUser(clientUser.id),
        data: clientUser.toMap(),
      );

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(CreateLoadingState());

    Auth().signUpWithEmailAndPassword(email, password).then((value) {
      CacheHelper.saveData(key: SharedKeys.id, value: value!.uid);
      if (kDebugMode) {
        print('Create User Success');
      }
      createUser(
        UserModel(
          isAdmin: false,
          id: value.uid,
          name: name,
          email: email,
          imgUrl:
              'https://us.123rf.com/450wm/ne2pi/ne2pi2011/ne2pi201100001/158603194-anonymes-vektorsymbol-inkognito-zeichen-datenschutzkonzept-menschlicher-kopf-mit-glitch-gesicht-illu.jpg?ver=6',
        ),
      ).then((value) {
        emit(CreateUserSuccessState());
      }).catchError((error) {
        emit(CreateUserErrorState(error.toString()));
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }

  IconData suffix2 = Icons.visibility_outlined;
  bool isPassword2 = true;

  void changePasswordVisibility2() {
    isPassword2 = !isPassword2;
    suffix2 =
        isPassword2 ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState2());
  }
}
