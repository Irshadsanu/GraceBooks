import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grace_book_latest/AdminScreens/admin_home_screen.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/UserScreens/user_home_bottom_navigation_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AdminScreens/admin_bottomNavigation_screen.dart';
import '../AdminScreens/admin_login_screen.dart';
import '../Providers/MainProvider.dart';
import '../Providers/login_provider.dart';
import '../constants/my_functions.dart';
import 'home_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;

  Future<void> localDB() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    localDB();

    super.initState();
    MainProvider mainProvier =
        Provider.of<MainProvider>(context, listen: false);
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    Timer(const Duration(seconds: 3), () async {
      print("sedgkweygjaj111");

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;
      var user = prefs.getString("appwrite_token");
      // print("djdjjdjjdjdj "+prefs.getString("phone_number")!);

      mainProvier.lockApp();
      mainProvier.fetchHomeStoreBook("SPLASH","");
      mainProvier.fetchHomeEBook("SPLASH","");
      mainProvier.fetchHomeCarouselImage();
      mainProvier.fetchAdvertisementImage();
      adminProvider.fetchCategoryList();
      mainProvier.fetchUserOrders();
      if(packageName=="com.spine.gracebookAdmin"){
        print("sedgkweygjaj2222");

        if(user==null){
          callNext(const LoginScreenAdmin(), context);

        }else{
          print("sedgkweygjaj33333");

          final FirebaseFirestore db = FirebaseFirestore.instance;
          print(prefs.getString("phone_number"));
          adminProvider.fetchSalesReport();
          print("sedgkweygjaj");

          db
              .collection("USERS")
              .where("PHONE", isEqualTo: prefs.getString("phone_number"))
              .get()
              .then((value) async {
            Map<dynamic, dynamic> adminMap = value.docs.first.data();
            callNextReplacement(
                AdminBottomNavigationScreen(userId: adminMap["ID"], userName: adminMap["NAME"], userNumber: adminMap["PHONE"], userType: adminMap["TYPE"],),
                context);
          });
        }
      }
      else{
        mainProvier.fetchSearchBookDetails();
        if (user == null) {
          callNextReplacement(
              const UserHomeBottom(
                loginStatus: 'Not_Logged', userDocId: '', userName: '', userPhone: '', index: 0,
              ),
              context);
        }
        else {
          final FirebaseFirestore db = FirebaseFirestore.instance;
          print("hdhdhhdhdhhd "+prefs.getString("phone_number")!);
          db
              .collection("USERS")
              .where("PHONE", isEqualTo: prefs.getString("phone_number"))
              .get()
              .then((value) async {
            Map<dynamic, dynamic> userMap = value.docs.first.data();

            mainProvier.fetchUserDetails(userMap["ID"]);
            mainProvier.fetchSavedLibrary(userMap["ID"]);
            mainProvier.fetchAddToCart(userMap["ID"]);

mainProvier.getSharedData();


            callNextReplacement(
                UserHomeBottom(loginStatus: 'Logged', userDocId: userMap["ID"], userName: userMap["NAME"], userPhone: userMap["PHONE"], index: 0,), context);
          });

        }
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image.asset(
      "assets/splash logo.png",
      fit: BoxFit.fill,
    )));
  }
}
