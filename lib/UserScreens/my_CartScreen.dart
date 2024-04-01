import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_book_latest/Model/cart_Model.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/book_details_screen.dart';
import 'package:grace_book_latest/UserScreens/userMenuScreen.dart';
import 'package:grace_book_latest/UserScreens/user_DeliveryDetailsScreen.dart';
import 'package:grace_book_latest/UserScreens/user_FavoriteScreen.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Model/book_Model.dart';
import '../Model/store_book_model.dart';
import '../Providers/widget_provider.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import '../login_screen.dart';

class MyCartScreen extends StatefulWidget {
  final String userDocId;
  final String loginStatus;
  final String userName;
  final String userPhone;

  const MyCartScreen(
      {Key? key,
      required this.userDocId,
      required this.loginStatus,
      required this.userName,
      required this.userPhone})
      : super(key: key);

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  // final List<TextDto> orderList = [
  //   // TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
  // ];
  //
  // final List<TextDto> shippedList = [
  //   // TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
  // ];
  //
  // final List<TextDto> deliveredList = [
  //   // TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  // ];

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    final double width = queryData.size.width;
    final double height = queryData.size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            Consumer<MainProvider>(builder: (context31, mainPro, child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: mainPro.selectCardItemList.isNotEmpty
                ? InkWell(
                    onTap: () {
                      double payAmount = mainPro.selectCardItemList.fold(
                          0,
                          (pV, element) =>
                              pV + double.parse(element.offerPrice));
                      print("payAmount            : $payAmount");
                      if (widget.loginStatus == "Logged") {
                        mainPro.orderLocationController.clear();
                        mainPro.paymentScreen = false;
                        callNext(
                            UserDeliveryDetailsScreen(
                              loginStatus: widget.loginStatus,
                              userDocId: widget.userDocId,
                              userName: widget.userName,
                              userPhone: widget.userPhone,
                              storeBookList: mainPro.filterHomeScreenStoreBookList[0],
                              orderCount: 'Multi',
                              amount: payAmount.toString(),
                            ),
                            context);
                      } else {
                        callNext(const LoginScreen(), context);
                      }
                    },
                    child: Container(
                        width: width / 1.1123,
                        height: 39,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE8AD14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(54),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              text: 'Purchase ',
                              style: const TextStyle(
                                color: Color(0xFF1B4341),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                              children: [
                                TextSpan(
                                  text: mainPro.selectCardItemList.length
                                      .toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF1B4341),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ]),
                        )),
                  )
                : const SizedBox(),
          );
        }),
        body: Column(
          children: [
            ClipPath(
              clipper: CustomShape(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 130,
                color: cl1B4341,
                child: AppBar(
                  scrolledUnderElevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: cl1B4341,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          callNext(
                              UserMenu(
                                loginStatus: widget.loginStatus,
                                userDocId: widget.userDocId,
                                userName: widget.userName,
                                userPhone: widget.userPhone,
                              ),
                              context);
                        },
                        child: Container(
                          height: 24,
                          width: width / 5.5,
                          decoration: BoxDecoration(
                              color: clF7F7F7.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(79),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.25),
                                  // Shadow color
                                  blurRadius: 6,
                                  // Spread of the shadow
                                  offset: const Offset(
                                      0, 4), // Offset of the shadow
                                ),
                              ]),
                          child: Row(
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                decoration: const BoxDecoration(
                                    color: clWhite, shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.grid_view,
                                  color: cl1A3F3D,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                "Menu",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  color: clFFFFFF,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 34,
                        width: 70,
                        child: Image.asset("assets/logo.png"),
                      ),
                      Row(
                        children: [
                          Consumer<MainProvider>(builder: (context, val1, _) {
                            return GestureDetector(
                              onTap: () {
                                if (widget.loginStatus == "Logged") {
                                  val1.fetchFavorite(widget.userDocId);
                                }
                                callNext(
                                    UserFavouriteScreen(
                                      userDocId: widget.userDocId,
                                    ),
                                    context);
                              },
                              child: Container(
                                height: 27,
                                width: 27,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        // Shadow color
                                        blurRadius: 6,
                                        // Spread of the shadow
                                        offset: const Offset(
                                            0, 4), // Offset of the shadow
                                      ),
                                    ],
                                    color: clF7F7F7.withOpacity(0.2),
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.favorite,
                                  color: clE8AD14,
                                  size: 15,
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            width: 5,
                          ),
                          Consumer<MainProvider>(builder: (context, mai, _) {
                            return Consumer<WidgetProvider>(
                                builder: (context, wid, _) {
                              return GestureDetector(
                                onTap: () {
                                  if (widget.loginStatus == "Logged") {
                                    mai.personalDetailsEdit = false;
                                    mai.deliveryDetailsEdit = false;
                                    mai.fileImage = null;
                                    wid.bottomSheet(context, height, width,
                                        widget.userDocId);
                                  } else {
                                    callNext(const LoginScreen(), context);
                                  }
                                },
                                child: mai.userProfileImage != ""
                                    ? Container(
                                        height: 27,
                                        width: 27,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    mai.userProfileImage),
                                                fit: BoxFit.fill),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                // Shadow color
                                                blurRadius: 6,
                                                // Spread of the shadow
                                                offset: const Offset(0,
                                                    4), // Offset of the shadow
                                              ),
                                            ],
                                            color: clF7F7F7.withOpacity(0.2),
                                            shape: BoxShape.circle),
                                      )
                                    : Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          // Shadow color
                                          blurRadius: 6,
                                          // Spread of the shadow
                                          offset: const Offset(
                                              0, 4), // Offset of the shadow
                                        ),
                                      ],
                                      color: clWhite,
                                      shape: BoxShape.circle),
                                  child: Icon(Icons.person,color:cl1B4341 ,size: 17),
                                ),
                              );
                            });
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const TabBar(
              unselectedLabelColor: cl1B4341,
              labelColor: cl1B4341,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'PoppinsRegular',
                  fontSize: 12),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                color: cl1B4341,
                width: 4,
              )),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined),
                      SizedBox(width: 2),
                      // Adjust the spacing between icon and text as needed
                      Text("Cart"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      SizedBox(width: 2),
                      // Adjust the spacing between icon and text as needed
                      Text("My Orders"),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Cart
                  Consumer<MainProvider>(builder: (context, va, _) {
                    return va.allCartList.isNotEmpty
                        ? ListView.builder(
                            itemCount: va.allCartList.length,
                            itemBuilder: (context, index) {
                              return buildCartItem(
                                  width, height, va.allCartList[index], index);
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/empty_cart.svg',
                                height: 157,
                                width: 113,
                              ),
                              const Text(
                                'Your shopping bag is empty.\nStart Shopping.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.60,
                                ),
                              ),
                            ],
                          );
                  }),

                  // Tab 2: My Orders
                  Consumer<MainProvider>(builder: (context92, value52, child) {
                    return value52.myOrdersList.isNotEmpty
                        ? ListView.builder(
                            itemCount: value52.myOrdersList.length,
                            itemBuilder: (context, index) {
                              MyOrderModel item = value52.myOrdersList[index];
                              return buildOrderItem(width, item, context);
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/empty_cart.svg',
                                height: 157,
                                width: 113,
                              ),
                              const Text(
                                "You haven't placed any orders yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.60,
                                ),
                              ),
                            ],
                          );
                    ;
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(
      double width, double height, CartModelClass item, int index) {
    return Consumer<MainProvider>(builder: (context, mainPro, _) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
        child: GestureDetector(
          onTap: () {
            mainPro.toggleCheckbox(index);
          },
          child: Hero(
            tag: index,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: clBDBDBD40.withOpacity(0.25),
                    blurRadius: 10.0,
                    spreadRadius: 0.0, // Spread radius set to 0
                    offset: const Offset(2.0, 4.0), // Adjust offset as needed
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width / 5.24,
                      height: height / 8.34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: clCDCDCD,
                          image: DecorationImage(
                              image: NetworkImage(item.bookImage),
                              fit: BoxFit.fill)),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 8,
                                  child: Text(
                                    item.bookName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: cl353535,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 14),
                                  ),
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.shopping_cart_outlined,
                                          color: Colors.amber,
                                        ),
                                        Consumer<MainProvider>(
                                            builder: (context, va, _) {
                                          return SizedBox(
                                            height: 22,
                                            width: 22,
                                            child: PopupMenuButton(
                                              padding: EdgeInsets.zero,
                                              color: Colors.red,
                                              iconSize: 25,
                                              itemBuilder: (context) {
                                                return [
                                                  const PopupMenuItem(
                                                    height: 10,
                                                    padding: EdgeInsets.all(5),
                                                    value: 0,
                                                    child: Text(
                                                      'Remove',
                                                      style: TextStyle(
                                                          color: clWhite,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "PoppinsRegular"),
                                                    ),
                                                  ),
                                                ];
                                              },
                                              onSelected: (value) {
                                                va.removeCart(widget.userDocId,
                                                    item.bookId, item.cartId);
                                              },
                                            ),
                                          );
                                        }),
                                      ],
                                    ))
                              ],
                            ),
                            Text(
                              item.authorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: cl5B5B5B,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              "\u{20B9}${item.offerPrice}",
                              style: const TextStyle(
                                color: Color(0xFF353535),
                                fontSize: 11,
                                // fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                // letterSpacing: 0.55,
                              ),
                            ),
                            Text(
                              "\u{20B9}${item.price}",
                              style: const TextStyle(
                                color: Color(0xFFA7A7A7),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Consumer<MainProvider>(
                                    builder: (context, mainPro1, _) {
                                  return GestureDetector(
                                    onTap: () {
                                      mainPro1
                                          .fetchBookDetailsByItem(item.bookId);
                                      mainPro1.libraryBool = false;
                                      mainPro1.cartBool = false;
                                      callNext(
                                          BookDetailsScreen(
                                            fav: false,
                                            tag: index,
                                            image: item.bookImage,
                                            userId: widget.userDocId,
                                            userName: widget.userName,
                                            userPhone: widget.userPhone,
                                            bookId: item.bookId,
                                            from: "BOOKS",
                                            loginStatus: widget.loginStatus,
                                            cart: true,
                                            price: item.price,
                                            offerPrice: item.offerPrice,
                                            bookName: item.bookName,
                                            authorName: item.authorName,
                                            bookCategory: item.category,
                                            bookCategoryId: item.categoryId,
                                          ),
                                          context);
                                    },
                                    child: const Text(
                                      'Details',
                                      style: TextStyle(
                                        color: Color(0xFF0044F6),
                                        fontSize: 9,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                        letterSpacing: 0.45,
                                      ),
                                    ),
                                  );
                                }),
                                CustomGradientCheckbox(
                                  isChecked: item.select,
                                  index: index,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildOrderItem(
      double width, MyOrderModel item, BuildContext context1) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Consumer<MainProvider>(builder: (context12, mainPro, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: item.items.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: clBDBDBD40.withOpacity(0.25),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset: const Offset(2.0, 4.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 38,
                          height: 51,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: clCDCDCD,
                              // color: Colors.red,
                              image: DecorationImage(
                                  image:
                                      NetworkImage(item.items[index].itemImage),
                                  fit: BoxFit.fill)),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * .5,
                                  child: Text(
                                    item.items[index].itemName,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: cl353535,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 13),
                                  ),
                                ),
                                SizedBox(
                                  width: width * .75,
                                  child: Text(
                                    item.items[index].authorName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: cl5B5B5B,
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: ShapeDecoration(
              color: const Color(0xFFF2F2F2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            height: 180,
            child: Consumer<MainProvider>(builder: (context29, mainPro, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 10, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 11,
                              height: 11,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF1B4341),
                                  shape: BoxShape.circle),
                            ),
                            const Text(
                              ' Order Placed',
                              style: TextStyle(
                                color: Color(0xFF1B4341),
                                fontSize: 11,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0.09,
                                letterSpacing: 0.55,
                              ),
                            ),
                          ],
                        ),
                        item.placedDate != ""
                            ? Text(
                                dateTime(item.placedDate),
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1b4341),
                                  height: 11 / 11,
                                ),
                                textAlign: TextAlign.right,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: VerticalDottedLine(
                      height: 40,
                      color: Color(0xFF1B4341),
                      strokeWidth: 1.0,
                      gap: 2.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, bottom: 8, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 11,
                              height: 11,
                              decoration: BoxDecoration(
                                  color: item.orderStatus != "PLACED"
                                      ? const Color(0xFF1B4341)
                                      : Colors.grey,
                                  shape: BoxShape.circle),
                            ),
                            Text(
                              ' Shipped',
                              style: TextStyle(
                                color: item.orderStatus != "PLACED"
                                    ? const Color(0xFF1B4341)
                                    : Colors.grey,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0.09,
                                letterSpacing: 0.55,
                              ),
                            ),
                          ],
                        ),
                        item.dispatchedDate != ""
                            ? Text(
                                dateTime(item.dispatchedDate),
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1b4341),
                                  height: 11 / 11,
                                ),
                                textAlign: TextAlign.right,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: VerticalDottedLine(
                      height: 40,
                      color: item.orderStatus != "PLACED"
                          ? const Color(0xFF1B4341)
                          : Colors.grey,
                      strokeWidth: 1.0,
                      gap: 2.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 11,
                              height: 11,
                              decoration: BoxDecoration(
                                  color: item.orderStatus != "DELIVERED"
                                      ? Colors.grey
                                      : const Color(0xFF1B4341),
                                  shape: BoxShape.circle),
                            ),
                            Text(
                              ' Delivered',
                              style: TextStyle(
                                color: item.orderStatus != "DELIVERED"
                                    ? Colors.grey
                                    : const Color(0xFF1B4341),
                                fontSize: 11,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0.09,
                                letterSpacing: 0.55,
                              ),
                            ),
                          ],
                        ),
                        item.deliveredDate != ""
                            ? Text(
                                dateTime(item.deliveredDate),
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1b4341),
                                  height: 11 / 11,
                                ),
                                textAlign: TextAlign.right,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          // Container(
          //   width: width,
          //   // height: 124,
          //   decoration: BoxDecoration(
          //     color: clF2F2F2,
          //     borderRadius: BorderRadius.circular(6),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 8.0,bottom: 8,right: 8,left: 8),
          //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         SizedBox(
          //           width: 250,
          //           // height: 500,
          //           child: OrderTracker(
          //             status: Status.order, // Change status to delivered
          //             activeColor: Colors.green,
          //             inActiveColor: Colors.grey[300],
          //             // orderTitleAndDateList: [], // Empty list for order status
          //             // shippedTitleAndDateList: [], // Empty list for shipped status
          //             // deliveredTitleAndDateList: deliveredList,
          //           ),
          //         ),
          //         // Text('12-Jun-2024',style: TextStyle(fontSize: 14,fontFamily: 'PoppinsRegular',fontWeight: FontWeight.w400,color: cl1B4341),)
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

String dateTime(String date) {
  var startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
  date = DateFormat("dd-MMM-yy").format(startDate);
  return date;
}

class VerticalDottedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double strokeWidth;
  final double gap;

  const VerticalDottedLine({
    Key? key,
    this.height = 100.0,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(strokeWidth, height),
      painter: _VerticalDottedLinePainter(color, strokeWidth, gap),
    );
  }
}

class _VerticalDottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _VerticalDottedLinePainter(this.color, this.strokeWidth, this.gap);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double dashWidth = 5;
    final double dashSpace = gap;

    double startY = 0.0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomGradientCheckbox extends StatelessWidget {
  final bool isChecked;
  final int index;

  const CustomGradientCheckbox({
    super.key,
    required this.isChecked,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, val, _) {
      return GestureDetector(
        onTap: () {
          val.toggleCheckbox(index);
        },
        child: Container(
          width: 20,
          height: 20,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: isChecked
                ? const LinearGradient(
                    begin: Alignment(-0.63, -0.78),
                    end: Alignment(0.63, 0.78),
                    colors: [Color(0xFFCC7B02), Color(0xFFFEB03B)],
                  )
                : const LinearGradient(
                    begin: Alignment(-0.63, -0.78),
                    end: Alignment(0.63, 0.78),
                    colors: [Colors.white, Colors.white],
                  ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFFCA311)),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          alignment: Alignment.center,
          child: isChecked
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,
                )
              : null,
        ),
      );
    });
  }
}
