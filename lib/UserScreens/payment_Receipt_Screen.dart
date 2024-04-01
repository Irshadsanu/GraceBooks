import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grace_book_latest/UserScreens/book_details_screen.dart';
import 'package:grace_book_latest/UserScreens/user_home_bottom_navigation_bar.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import '../Model/store_book_model.dart';
import '../Providers/MainProvider.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final String userId;
  final String userName;
  final String userPhone;
  final String orderCount;
  final String amount;
  StoreBookModel storeBookList;
  PaymentReceiptScreen(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userPhone,
      required this.orderCount,
      required this.amount,
      required this.storeBookList});
  GlobalKey previewContainer = GlobalKey();
  int originalSize = 800;

  @override
  Widget build(BuildContext context) {
    print("msmmmmmmsmc " + orderCount.toString());
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        callNextReplacement(
            UserHomeBottom(
              loginStatus: "Logged",
              userDocId: userId,
              userName: userName,
              userPhone: userPhone,
              index: 0,
            ),
            context);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper:
                    CustomShape(), // this is my own class which extendsCustomClipper
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 150,
                  color: cl1B4341,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 34,
                        width: 70,
                        child: Image.asset("assets/logo.png"),
                      ),
                    ],
                  ),
                ),
              ),
              RepaintBoundary(
                key: previewContainer,
                child: Container(
                  // height: height / 1.9,
                  width: width / 1.113134328358209,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/INVOICE.png"),
                          fit: BoxFit.fill)),
                  child: Consumer<MainProvider>(
                      builder: (context90, value29, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'INVOICE',
                                  style: TextStyle(
                                    color: Color(0xFF404040),
                                    fontSize: 38,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.20,
                                  ),
                                ),
                                Image.asset(
                                  "assets/splash logo.png",
                                  scale: 3,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value29.donorName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  value29.donorNumber,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Order date: ${dateTime(value29.donateTime)}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 83,
                            ),
                            Image.asset("assets/invoiceline.png"),
                            SizedBox(
                              height: height / 83,
                            ),
                            orderCount == "Multi"
                                ? Consumer<MainProvider>(
                                builder: (context28, mainPro, child) {
                                  return Container(
                                    constraints: const BoxConstraints(
                                        minHeight: 1
                                    ),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount:
                                        mainPro.selectCardItemList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var item =
                                          mainPro.selectCardItemList[index];
                                          return Row(
                                            children: [
                                              Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Text("${index + 1}.")),
                                              Flexible(
                                                  flex: 9,
                                                  fit: FlexFit.tight,
                                                  child: Align(
                                                      alignment:
                                                      Alignment.centerLeft,
                                                      child:
                                                      Text(item.bookName))),
                                              Flexible(
                                                flex: 2,
                                                fit: FlexFit.tight,
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  child: Text(
                                                    '₹${item.offerPrice}',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  );
                                })
                                : Row(
                              children: [
                                const Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text("${1}.")),
                                Flexible(
                                    flex: 9,
                                    fit: FlexFit.tight,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(storeBookList.bookName))),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '₹${storeBookList.bookOfferPrice}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 83,
                            ),
                            Image.asset("assets/invoiceline.png"),
                            SizedBox(
                              height: height / 83,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 10,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    'Tax',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'PoppinsRegular',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '00.0',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'PoppinsRegular',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 153,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  flex: 10,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    'Total Amount ',
                                    style: TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 14,
                                      fontFamily: "PoppinsRegular",
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.70,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      orderCount == "Multi"
                                          ? '₹$amount'
                                          : '₹${storeBookList.bookOfferPrice}',
                                      style: const TextStyle(
                                        color: Color(0xFF404040),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 83,
                            ),
                            Image.asset("assets/invoiceline.png"),
                            SizedBox(
                              height: height / 83,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value29.donorApp,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  uploadDatee(
                                    value29.donateTime,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 34.33333333333333,
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Thank you',
                                style: TextStyle(
                                  color: Color(0xFF404040),
                                  fontSize: 24,
                                  fontFamily: 'Port Lligat Slab',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.72,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 34.33333333333333,
                            ),
                          ],
                        );
                      }),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      callNextReplacement(
                          UserHomeBottom(
                            loginStatus: 'Logged',
                            userDocId: userId,
                            userName: userName,
                            userPhone: userPhone,
                            index: 0,
                          ),
                          context);
                    },
                    child: Container(
                      width: 100,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(-1.00, -0.01),
                          end: Alignment(1, 0.01),
                          colors: [Color(0xFF1B4341), Color(0xFF285D5B)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(49),
                        ),
                      ),
                      child: const Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Consumer<MainProvider>(builder: (context92, value89, child) {
                    return InkWell(
                      onTap: () async {
                        final Uint8List? imageBytes =
                            await value89.captureScreenshot(previewContainer);
                        // Save the image to the device's gallery
                        await value89.saveImageToGallery(imageBytes!);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(' Saved to gallery!'),
                          backgroundColor: (Colors.black),
                        ));
                      },
                      child: Container(
                        width: 100,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-1.00, -0.01),
                            end: Alignment(1, 0.01),
                            colors: [Color(0xFF1B4341), Color(0xFF285D5B)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(49),
                          ),
                        ),
                        child: const Text(
                          'Download',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }),
                  InkWell(
                    onTap: () {
                      ShareFilesAndScreenshotWidgets().shareScreenshot(
                          previewContainer,
                          originalSize,
                          "Title",
                          "Name.png",
                          "image/png",
                          text: "");
                    },
                    child: Container(
                      width: 100,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(-1.00, -0.01),
                          end: Alignment(1, 0.01),
                          colors: [Color(0xFF1B4341), Color(0xFF285D5B)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(49),
                        ),
                      ),
                      child: const Text(
                        'Share',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15,bottom: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Ordered Book",textAlign: TextAlign.left,style: TextStyle(
                      color: Color(0xFF353535),
                      fontSize: 14,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w700,

                    ),)),
              ),
              orderCount == "Multi"
                  ? Consumer<MainProvider>(
                  builder: (context21, mainPro, child) {
                    return Container(
                      constraints: const BoxConstraints(
                          minHeight: 1
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: mainPro.selectCardItemList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            var item = mainPro.selectCardItemList[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 5),
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
                                leading: Container(
                                  width: 48,
                                  height: 71,
                                  decoration: BoxDecoration(
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
                                trailing: Text(
                                  '₹${item.offerPrice}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  })
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
                  leading: Container(
                    width: 48,
                    height: 71,
                    decoration: BoxDecoration(
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
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),

            ],
          ),
        ),
      ),
    );
  }

  String dateTime(String date) {
    var startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    date = DateFormat("dd-MM-yy").format(startDate);
    return date;
  }

  String uploadDate(String date) {
    var startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    date = DateFormat("dd-MM-yy  hh:mm a").format(startDate);
    return date;
  }
}
