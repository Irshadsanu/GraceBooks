import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grace_book_latest/AdminScreens/admin_home_screen.dart';
import 'package:grace_book_latest/AdminScreens/admin_login_screen.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/UserScreens/user_home_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AdminScreens/admin_bottomNavigation_screen.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../login_screen.dart';
import 'MainProvider.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> userAuthorized(
      String from, String? phoneNumber, var token, BuildContext context) async {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    try {
      var phone = phoneNumber!.substring(3, 13);

      db
          .collection("USERS")
          .where("PHONE", isEqualTo: phone)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          print("data exist");
          Map<dynamic, dynamic> userMap = value.docs.first.data();

          mainProvider.fetchUserDetails(userMap["ID"]);
          mainProvider.fetchSavedLibrary(userMap["ID"]);
          mainProvider.fetchAddToCart(userMap["ID"]);
          callNextReplacement(UserHomeBottom(loginStatus: "Logged", userDocId: userMap["ID"], userName: userMap["NAME"], userPhone: userMap["PHONE"], index: 0,), context);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('appwrite_token', token);
          prefs.setString('phone_number', phone);
        } else {
          callNextReplacement(const LoginScreen(), context);
        }
      });
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Sorry , Some Error Occurred'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    notifyListeners();
  }
  Future<void> adminAuthorized(
      String from, String? phoneNumber, var token, BuildContext context) async {

    try {
      var phone = phoneNumber!.substring(3, 13);

      db
          .collection("USERS")
          .where("PHONE", isEqualTo: phone)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          print("data exist");
          Map<dynamic, dynamic> adminMap = value.docs.first.data();

          callNextReplacement(
              AdminBottomNavigationScreen(userId: adminMap["ID"], userName: adminMap["NAME"], userNumber: adminMap["PHONE"], userType: adminMap["TYPE"],),
              context);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('appwrite_token', token);
          prefs.setString('phone_number', phone);
        } else {
          callNextReplacement(const LoginScreenAdmin(), context);
        }
      });
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Sorry , Some Error Occurred'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    notifyListeners();
  }

  logOutAlert(BuildContext context, ) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert =AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Text(
        "Do you want to Logout",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: Consumer<MainProvider>(
          builder: (context,value,child) {
            return
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: cl1B4341),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextButton(
                            child: const Text('No', style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              finish(context);
                            }),
                      ),
                      Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color:cl1B4341),
                          color: cl1B4341,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Consumer<MainProvider>(
                          builder: (context,main,_) {
                            return TextButton(
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.clear();
                                  main.getSharedData();
                                  main.userProfileImage = "";
                                  callNextReplacement( const UserHomeBottom(loginStatus: "", userDocId: "", userName: "", userPhone: "", index: 0,), context);
                                  // finish(context);
                                });
                          }
                        ),
                      ),
                    ],
                  ),
                ],
              );
          }
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(surfaceTintColor: clWhite,
            backgroundColor: clWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            content: SizedBox(
              height: 83,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Close the App\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Jaldi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'Do you want to Exit?',
                          style: TextStyle(
                            color: Color(0xFF5C5C5C),
                            fontSize: 12,
                            fontFamily: 'Jaldi',
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 39,
                        width: 110,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x1C000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffFFFCF8)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(60)))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child:   const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFF1B4341),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 39,
                        width: 110,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF1B4341)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(60)))),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child:const Center(
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

}
