import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/user_home_bottom_navigation_bar.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../Model/store_book_model.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import 'book_details_screen.dart';

class UserDeliveryDetailsScreen extends StatelessWidget {
  final String loginStatus;
  final String userDocId;
  final String userName;
  final String userPhone;
  final String orderCount;
  final String amount;
  StoreBookModel storeBookList;

  UserDeliveryDetailsScreen(
      {Key? key,
      required this.loginStatus,
      required this.userDocId,
      required this.userName,
      required this.userPhone,
      required this.orderCount,
      required this.amount,
        required this.storeBookList,


      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    MainProvider mainProvier =
        Provider.of<MainProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        MainProvider mainProvider =
            Provider.of<MainProvider>(context, listen: false);
        if (mainProvider.paymentScreen) {
          mainProvider.paymentScreenNavigation(false);
        } else {
          callNextReplacement(
              UserHomeBottom(
                loginStatus: loginStatus,
                userDocId: userDocId, userName: userName, userPhone: userPhone, index: 0,
              ),
              context);
        }
      },
      child: Scaffold(
        backgroundColor: clF0F0F0,
        body: Stack(
          children: [
            SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(
                    height: 150,
                  ),
                 orderCount=="Multi"?
                  Consumer<MainProvider>(
                    builder: (context21,mainPro,child) {
                      return Container(
                     constraints: const BoxConstraints(
                       minHeight: 1
                     ),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: mainPro.selectCardItemList.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context,index){
                            var item=mainPro.selectCardItemList[index];
                              return    Container(
                                margin: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21.28),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 11.77,
                                      offset: Offset(0, 3.92),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: ListTile(
                                  leading:Container(
                                    width: 48,
                                    height: 71,
                                    decoration:  BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(item.bookImage),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    item.bookName,
                                    // "ndddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: 0.70,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.authorName,
                                    style: const TextStyle(
                                      color: Color(0xFF5A5A5A),
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                      letterSpacing: 0.55,
                                    ),
                                  ),
                                  trailing:  Text(
                                    '₹${item.offerPrice}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),);

                            }

                        ),
                      );
                    }
                  )
                  : Container(
                margin: const EdgeInsets.symmetric(horizontal: 13),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.28),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 11.77,
                      offset: Offset(0, 3.92),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: ListTile(
                  leading:Container(
                    width: 48,
                    height: 71,
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(storeBookList.bookPhoto),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  title: Text(
                    storeBookList.bookName,
                    // "ndddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color(0xFF353535),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 0.70,
                    ),
                  ),
                  subtitle: Text(
                    storeBookList.authorName,
                    style: const TextStyle(
                      color: Color(0xFF5A5A5A),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1,
                      letterSpacing: 0.55,
                    ),
                  ),
                  trailing: Text(
                    '₹${storeBookList.bookOfferPrice}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),),
                  SizedBox(
                    height: height / 83,
                  ),
                ],
              ),
            ),

            Consumer<MainProvider>(builder: (context, mainPro2, _) {
              return mainPro2.paymentScreen
                  ? PaymentMethodeSheet(
                      width: width,
                      height: height,
                      userId: userDocId,
                      userName: userName,
                      userPhone: userPhone, orderCount: orderCount,storeBookList: storeBookList, amount: amount,
                    )
                  : DeliveryDetails(
                      width: width,
                      height: height,
                      userId: userDocId,
                      userName: userName,
                      storeBookList: storeBookList,
                    );
            }),
            ClipPath(
              clipper: CustomShape(),
              // this is my own class which extendsCustomClipper
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 150,
                color: cl1B4341,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<MainProvider>(builder: (context, mainPro3, _) {
                      return InkWell(
                          onTap: () {
                            if (mainPro3.paymentScreen) {
                              mainPro3.paymentScreenNavigation(false);
                            } else {
                              callNextReplacement(
                                  UserHomeBottom(
                                    loginStatus: loginStatus,
                                    userDocId: userDocId, userName: userName, userPhone: userPhone, index: 0,
                                  ),
                                  context);
                            }
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_left,
                            color: clFFFFFF,
                            size: 25,
                          ));
                    }),
                    const Spacer(),
                    SizedBox(
                      height: 34,
                      width: 70,
                      child: Image.asset("assets/logo.png"),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomSheetWidget(context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      // height: 100,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Delivery Details",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "PoppinsRegular",
                    fontWeight: FontWeight.w700,
                    color: cl404040),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name
                Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,
                      color: cl7A7A7A),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Asif Muahmmed",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w500,
                      color: cl404040),
                ),

                SizedBox(
                  height: 10,
                ),

                //Delivery Location
                Text(
                  "Delivery Location",
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,
                      color: cl7A7A7A),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Malappuram Kottappadi",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w500,
                      color: cl404040),
                ),

                SizedBox(
                  height: 10,
                ),

                //Mobile Number
                Text(
                  "Mobile Number",
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,
                      color: cl7A7A7A),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "8086 569 585",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w500,
                      color: cl404040),
                ),

                SizedBox(
                  height: 10,
                ),

                //Address
                Text(
                  "Address",
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,
                      color: cl7A7A7A),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Chalil House malappuram , Kotappadi",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w500,
                      color: cl404040),
                ),

                SizedBox(
                  height: 10,
                ),

                //Address
                Text(
                  "State",
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,
                      color: cl7A7A7A),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Kerala",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w500,
                      color: cl404040),
                ),

                SizedBox(
                  height: 10,
                ),

                //District
                Text(
                  "District",
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,
                      color: cl7A7A7A),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Malappuram",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w500,
                      color: cl404040),
                ),

                SizedBox(
                  height: 10,
                ),

                //Post Office
                Text(
                  "Post office",
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,
                      color: cl7A7A7A),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Malappuram",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w500,
                      color: cl404040),
                ),

                SizedBox(
                  height: 10,
                ),

                //Pin
                Text(
                  "Pin",
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,
                      color: cl7A7A7A),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "676514",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w500,
                      color: cl404040),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DeliveryDetails extends StatelessWidget {
  DeliveryDetails({
    super.key,
    required this.width,
    required this.height,
    required this.userId,
    required this.userName,
    required this.storeBookList,
  });

  final double width;
  final double height;
  final String userId;
  final String userName;
  StoreBookModel storeBookList;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: .75,
      snap: true,
      snapAnimationDuration: const Duration(milliseconds: 500),
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              left: width / 27.66666666666667,
              right: width / 27.66666666666667,
              bottom: width / 27.66666666666667,
            ),
            child: Column(
              children: [
                Container(
                  width: width,
                  decoration: const BoxDecoration(
                      color: clWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(58),
                        topRight: Radius.circular(58),
                      )),
                  // height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height / 42,
                        ),
                        const Center(
                          child: Text(
                            "Delivery Details",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "PoppinsRegular",
                                fontWeight: FontWeight.w700,
                                color: cl404040),
                          ),
                        ),
                        SizedBox(
                          height: height / 28.13333333333333,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<MainProvider>(
                                builder: (context, mainPro, _) {
                              return DeliverDetailsTextForm(
                                hint: 'Name',
                                color: mainPro.nameColor,
                                controller: mainPro.orderNameController,
                              );
                            }),
                            SizedBox(
                              height: height / 84,
                            ),
                            Consumer<MainProvider>(
                                builder: (context, mainPro, _) {
                              return DeliverDetailsTextForm(
                                hint: 'Location',
                                color: mainPro.deliveryLocationColor,
                                controller: mainPro.orderLocationController,
                              );
                            }),
                            SizedBox(
                              height: height / 84,
                            ),
                            Consumer<MainProvider>(
                                builder: (context, mainPro, _) {
                              return DeliverDetailsNumberTextForm(
                                hint: 'Mobile Number',
                                color: mainPro.mobileColor,
                                inputCount: 10,
                                controller: mainPro.orderPhoneController,
                              );
                            }),
                            SizedBox(
                              height: height / 84,
                            ),
                            Consumer<MainProvider>(
                                builder: (context, mainPro, _) {
                              return DeliverDetailsTextForm(
                                hint: 'Address',
                                color: mainPro.addressColor,
                                controller: mainPro.orderAddressController,
                              );
                            }),
                            SizedBox(
                              height: height / 84,
                            ),
                            Consumer<MainProvider>(
                                builder: (context, mainPro, _) {
                              return DeliverDetailsNumberTextForm(
                                hint: 'Pin',
                                color: mainPro.pinColor,
                                inputCount: 6,
                                controller: mainPro.orderPinCodeController,
                              );
                            }),
                            SizedBox(
                              height: height / 84,
                            ),
                            Consumer<MainProvider>(
                                builder: (context, mainPro, _) {
                              return DeliverDetailsTextForm(
                                hint: 'Post office',
                                color: mainPro.postOfficeColor,
                                controller: mainPro.orderPostOfficeController,
                              );
                            }),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Consumer<MainProvider>(
                                builder: (context, mainProButton, _) {
                              return mainProButton.attemptButton?const Center(child: CircularProgressIndicator()):ElevatedButton(
                                onPressed: () async {
                                  mainProButton.notifyAttemptButton();
                                  bool pincodeStatus = await mainProButton
                                      .getPinCodeApiToAttempt(mainProButton
                                          .orderPinCodeController.text);
                                  if (pincodeStatus) {
                                    mainProButton.transactionID.text =
                                        DateTime.now()
                                                .microsecondsSinceEpoch
                                                .toString() +
                                            generateRandomString(2);
                                    mainProButton.attempt(
                                      mainProButton.transactionID.text,
                                      userId,
                                      storeBookList.bookId,
                                      storeBookList.bookName,
                                      storeBookList.bookCategory,
                                      storeBookList.bookCategoryId,
                                      storeBookList.bookOfferPrice,
                                    );
                                    mainProButton.textFieldColorChange("");
                                    mainProButton.paymentScreenNavigation(true);
                                  } else {
                                    mainProButton. attemptButton=false;
                                    mainProButton.notifyListeners();
                                    showSnackBarFun(context) {
                                      SnackBar snackBar = SnackBar(duration: const Duration(seconds: 3),
                                        content: const Text('Please enter a valid PIN code',
                                            style: TextStyle(fontSize: 15)),
                                        backgroundColor: Colors.indigo,
                                        dismissDirection: DismissDirection.up,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).size.height - 150,
                                            left: 10,
                                            right: 10),
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                    showSnackBarFun(context);
                                    /// top snackBar needed
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: EdgeInsets.zero, // and this
                                ),
                                child: Container(
                                  height: height / 22.21052631578947,
                                  width: width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(49),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF285E5B),
                                        Color(0xFF1B4341),
                                      ], // Example gradient colors
                                    ),
                                  ),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: clWhite),
                                  ),
                                ),
                              );
                            }),
                            SizedBox(
                              height: height / 84,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentMethodeSheet extends StatelessWidget {
  PaymentMethodeSheet({
    super.key,
    required this.width,
    required this.height,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.orderCount,
    required this.amount,
    required this.storeBookList,
  });

  final double width;
  final double height;
  final String userId;
  final String userName;
  final String userPhone;
  final String orderCount;
  final String amount;
  StoreBookModel storeBookList;

  List<String> image = [
    "assets/svg/google-pay 1.svg",
    "assets/svg/paytm.svg",
    "assets/svg/phonepe-logo-icon 1.svg",
  ];
  List<String> text = [
    "Google Pay",
    "Paytm",
    "Phone Pay",
  ];
  List<String> button = [
    "GPay",
    "Paytm",
    "PhonePe",
  ];

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvier =
        Provider.of<MainProvider>(context, listen: false);

    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: EdgeInsets.only(
          left: width / 27.66666666666667,
          right: width / 27.66666666666667,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                decoration: const BoxDecoration(
                    color: clWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(58),
                      topRight: Radius.circular(58),
                    )),
                // height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height / 42.2,
                      ),
                      const Center(
                        child: Text(
                          "Use Payment Method",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "PoppinsRegular",
                              fontWeight: FontWeight.w700,
                              color: cl404040),
                        ),
                      ),
                      SizedBox(
                        height: height / 28.13333333333333,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context98, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  String payAmount = "1";
                                  // payAmount=amount;

                                  mainProvier.upiIntent(
                                    context,
                                    payAmount,
                                    userName,
                                    userPhone,
                                    userId,
                                    button[index],
                                    mainProvier.appVersion.toString(),
                                    orderCount,
                                    storeBookList,
                                  );
                                },
                                child: Container(
                                  height: 53,
                                  width: width,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: clDAF8F6,
                                    borderRadius: BorderRadius.circular(57),
                                    image: const DecorationImage(
                                      image:
                                          AssetImage("assets/pmBackground.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.black12,
                                        child: Center(
                                          child: SvgPicture.asset(image[index],
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        text[index],
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: "PoppinsRegular",
                                            fontWeight: FontWeight.w900,
                                            color: clBlack),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: height / 42.2,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: 'By continued you agree to our ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              fontFamily: "PoppinsRegular",
                              color: cl9B9B9B),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Terms & Conditions ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                  fontFamily: "PoppinsRegular",
                                  color: cl026E31),
                            ),
                            TextSpan(
                              text: 'and \n',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                  fontFamily: "PoppinsRegular",
                                  color: cl9B9B9B),
                            ),
                            TextSpan(
                              text: 'acknowledge that you have ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                  fontFamily: "PoppinsRegular",
                                  color: cl9B9B9B),
                            ),
                            TextSpan(
                              text: 'read our privacy policy',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                  fontFamily: "PoppinsRegular",
                                  color: cl026E31),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 42.2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String generateRandomString(int length) {
  final random = Random();
  const availableChars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  final randomString = List.generate(length,
      (index) => availableChars[random.nextInt(availableChars.length)]).join();
  return randomString;
}
