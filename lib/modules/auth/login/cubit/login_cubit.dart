import 'package:beauty_supplies_project/services/firebase_auth_services.dart';
import 'package:beauty_supplies_project/shared/shared_prefrences/shared_prefrences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    Auth().loginWithEmailAndPassword(email, password).then((value) {
      CacheHelper.saveData(key: SharedKeys.id, value: value!.uid);
      emit(LoginSuccessState(value.uid));
      if (kDebugMode) {
        print('Login Success');
      }
    }).catchError((error) {
      emit(LoginErrorState(
        error.toString(),
      ));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}
