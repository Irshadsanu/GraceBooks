import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grace_book_latest/AdminScreens/admin_bottomNavigation_screen.dart';
import 'package:grace_book_latest/Providers/login_provider.dart';
import 'package:grace_book_latest/UserScreens/userMenuScreen.dart';
import 'package:grace_book_latest/UserScreens/reading_finish_Screen.dart';
import 'package:grace_book_latest/buynow%20screen.dart';
import 'package:grace_book_latest/constants/my_colors.dart';
import 'package:provider/provider.dart';

import 'AdminScreens/addBook _Screen.dart';
import 'AdminScreens/add_advertisement.dart';
import 'AdminScreens/addStafff_screen.dart';
import 'AdminScreens/add_E_Book_Screen.dart';
import 'AdminScreens/add_carousel_page.dart';
import 'AdminScreens/admin_book_details_Page.dart';
import 'AdminScreens/admin_delivery_details.dart';
import 'AdminScreens/admin_bottomNavigation_screen.dart';
import 'AdminScreens/admin_home_screen.dart';
import 'AdminScreens/payment_report_screen.dart';
import 'AdminScreens/staffList_Screen.dart';
import 'Payment _gateway/paymentSuccess_Screen.dart';
import 'Providers/AdminProvider.dart';
import 'Providers/MainProvider.dart';
import 'Providers/timer_provider.dart';
import 'Providers/widget_provider.dart';
import 'UserScreens/home_Screen.dart';
import 'UserScreens/book_details_screen.dart';
import 'UserScreens/my_LibraryScreen.dart';
import 'UserScreens/payment_Receipt_Screen.dart';
import 'UserScreens/splash_screen.dart';
import 'UserScreens/user_DeliveryDetailsScreen.dart';
import 'UserScreens/user_SearchScreen.dart';
import 'UserScreens/user_home_bottom_navigation_bar.dart';
import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>MainProvider(),),
        ChangeNotifierProvider(create: (context)=>LoginProvider(),),
        ChangeNotifierProvider(create: (context)=>TimeProvider(),),
        ChangeNotifierProvider(create: (context)=>AdminProvider(),),
        ChangeNotifierProvider(create: (context)=>WidgetProvider(),),

      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'GRACE BOOK',
        theme: ThemeData(canvasColor: clWhite,focusColor: clWhite,
          colorScheme: ColorScheme.fromSeed(seedColor: clWhite,background: clWhite),
          useMaterial3: true,
        ),

        // home:   BookDetailsScreen(rating: 4,),
        // home: const  MylibraryScreen(),
        // home: LoginScreen(),
        // home: const AdminBookDetails(),
        // home: const AddBookScreen(),
        // home:AddAdvertisement(),
        // home: AddEbookScreen(),
        // home: SplashScreen(),
        // home: PaymentSuccessScreen(),
        // home:AdminDeliveryDetails()
        home: SplashScreen(),
      ),
    );
  }
}


