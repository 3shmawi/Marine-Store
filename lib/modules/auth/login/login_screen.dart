import 'package:beauty_supplies_project/modules/auth/login/cubit/login_cubit.dart';
import 'package:beauty_supplies_project/shared/color/colors.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/layout_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../utilities/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
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
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Welcome Back',
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 25.0),
                          child: DefaultFormField(
                            textInputType: TextInputType.emailAddress,
                            textEditingController: emailController,
                            prefixIcon: Icons.mail_outline_outlined,
                            hintText: 'Email Address...',
                          ),
                        ),
                        BlocBuilder<LoginCubit, LoginStates>(
                          builder: (context, state) {
                            return DefaultFormField(
                              isPassword:
                              context.read<LoginCubit>().isPassword,
                              textInputType: TextInputType.visiblePassword,
                              textEditingController: passwordController,
                              prefixIcon: IconBroken.lock,
                              hintText: 'Password...',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<LoginCubit>()
                                      .changePasswordVisibility();
                                },
                                icon: Icon(
                                  context.read<LoginCubit>().suffix,
                                  size: 20,
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 35, 0),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'forgot password ?!',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.deepPurple),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        BlocConsumer<LoginCubit, LoginStates>(
                          listener: (context, state) {
                            listenerCondition(state, context);
                          },
                          builder: (context, state) {
                            return state is LoginLoadingState
                                ? Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            )
                                : DefaultElevatedButton(
                              onPressed: () {
                                context.read<LoginCubit>().userLogin(
                                  email: emailController.text,
                                  password:
                                  passwordController.text,
                                );
                              },
                              header: Text(
                                'LOGIN',
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
                                'Don\'t have account ?! ',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.registerPageRoute);
                                },
                                child: Text(
                                  'Create One',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    color: Colors.deepPurple,
                                  ),
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

  void listenerCondition(LoginStates state, BuildContext context) {
    if (state is LoginSuccessState) {
      showToast(text: 'Login Success', color: Colors.green);
      navigateAndFinish(context, const LayoutScreen());
    } else if (state is LoginErrorState) {
      showToast(text: getErrorMessage(state.error), color: Colors.red);
    }
  }
}
