part of 'sign_up_cubit.dart';

abstract class SignUpStates {}

class SignUpInitial extends SignUpStates {}

class CreateLoadingState extends SignUpStates {}


class CreateUserSuccessState extends SignUpStates {}

class CreateUserErrorState extends SignUpStates {
  final String error;

  CreateUserErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends SignUpStates {}
class RegisterChangePasswordVisibilityState2 extends SignUpStates {}
