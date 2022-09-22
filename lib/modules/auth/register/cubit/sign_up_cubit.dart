import 'package:beauty_supplies_project/services/firebase_auth_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/cache_helper_services.dart';
import '../../../../utilities/enums.dart';


part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(CreateLoadingState());

    Auth().signUpWithEmailAndPassword(email, password).then((value) {
      emit(CreateUserSuccessState());
      CacheHelper.saveData(key: SharedKeys.id, value: value!.uid);
      if (kDebugMode) {
        print('Create User Success');
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CreateUserErrorState());
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
}
