import 'package:beauty_supplies_project/layout/usr_layout/usr_layout_screen.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/color/colors.dart';
import '../../../shared/components/constants.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blueAccent,
                Colors.lightBlue,
                Colors.lightBlueAccent
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'REGISTER',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Register now to browse our hot offers',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        DefaultFormField(
                          textInputType: TextInputType.name,
                          textEditingController: nameController,
                          prefixIcon: IconBroken.profile,
                          hintText: 'User Name...',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: DefaultFormField(
                            textInputType: TextInputType.emailAddress,
                            textEditingController: emailController,
                            prefixIcon: Icons.mail_outline_outlined,
                            hintText: 'Email Address...',
                          ),
                        ),
                        BlocBuilder<SignUpCubit, SignUpStates>(
                          builder: (context, state) {
                            return DefaultFormField(
                              isPassword:
                                  context.read<SignUpCubit>().isPassword,
                              textInputType: TextInputType.visiblePassword,
                              textEditingController: passwordController,
                              prefixIcon: IconBroken.lock,
                              hintText: 'Password...',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<SignUpCubit>()
                                      .changePasswordVisibility();
                                },
                                icon: Icon(
                                  context.read<SignUpCubit>().suffix,
                                  size: 20,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        BlocBuilder<SignUpCubit, SignUpStates>(
                          builder: (context, state) {
                            return DefaultFormField(
                              isPassword:
                                  context.read<SignUpCubit>().isPassword2,
                              textInputType: TextInputType.visiblePassword,
                              textEditingController: rePasswordController,
                              prefixIcon: IconBroken.password,
                              hintText: 'Confirm Password...',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<SignUpCubit>()
                                      .changePasswordVisibility2();
                                },
                                icon: Icon(
                                  context.read<SignUpCubit>().suffix2,
                                  size: 20,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        BlocConsumer<SignUpCubit, SignUpStates>(
                          listener: (context, state) {
                            listenerCondition(state, context);
                          },
                          builder: (context, state) {
                            return state is CreateLoadingState
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: defaultColor,
                                    ),
                                  )
                                : DefaultElevatedButton(
                                    onPressed: () {
                                      if (passwordController.text !=
                                          rePasswordController.text) {
                                        showToast(
                                            text:
                                                'Confirm Password not equal Password',
                                            color: Colors.red);
                                      } else {
                                        context
                                            .read<SignUpCubit>()
                                            .userRegister(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                      }
                                    },
                                    header: Text(
                                      'SIGNUP',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 38, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Already have an account?! ',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.loginPageRoute);
                                },
                                child: Text(
                                  'login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.deepPurple),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void listenerCondition(SignUpStates state, BuildContext context) {
    if (state is CreateUserSuccessState) {
      showToast(text: 'Register Success', color: Colors.green);
      navigateAndFinish(context, const UsrLayoutScreen());
    } else if (state is CreateUserErrorState) {
      showToast(text: getErrorMessage(state.error), color: Colors.red);
    }
  }
}
