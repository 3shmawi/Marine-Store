part of 'sign_up_cubit.dart';

abstract class SignUpStates {}

class SignUpInitial extends SignUpStates {}

class CreateLoadingState extends SignUpStates {}


class CreateUserSuccessState extends SignUpStates {}

class CreateUserErrorState extends SignUpStates {}

class RegisterChangePasswordVisibilityState extends SignUpStates {}
