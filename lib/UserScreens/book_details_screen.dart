import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/pdf_view_screen.dart';
import 'package:grace_book_latest/UserScreens/reading_finish_Screen.dart';
import 'package:grace_book_latest/UserScreens/user_DeliveryDetailsScreen.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:grace_book_latest/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/store_book_model.dart';
import '../constants/favButton.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    super.key,
    required this.fav,
    required this.tag,
    required this.image,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.bookId,
    required this.from,
    this.item,
    required this.loginStatus,
    required this.cart, required this.price, required this.offerPrice, required this.bookName,
  required this.authorName,
  required this.bookCategory,
  required this.bookCategoryId,
  });

  final bool fav;
  final bool cart;
  final Object tag;

  final String image;
  final String userId;
  final String userName;
  final String userPhone;
  final String bookId;
  final String from;
  final StoreBookModel? item;
  final String loginStatus;
  final String price;
  final String offerPrice;
  final String bookName;
  final String authorName;
  final String bookCategory;
  final String bookCategoryId;


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: cl1B4341,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height / 25.672727272727273,
                    ),
                    Hero(
                      transitionOnUserGestures: true,
                      tag: tag,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.fill)),
                        height: height / 1.58567,
                        width: width,
                      ),
                    )
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.4,
                maxChildSize: 1,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: width / 21.66666666666667,
                              right: width / 21.66666666666667,
                              top: width / 26.375),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(26),
                                topLeft: Radius.circular(26)),
                            color: cl1B4341,
                          ),
                          child: Consumer<MainProvider>(
                              builder: (context88, value89, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: width / 1.287128712871287,
                                  child: Text(
                                    value89.ebookName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: clWhite,
                                        fontFamily: "PoppinsRegular",
                                        fontSize: width / 24.375,
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        letterSpacing: 1),
                                  ),
                                ),
                                SizedBox(
                                  height: height / 46.88888888888889,
                                ),
                                Text(
                                  "By ${value89.ebookAuthor}",
                                  style: TextStyle(
                                      color: clWhite,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: width / 27.85714285714286,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1),
                                ),
                                SizedBox(
                                  height: height / 46.88888888888889,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width / 4.534883720930233,
                                      height: height / 22.21052631578947,
                                      decoration: BoxDecoration(
                                          color: cl153332,
                                          borderRadius:
                                              BorderRadius.circular(51)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        from == "BOOKS"
                                            ? "₹ ${offerPrice}"
                                            : "E-Book",
                                        style: TextStyle(
                                          color: clWhite,
                                          fontSize: width / 24.375,
                                          // fontFamily: "PoppinsRegular",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/svg/bestseller.svg',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 88.88888888888889,
                                ),
                                from == "BOOKS"
                                    ? Text(
                                        "Free Delivery",
                                        style: TextStyle(
                                            color: clCBCBCB,
                                            fontFamily: "PoppinsRegular",
                                            fontSize: width / 43.33333333333333,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1),
                                      )
                                    : const SizedBox(),
                                from == "BOOKS"
                                    ? Text(
                                        "Price Include GST",
                                        style: TextStyle(
                                            color: clCBCBCB,
                                            fontFamily: "PoppinsRegular",
                                            fontSize: width / 43.33333333333333,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1),
                                      )
                                    : const SizedBox(),
                                SizedBox(
                                  height: height / 68.88888888888889,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Consumer<MainProvider>(
                                        builder: (context, va, _) {
                                      return Flexible(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              print(loginStatus);
                                              if(loginStatus=="Logged"){

                                              if (from != "BOOKS") {
                                                if (!va.savedList
                                                        .contains(userId) &&
                                                    !va.libraryBool) {
                                                  va.saveToLibrary(
                                                      userId,
                                                      bookId,
                                                      bookName,
                                                      authorName,
                                                      image,
                                                      va.ebookDescription,
                                                      bookCategory,
                                                      bookCategoryId
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Saved To Library"),
                                                    duration: Duration(
                                                        milliseconds: 3000),
                                                  ));
                                                }
                                              }else{

                                                if(!va.cartBool&&!va.cartList.contains(userId)){
                                                  va.addToCart(userId, bookId, authorName,
                                                      bookName,
                                                      image,
                                                      va.ebookDescription,price,offerPrice,bookCategory,bookCategoryId);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Item successfully added to your cart"),
                                                        duration: Duration(
                                                            milliseconds: 3000),
                                                      ));

                                                }
                                              }

                                              }else{
                                                callNext(LoginScreen(), context);
                                              }
                                            },
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                      from == "BOOKS"
                                                          ? "assets/svg/addcartlogo.svg"
                                                          : "assets/svg/save_to_library.svg",
                                                      colorFilter: from !=
                                                                      "BOOKS" &&
                                                                  (va.savedList
                                                                          .contains(
                                                                              userId) ||
                                                                      va
                                                                          .libraryBool) ||
                                                              from == "BOOKS" &&
                                                                  (va.cartList.contains(userId) ||
                                                                      va
                                                                          .cartBool)
                                                          ? const ColorFilter.mode(
                                                              clE8AD14,
                                                              BlendMode.srcIn)
                                                          : const ColorFilter.mode(
                                                              clWhite,
                                                              BlendMode.srcIn)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    from == "BOOKS"
                                                        ? "Add to Cart"
                                                        : "Save to Library",
                                                    style: TextStyle(
                                                        color: clWhite,
                                                        fontFamily:
                                                            "PoppinsRegular",
                                                        fontSize: width /
                                                            43.33333333333333,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                    }),
                                    Flexible(
                                        flex: 1,
                                        child: Consumer<MainProvider>(
                                            builder: (context, val, _) {
                                          return Column(
                                            children: [
                                              Heart(
                                                  userId: userId,
                                                  bookId: bookId,
                                                  fav: val.pubFavoriteList.contains(userId)?true:fav,
                                                  from: from,
                                                  bookName: from == "BOOK"
                                                      ? bookName
                                                      : val.ebookName,
                                                  authorName: from == "BOOK"
                                                      ? authorName
                                                      : val.ebookAuthor,
                                                  bookImage: image,
                                                  price: from == "BOOKS"
                                                      ? price
                                                      : "",
                                                  offerPrice: from == "BOOKS"
                                                      ? offerPrice
                                                      : "", categoryId: bookCategoryId,),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Favorite",
                                                style: TextStyle(
                                                    color: clWhite,
                                                    fontFamily:
                                                        "PoppinsRegular",
                                                    fontSize: width /
                                                        43.33333333333333,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1),
                                              )
                                            ],
                                          );
                                        })),
                                    Flexible(
                                      flex: 1,
                                      child: Consumer<MainProvider>(
                                          builder: (context, main, _) {
                                        return TextButton(
                                          onPressed: () {
                                            if(loginStatus=="Logged"){
                                            if (from == "E-BOOKS") {
                                              callNext(
                                                  PDFViewer(
                                                    pdfLink: main.ebookPdfUrl,
                                                    currentPage: 0, bookName: bookName, authorName: authorName, bookImage: image, userId: userId,userName: userName,userPhone: userPhone, loginStatus: loginStatus,
                                                  ),
                                                  context);
                                            } else {
                                              main.orderLocationController.clear();
                                              main.paymentScreen=false;
                                              callNext(UserDeliveryDetailsScreen(
                                                    loginStatus: loginStatus,
                                                    userDocId: userId,

                                                    userName: userName,
                                                    userPhone: userPhone, storeBookList: item!, orderCount: 'Single', amount: item!.bookOfferPrice,
                                                  ), context);
                                            }}else{
                                              callNext(const LoginScreen(), context);
                                            }
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(clE8AD14),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(clWhite),
                                          ),
                                          child: Text(
                                            from == "E-BOOKS"
                                                ? 'Read Now'
                                                : "Buy Now",
                                            style: TextStyle(
                                                color: cl303030,
                                                fontFamily: "PoppinsRegular",
                                                fontSize: width / 32.5,
                                                fontWeight: FontWeight.w700,
                                                // height: 1,
                                                letterSpacing: 1),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 108.88888888888889,
                                ),
                                const Divider(
                                  color: cl5F5F5F,
                                ),
                                SizedBox(
                                  height: height / 35.16666666666667,
                                ),
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    color: clCBCBCB,
                                    fontFamily: "PoppinsRegular",
                                    fontSize: width / 27.85714285714286,
                                    fontWeight: FontWeight.w700,
                                    // letterSpacing: 1
                                  ),
                                ),
                                SizedBox(
                                  height: height / 108.88888888888889,
                                ),
                                Text(
                                  value89.ebookDescription,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: clCBCBCB,
                                    fontFamily: "PoppinsRegular",
                                    fontSize: width / 30,
                                    fontWeight: FontWeight.w500,
                                    // letterSpacing: 1
                                  ),
                                ),
                                SizedBox(
                                  height: height / 35.16666666666667,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: cl153332),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "About The Book",
                                        style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: width / 27.85714285714286,
                                          fontWeight: FontWeight.w700,
                                          // letterSpacing: 1
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 84.4,
                                      ),
                                      AboutBookDetails(
                                        headText: 'Print Length ',
                                        text: '${value89.ebookPage} Pages',
                                      ),
                                      SizedBox(
                                        height: height / 106,
                                      ),

                                      AboutBookDetails(
                                        headText: 'Language',
                                        text: value89.ebookLanguage,
                                      ),
                                      SizedBox(
                                        height: height / 106,
                                      ),

                                      AboutBookDetails(
                                        headText: 'Publisher',
                                        text: value89.ebookPublisher,
                                      ),
                                      SizedBox(
                                        height: height / 106,
                                      ),

                                      AboutBookDetails(
                                        headText: 'Publication date ',
                                        text: uploadDatee(value89
                                            .ebookPublicationDate
                                            .toString()),
                                      ),
                                      SizedBox(
                                        height: height / 106,
                                      ),

                                      //  AboutBookDetails(
                                      //   headText: 'Dimensions',
                                      //   text: value89.ebo+'*160',
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height / 35.16666666666667,
                                ),
                                Text(
                                  "Author Name",
                                  style: TextStyle(
                                    color: clCBCBCB,
                                    fontFamily: "PoppinsRegular",
                                    fontSize: width / 27.85714285714286,
                                    fontWeight: FontWeight.w700,
                                    // letterSpacing: 1
                                  ),
                                ),
                                SizedBox(
                                  height: height / 90.88888888888889,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      child: value89.ebookAuthor.isNotEmpty
                                          ? Text(
                                              value89
                                                  .ebookAuthor.characters.first
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: cl1B4341,
                                                fontFamily: "PoppinsRegular",
                                                fontSize: width / 27,
                                                fontWeight: FontWeight.w500,
                                                // letterSpacing: 1
                                              ),
                                            )
                                          : const SizedBox(),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      value89.ebookAuthor,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: clCBCBCB,
                                        fontFamily: "PoppinsRegular",
                                        fontSize: width / 27,
                                        fontWeight: FontWeight.w500,
                                        // letterSpacing: 1
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 31.16666666666667,
                                ),
                              ],
                            );
                          }),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: width / 21.66666666666667,
                            right: width / 21.66666666666667,
                          ),
                          width: width,
                          color: clWhite,
                          child: Column(
                            children: [
                              SizedBox(
                                height: height / 30.58536585365854,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Suggestions for you ',
                                    style: TextStyle(
                                        color: cl1B4341,
                                        fontFamily: "PoppinsRegular",
                                        fontSize: width / 24.375,
                                        fontWeight: FontWeight.w700,
                                        // height: 1,
                                        letterSpacing: 1),
                                  ),
                                  SizedBox(
                                    height: height / 50.58536585365854,
                                  ),
                                  // Container(
                                  // color: Colors.yellow,
                                  //   height: height / 3.57857142857143,
                                  //   child:
                                  Consumer<MainProvider>(
                                    builder: (context28,mainPro,child) {
                                      return GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisExtent: 107,
                                            childAspectRatio: 1,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 12,
                                            crossAxisCount: 4,
                                          ),
                                          itemCount: mainPro.suggestionBookList.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            StoreBookModel item= mainPro.suggestionBookList[index];
                                            return InkWell(
                                              onTap: (){
                                                if (loginStatus == "Logged") {
                                                  mainPro.fetchBookDetailsByItem(item.bookId);
                                                  mainPro.libraryBool=false;
                                                  mainPro.cartBool=false;
                                                  callNextReplacement(
                                                      BookDetailsScreen(
                                                        fav: item.favoriteList.contains(userId)
                                                            ? true
                                                            : false,
                                                        image: item.bookPhoto,
                                                        tag: index,
                                                        userId: userId,
                                                        bookId: item.bookId,
                                                        from: 'BOOKS', item: mainPro.suggestionBookList[index], loginStatus: loginStatus, userName: userName, userPhone:userPhone,
                                                        cart: item.addCartList.contains(userId)?true:false, price: item.bookPrice, offerPrice: item.bookOfferPrice,
                                                        bookName: item.bookName,authorName: item.authorName, bookCategory: item.bookCategory, bookCategoryId: item.bookCategoryId,
                                                      ),
                                                      context);

                                                } else {
                                                  callNext(
                                                      const LoginScreen(), context);
                                                }
                                              },
                                              child: Container(
                                                height: height / 7.44,
                                                width: width / 5.2,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(image: NetworkImage(item.bookPhoto),fit:BoxFit.cover),
                                                    borderRadius: BorderRadius.circular(15)),
                                              ),
                                            );
                                          });
                                    }
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height / 50.58536585365854,
                              ),
                              SizedBox(
                                height: height / 30,
                              ),
                              Consumer<MainProvider>(
                                  builder: (context, val1, _) {
                                return val1.advertisementList.isNotEmpty
                                    ? Container(
                                        height: height / 5.341772151898734,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    val1.advertisementList[0]),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadius.circular(11)),
                                      )
                                    : const SizedBox();
                              }),
                              SizedBox(
                                height: height / 30,
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       'Categories',
                              //       style: TextStyle(
                              //           color: cl1B4341,
                              //           fontFamily: "PoppinsRegular",
                              //           fontSize: width / 24.375,
                              //           fontWeight: FontWeight.w700,
                              //           // height: 1,
                              //           letterSpacing: 1),
                              //     ),
                              //     SizedBox(
                              //       height: height / 60.58536585365854,
                              //     ),
                              //     GridView.builder(
                              //         physics:
                              //             const NeverScrollableScrollPhysics(),
                              //         shrinkWrap: true,
                              //         gridDelegate:
                              //             const SliverGridDelegateWithFixedCrossAxisCount(
                              //           mainAxisExtent: 69,
                              //           childAspectRatio: 1,
                              //           crossAxisSpacing: 12,
                              //           mainAxisSpacing: 12,
                              //           crossAxisCount: 3,
                              //         ),
                              //         itemCount: 9,
                              //         itemBuilder:
                              //             (BuildContext context, int index) {
                              //           return Container(
                              //             height: height / 13.3968253968254,
                              //             width: width / 3.513513513513514,
                              //             decoration: BoxDecoration(
                              //                 color: index < 3 || index >= 6
                              //                     ? clAFD6D4
                              //                     : clAFBCD6,
                              //                 image: const DecorationImage(
                              //                     image: AssetImage(
                              //                         "assets/categoryBg.png"),
                              //                     fit: BoxFit.fill),
                              //                 borderRadius:
                              //                     BorderRadius.circular(15)),
                              //             alignment: Alignment.center,
                              //             child: Text(
                              //               "Fazil",
                              //               style: TextStyle(
                              //                   color: clBlack,
                              //                   fontFamily: "PoppinsRegular",
                              //                   fontSize: width / 39,
                              //                   fontWeight: FontWeight.w700,
                              //                   // height: 1,
                              //                   letterSpacing: 1),
                              //             ),
                              //           );
                              //         }),
                              //     SizedBox(
                              //       height: height / 50.58536585365854,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: 110,
                  color: cl1B4341,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: height / 84.4),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leadingWidth: 70,
                    scrolledUnderElevation: 0,
                    leading: InkWell(
                      onTap: () {
                        finish(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: clWhite,
                      ),
                    ),
                    title: Image.asset(
                      "assets/logo.png",
                      scale: 2,
                    ),
                    centerTitle: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutBookDetails extends StatelessWidget {
  final String headText;
  final String text;

  const AboutBookDetails({
    super.key,
    required this.headText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: Text(
              headText,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: clCBCBCB,
                fontFamily: "PoppinsRegular",
                fontSize: width / 30,
                fontWeight: FontWeight.w400,
                // letterSpacing: 1
              ),
            )),
        Expanded(
            flex: 1,
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: clCBCBCB,
                fontFamily: "PoppinsRegular",
                fontSize: width / 30,
                fontWeight: FontWeight.w400,
                // letterSpacing: 1
              ),
            ))
      ],
    );
  }
}



String uploadDatee(String date) {
  var startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
  date = DateFormat("dd-MM-yy  hh:mm a").format(startDate);
  return date;
}
