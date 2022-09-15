import 'package:beauty_supplies_project/modules/auth/login/cubit/login_cubit.dart';
import 'package:beauty_supplies_project/modules/auth/register/register_screen.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/app_routes.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showToast(text: 'Create Success', color: Colors.green);
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
                            DefaultFormField(
                              textInputType: TextInputType.visiblePassword,
                              textEditingController: passwordController,
                              prefixIcon: IconBroken.lock,
                              hintText: 'Password...',
                            ),
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: InkWell(
                                  onTap: () {
                                    context.read<LoginCubit>().userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                  },
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
                            DefaultElevatedButton(
                              onPressed: () {},
                              header: Text(
                                'LOGIN',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 8, 38, 20.0),
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
                                          context, SignUpScreen.route);
                                    },
                                    child: Text(
                                      'Create One',
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
