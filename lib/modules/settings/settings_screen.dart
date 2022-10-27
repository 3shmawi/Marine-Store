import 'package:beauty_supplies_project/admin_screens/admin_settings_screen/admin_settings_screen.dart';
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
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 10,
                bottom: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Icon(
                      IconBroken.profile,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mohamed Ashmawi',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            Auth().currentUser!.email ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DefaultButton(
                      title: 'My Orders',
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.adminLayout,
                          (route) => false,
                        );
                      },
                      subTitle: 'Already have 3 orders',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                        'Logout',
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
}
