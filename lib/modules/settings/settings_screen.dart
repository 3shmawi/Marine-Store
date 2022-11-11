import 'package:beauty_supplies_project/admin_screens/admin_settings_screen/admin_settings_screen.dart';
import 'package:beauty_supplies_project/database/remote_database_controller.dart';
import 'package:beauty_supplies_project/models/user.dart';
import 'package:beauty_supplies_project/modules/auth/register/register_screen.dart';
import 'package:beauty_supplies_project/services/cache_helper_services.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:beauty_supplies_project/utilities/enums.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_auth_services.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId =CacheHelper.getData(key: SharedKeys.id);
    return StreamBuilder<UserModel>(
      stream: FireStoreDataBase().getUserDataStream(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var userData = snapshot.data;
          if (userData == null) {
            return const Text('');
          }
          return Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Profile',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const DefaultUserNameAndEmail(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DefaultButton(
                            title: 'My Orders',
                            onTap: () {},
                            subTitle: 'Already have 3 orders',
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(userData.isAdmin)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: DefaultElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.adminLayout,
                          );
                        },
                        header: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(IconBroken.profile),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Admin Layout',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: DefaultElevatedButton(
                        onPressed: () {
                          //Auth().currentUser!.delete();

                          Auth().logout().then((value) {
                            showToast(text: 'Logout Success', color: Colors.green);
                            CacheHelper.removeData(key: SharedKeys.id);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                                    (route) => false);
                          }).catchError((error) {
                            showToast(text: 'Logout Failed', color: Colors.red);
                          });
                        },
                        header: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(IconBroken.logout),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Logout Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: DefaultElevatedButton(
                        color: Colors.red,
                        onPressed: () {
                          Auth().currentUser!.delete().then((value) {
                            showToast(
                                text: 'Delete Account Success',
                                color: Colors.green);
                            CacheHelper.removeData(key: SharedKeys.id);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                                    (route) => false);
                          }).catchError((error) {
                            showToast(
                                text: 'Delete Account Failed', color: Colors.red);
                          });
                        },
                        header: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              IconBroken.delete,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Delete Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
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
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },

    );
  }
}
