
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/icon/icons.dart';


class AdminSettingScreen extends StatelessWidget {
  const AdminSettingScreen({Key? key}) : super(key: key);

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
            const DefaultUserNameAndEmail(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DefaultButton(
                      title: 'My Orders',
                      onTap: () {
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   AppRoutes.landingPageRoute,
                        //   (route) => false,
                        // );
                      },
                      subTitle: 'Already have 3 orders',
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10.0),
            //   child: Align(
            //     alignment: AlignmentDirectional.center,
            //     child: DefaultElevatedButton(
            //       onPressed: () {
            //         //Auth().currentUser!.delete();
            //
            //         // Auth().logout().then((value) {
            //         //   showToast(text: 'Logout Success', color: Colors.green);
            //         //   CacheHelper.removeData(key: SharedKeys.id);
            //         //   Navigator.pushAndRemoveUntil(
            //         //       context,
            //         //       MaterialPageRoute(
            //         //         builder: (context) => SignUpScreen(),
            //         //       ),
            //         //       (route) => false);
            //         // }).catchError((error) {
            //         //   showToast(text: 'Logout Failed', color: Colors.red);
            //         // });
            //       },
            //       header: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const Icon(IconBroken.logout),
            //           const SizedBox(
            //             width: 5,
            //           ),
            //           Text(
            //             'Logout',
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .button!
            //                 .copyWith(color: Colors.white),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final String title;
  final String subTitle;
  final GestureTapCallback? onTap;

  const DefaultButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                IconBroken.arrowRight2,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
