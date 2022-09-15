import 'package:beauty_supplies_project/modules/auth/login/login_screen.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  static const route = '/signUp';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var rePasswordController = TextEditingController();
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            showToast(text: 'Register Success', color: Colors.green);
            Navigator.pushNamed(context, AppRoutes.landingPageRoute);
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              child: DefaultFormField(
                                textInputType: TextInputType.emailAddress,
                                textEditingController: emailController,
                                prefixIcon: Icons.mail_outline_outlined,
                                hintText: 'Email Address...',
                              ),
                            ),
                            DefaultFormField(
                              textInputType: TextInputType.visiblePassword,
                              textEditingController: passwordController,
                              prefixIcon: IconBroken.lock,
                              hintText: 'Password...',
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.visibility,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            DefaultFormField(
                              textInputType: TextInputType.visiblePassword,
                              textEditingController: rePasswordController,
                              prefixIcon: IconBroken.password,
                              hintText: 'Confirm Password...',
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.visibility,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            DefaultElevatedButton(
                              onPressed: () {
                                context.read<SignUpCubit>().userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              },
                              header: Text(
                                'SIGNUP',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account ?! ',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, LoginScreen.route);
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
          );
        },
      ),
    );
  }
}
