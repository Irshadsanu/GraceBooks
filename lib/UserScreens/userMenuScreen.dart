import 'package:flutter/material.dart';
import 'package:grace_book_latest/Providers/login_provider.dart';
import 'package:grace_book_latest/Providers/widget_provider.dart';
import 'package:grace_book_latest/UserScreens/user_home_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/MainProvider.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../login_screen.dart';
import 'home_Screen.dart';

class UserMenu extends StatelessWidget {
  final String loginStatus;
  final String userDocId;
  final String userName;
  final String userPhone;

  const UserMenu(
      {super.key,
      required this.loginStatus,
      required this.userDocId,
      required this.userName,
      required this.userPhone});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: width,
          height: height,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ClipPath(
              clipper: CustomShape(),
              // this is my own class which extendsCustomClipper
              child: Container(
                height: 130,
                color: cl1B4341,
                alignment: Alignment.bottomCenter,
                child: AppBar(
                    leading: GestureDetector(
                      onTap: () {
                        finish(context);
                      },
                      child: Center(
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Icon(Icons.close_outlined),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    scrolledUnderElevation: 0,
                    elevation: 0,
                    centerTitle: true,
                    title: Image.asset(
                      "assets/logo.png",
                      scale: 2,
                    )),
              ),
            ),
            const Text(
              "Menu",
              style: TextStyle(
                  color: Color(0xFF1B4341),
                  fontFamily: "PoppinsRegular",
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 25,
            ),
            MenuOptionsWidget(
              ontap: () {
                if (loginStatus == "Logged") {
callNext(UserHomeBottom(loginStatus: loginStatus, userDocId: userDocId, userName: userName, userPhone: userPhone, index: 3,), context);
                } else {
                  callNext(const LoginScreen(), context);
                }
              },
              width: width,
              height: height,
              icon: const Icon(Icons.shopping_bag_outlined),
              text: 'My Orders',
            ),
            SizedBox(
              height: height / 83.4,
            ),
            Consumer<MainProvider>(builder: (context, mai, _) {
              return Consumer<WidgetProvider>(builder: (context, wid, _) {
                  return MenuOptionsWidget(
                    ontap: () {
                      if (loginStatus == "Logged") {
                        mai.personalDetailsEdit = false;
                        mai.deliveryDetailsEdit = false;
                        mai.fileImage = null;
                        wid.bottomSheet(context, height, width, userDocId);
                      } else {
                        callNext(const LoginScreen(), context);
                      }
                    },
                    width: width,
                    height: height,
                    icon: const Icon(Icons.account_circle_outlined),
                    text: 'Profile',
                  );
                }
              );
            }),
            SizedBox(
              height: height / 83.4,
            ),
            MenuOptionsWidget(
              width: width,
              height: height,
              icon: const Icon(Icons.privacy_tip_outlined),
              text: 'Terms & Conditions',
            ),
            SizedBox(
              height: height / 83.4,
            ),
            MenuOptionsWidget(
              width: width,
              height: height,
              icon: const Icon(Icons.info_outline),
              text: 'About',
            ),
            SizedBox(
              height: height / 83.4,
            ),
            MenuOptionsWidget(
              width: width,
              height: height,
              icon: Image.asset(
                "assets/Frame 483 (1).png",
                scale: 2,
              ),
              text: 'Support',
            ),
            SizedBox(
              height: height / 83.4,
            ),
           loginStatus=="Logged"? Consumer<LoginProvider>(builder: (context, logPro, _) {
              return MenuOptionsWidget(
                ontap: () {
                  logPro.logOutAlert(context);
                },
                width: width,
                height: height,
                icon: Image.asset(
                  "assets/Frame 484 (1).png",
                  scale: 3,
                ),
                text: 'Sign out',
              );
            }):const SizedBox()
          ]),
        ));
  }


}

class MenuOptionsWidget extends StatelessWidget {
  final double width;
  final double height;
  final Function()? ontap;
  final Widget icon;
  final String text;

  const MenuOptionsWidget({
    super.key,
    required this.width,
    required this.height,
    this.ontap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 45,
        width: width / 1.209876543209877,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x3FBDBDBD),
              blurRadius: 10.90,
              offset: Offset(2, 4),
              spreadRadius: -1,
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            icon,
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
