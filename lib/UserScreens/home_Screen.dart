import 'package:appwrite/appwrite.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_book_latest/Model/E_book_Model.dart';
import 'package:grace_book_latest/Model/store_book_model.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/book_details_screen.dart';
import 'package:grace_book_latest/UserScreens/userMenuScreen.dart';
import 'package:grace_book_latest/UserScreens/user_DeliveryDetailsScreen.dart';
import 'package:grace_book_latest/UserScreens/user_FavoriteScreen.dart';
import 'package:grace_book_latest/UserScreens/user_home_bottom_navigation_bar.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../Providers/login_provider.dart';
import '../Providers/timer_provider.dart';
import '../constants/favButton.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import '../login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String loginStatus;
  final String userDocId;
  final String userName;
  final String userPhone;
  HomeScreen(
      {super.key, required this.loginStatus, required this.userDocId,required this.userName,required this.userPhone,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabChange);
    super.initState();
  }
  @override
  void dispose() {
    tabController.removeListener(_handleTabChange);
    tabController.dispose();
    super.dispose();
  }
  void _handleTabChange() {
    final index = tabController.index;
    print("kkkkkkkkkkkkkkkkk "+index.toString());
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    setState(() {
      if(index==0){
        mainProvider.selectedTab="BOOK";
      }else{
        mainProvider.selectedTab="E-BOOK";
      }

    });

  }
  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.brown,
      Colors.yellow
    ];

    List<String> catList = [
      "Best Sellers",
      "Cultural Study ",
      "Developmental Studies",
      "Environmental Studies ",
      "Islam",
      "Maapila Padhanam",
      "Best Sellers",
      "Cultural Study ",
      "Developmental Studies",
      "Environmental Studies ",
      "Islam",
      "Maapila Padhanam",
    ];

    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,

      child: Container(
        color: cl1B4341,
        child: SafeArea(
          child: PopScope(
            onPopInvoked: (va){
              LoginProvider loginProvider =
              Provider.of<LoginProvider>(context, listen: false);
              loginProvider. showExitPopup(context);
            },
            canPop: false,
            child: Scaffold(
              backgroundColor: cl1B4341,
              appBar: AppBar(
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: cl1B4341,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        callNext( UserMenu(loginStatus: widget.loginStatus, userDocId: widget.userDocId, userName: widget.userName, userPhone: widget.userPhone,), context);
                      },
                      child: Container(
                        height: 24,
                        width: size.width / 5.5,
                        decoration: BoxDecoration(
                            color: clF7F7F7.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(79),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.25),
                                // Shadow color
                                blurRadius: 6,
                                // Spread of the shadow
                                offset:
                                const Offset(0, 4), // Offset of the shadow
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
                        Consumer<MainProvider>(
                            builder: (context,val1,_) {
                              return GestureDetector(
                                onTap: () {
                                  if(widget.loginStatus=="Logged"){
                                    val1.fetchFavorite(widget.userDocId);
                                  }
                                  callNext( UserFavouriteScreen(userDocId: widget.userDocId,), context);

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
                            }
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Consumer<MainProvider>(builder: (context, mai, _) {
                          return GestureDetector(
                            onTap: () {
                              if (widget.loginStatus == "Logged") {
                                mai.personalDetailsEdit = false;
                                mai.deliveryDetailsEdit = false;
                                mai.fileImage = null;
                                bottomSheet(
                                    context, size.height, size.width, widget.userDocId);
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
                        }),
                      ],
                    )
                  ],
                ),
              ),
              body: CustomScrollView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                slivers: [
                  SliverAppBar(backgroundColor: Colors.transparent,
                    pinned: false,
                    expandedHeight: 270.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Welcome",
                              style: GoogleFonts.alef(
                                  color: clWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 29),
                            ),
                            Text(
                              "to Grace Book",
                              style: GoogleFonts.alef(
                                  color: clWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Categories",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  color: clWhite),
                            ),
                            // SizedBox(height: 60,),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Consumer<AdminProvider>(
                                  builder: (context02,adPro,child) {
                                    return  Consumer<MainProvider>(
                                        builder: (context02,mainPro,child) {
                                          return SizedBox(
                                            height: 100, // Specify the height of the GridView
                                            child: Wrap(
                                              // runAlignment: WrapAlignment.end,
                                              // verticalDirection: VerticalDirection.up,
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                direction: Axis.vertical,
                                                alignment: WrapAlignment.spaceEvenly,
                                                spacing: 1.0,
                                                // gap between adjacent chips
                                                runSpacing: 10,
                                                // gap between lines
                                                runAlignment: WrapAlignment.start,
                                                children:
                                                List.generate(adPro.bookCategoryList.length, (index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      if(mainPro.selectedTab=="BOOK"){
                                                        mainPro.categoryWiseSortHomeStoreBook(adPro.bookCategoryList[index].id);
                                                      }else{
                                                        mainPro.categoryWiseSortHomeEBook(adPro.bookCategoryList[index].id);
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 16, vertical: 8),
                                                      // height: 35,
                                                      // width: 70,
                                                      decoration: BoxDecoration(
                                                        // color: Color(0xff696969),
                                                          borderRadius:
                                                          BorderRadius.circular(28),
                                                          border: Border.all(
                                                              color: clA7A7A7, width: 1.5)),
                                                      child: Text(
                                                        adPro.bookCategoryList[index].category,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: clWhite,
                                                            fontFamily: "PoppinsRegular"),
                                                      ),
                                                    ),
                                                  );
                                                })),
                                          );
                                        }
                                    );
                                  }
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    bottom:PreferredSize(
                      preferredSize: Size.fromHeight(89),
                      child: Consumer<MainProvider>(
                          builder: (context88,value93,child) {
                            return Container(
                              height: 50,
                              // color: clWhite,
                              decoration: BoxDecoration(color:clWhite
                              ,borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                              ),
                              child: SizedBox(
                                height: 35,
                                child: TabBar(
                                    controller: tabController,
                                    onTap: (index){
                                      setState(() {  if(index==0){
                                        value93.selectedTab="BOOK";
                                      }else{
                                        value93.selectedTab="E-BOOK";
                                      }
                                      });

                                    },
                                    dividerColor: clD9D9D9,
                                    indicatorColor: cl141414,
                                    dividerHeight: 0.5,
                                    tabs: [
                                      Tab(
                                        child: SizedBox(
                                          width: size.width / 6,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/garden_cart.svg',
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Text("Store",
                                                  style: TextStyle(
                                                      fontFamily: "PoppinsRegular",
                                                      color: cl1B4341,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: size.width / 5,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/eBook.svg',
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Text("E-Books",
                                                  style: TextStyle(
                                                      fontFamily: "PoppinsRegular",
                                                      color: cl1B4341,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child:Consumer<MainProvider>(
                      builder: (context,va,_) {
                        return Container(
                          height:va.gridHeight,
                          // height: 470,
                          color: clWhite,
                          child: TabBarView(
                              controller: tabController,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: size.width / 2.5,
                                            child: const Column(
                                              children: [
                                                Text("The Top  Popular Book",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 28,
                                                        fontFamily:
                                                        "PoppinsRegular",
                                                        color: cl1B4341)),
                                                Text(
                                                    "The Best Book Collection of All the Time",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        "PoppinsRegular",
                                                        color: cl616161,
                                                        fontSize: 11)),
                                              ],
                                            ),
                                          ),

                                          ///Carousel is pending
                                          Consumer<MainProvider>(
                                              builder: (context, mainPro4, _) {
                                                return SizedBox(
                                                  height: 180,
                                                  width: size.width / 2.5,
                                                  child: Swiper(
                                                    itemBuilder: (BuildContext context,
                                                        int index) {
                                                      return Container(
                                                        width: 100,
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    mainPro4.carouselList[
                                                                    index]),
                                                                fit: BoxFit.fill),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
                                                      );
                                                    },
                                                    autoplay: true,
                                                    itemCount:
                                                    mainPro4.carouselList.length,
                                                    itemWidth: 135.0,
                                                    itemHeight: 175,
                                                    layout: SwiperLayout.TINDER,
                                                    scrollDirection: Axis.vertical,
                                                    physics:
                                                    const ClampingScrollPhysics(),
                                                    pagination:
                                                    const RectSwiperPaginationBuilder(),
                                                    axisDirection: AxisDirection.down,
                                                  ),
                                                );
                                              })

                                        ],
                                      ),
                                    ),

                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Most Popular",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                fontFamily: "PoppinsRegular",
                                                color: cl1B4341)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Consumer<MainProvider>(
                                          builder: (context, mainPro1, _) {
                                            return GridView.builder(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10.0,
                                                  mainAxisSpacing: 10.0,
                                                  mainAxisExtent: 250),
                                              shrinkWrap: true,
                                              physics:
                                              const NeverScrollableScrollPhysics(),
                                              itemCount:
                                              // mainPro1.homeScreenStoreBookList.length,
                                              mainPro1.filterHomeScreenStoreBookList.length,
                                              itemBuilder: (context, index) {
                                                // StoreBookModel item = mainPro1.homeScreenStoreBookList[index];
                                                StoreBookModel item = mainPro1.filterHomeScreenStoreBookList[index];
                                                return InkWell(
                                                  onTap: () {
                                                    if (widget.loginStatus == "Logged") {
                                                      mainPro1.fetchBookDetailsByItem(item.bookId);
                                                      mainPro1.libraryBool=false;
                                                      mainPro1.cartBool=false;
                                                      callNext(
                                                          BookDetailsScreen(
                                                            fav: item.favoriteList.contains(widget.userDocId)
                                                                ? true
                                                                : false,
                                                            image: item.bookPhoto,
                                                            tag: index,
                                                            userId: widget.userDocId,
                                                            bookId: item.bookId,
                                                            from: 'BOOKS', item: mainPro1.filterHomeScreenStoreBookList[index], loginStatus: widget.loginStatus, userName: widget.userName, userPhone: widget.userPhone,
                                                            cart: item.addCartList.contains(widget.userDocId)?true:false, price: item.bookPrice, offerPrice: item.bookOfferPrice,
                                                            bookName: item.bookName,authorName: item.authorName, bookCategory: item.bookCategory, bookCategoryId: item.bookCategoryId,
                                                          ),
                                                          context);

                                                    } else {
                                                      callNext(
                                                          const LoginScreen(), context);
                                                    }
                                                  },
                                                  onLongPress: () {},
                                                  child: Hero(
                                                    tag: index,
                                                    child: Container(
                                                      width: size.width,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(15.8),
                                                        color: clFEFEFE,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Container(
                                                            margin:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 5,
                                                                vertical: 5),
                                                            width: size.width,
                                                            height: 160,
                                                            alignment: Alignment.topRight,
                                                            decoration: BoxDecoration(
                                                                color: clWhite,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.09),
                                                                    blurRadius: 6,
                                                                    offset: const Offset(0,
                                                                        4), // Offset of the shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    16),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        item.bookPhoto),
                                                                    fit: BoxFit.cover)),
                                                            child: Padding(
                                                                padding:
                                                                const EdgeInsets.all(8.0),
                                                                child: Heart(
                                                                  userId: widget.userDocId,
                                                                  bookId: item.bookId,
                                                                  fav: item.favoriteList
                                                                      .contains(
                                                                      widget.userDocId)
                                                                      ? true
                                                                      : false,

                                                                  from: 'BOOKS', bookName: item.bookName, authorName: item.authorName, bookImage: item.bookPhoto,offerPrice: item.bookOfferPrice,price: item.bookPrice, categoryId: item.bookCategoryId,
                                                                )
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 10),
                                                            child: SizedBox(
                                                              width: size.width,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width: size.width / 3.5,
                                                                    child: Text(
                                                                      item.bookName,overflow: TextOverflow.ellipsis,maxLines: 2,
                                                                      style: const TextStyle(
                                                                          fontSize: 12,
                                                                          color: cl353535,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                          "PoppinsRegular"),
                                                                    ),
                                                                  ),
                                                                  Text(item.authorName,
                                                                      overflow: TextOverflow.ellipsis,maxLines: 1,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                          "PoppinsRegular",
                                                                          fontSize: 10,
                                                                          color: cl5B5B5B,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                                  Text(
                                                                      "₹${item.bookOfferPrice}",
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                          "PoppinsRegular",
                                                                          fontSize: 10,
                                                                          color: cl5B5B5B,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                                  Text("₹${item.bookPrice}",
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                          "PoppinsRegular",
                                                                          fontSize: 8,
                                                                          color: cl5B5B5B,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          decoration:
                                                                          TextDecoration
                                                                              .lineThrough)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    // SizedBox(height: 20,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: size.width / 2.35,
                                            child: const Column(
                                              children: [
                                                Text(
                                                    "Enjoy Your Favorite \nE-Books",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 28,
                                                        fontFamily:
                                                        "PoppinsRegular",
                                                        color: cl1B4341)),
                                                Text(
                                                    "The Best Book Collection of All the Time",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        "PoppinsRegular",
                                                        color: cl616161,
                                                        fontSize: 11)),
                                              ],
                                            ),
                                          ),

                                          Consumer<MainProvider>(
                                              builder: (context, val, _) {
                                                return SizedBox(
                                                  height: 200,
                                                  width: size.width / 2.5,
                                                  child: Swiper(
                                                    itemBuilder: (BuildContext context,
                                                        int index) {
                                                      return Container(
                                                        width: 100,
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    val.carouselList[
                                                                    index]),
                                                                fit: BoxFit.fill),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
                                                      );
                                                    },
                                                    autoplay: true,
                                                    itemCount: val.carouselList.length,
                                                    itemWidth: 135.0,
                                                    itemHeight: 175,
                                                    layout: SwiperLayout.TINDER,
                                                    scrollDirection: Axis.vertical,
                                                    physics:
                                                    const ClampingScrollPhysics(),
                                                    pagination:
                                                    const RectSwiperPaginationBuilder(),
                                                    axisDirection: AxisDirection.down,
                                                  ),
                                                );
                                              })

                                          ///Carousel is pending
                                          ///
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Most Popular",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                fontFamily: "PoppinsRegular",
                                                color: cl1B4341)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Consumer<MainProvider>(
                                          builder: (context, mainPro2, _) {
                                            return GridView.builder(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10.0,
                                                  mainAxisSpacing: 10.0,
                                                  mainAxisExtent: 230),
                                              shrinkWrap: true,
                                              physics:
                                              const NeverScrollableScrollPhysics(),
                                              itemCount:
                                              mainPro2.filterHomeScreenEbookList.length,
                                              itemBuilder: (context, index) {
                                                EbookModel item =
                                                mainPro2.filterHomeScreenEbookList[index];
                                                return InkWell(
                                                  onTap: () {
                                                    mainPro2.fetchEbookDetailsByItem(item.bookId);
                                                    mainPro2.libraryBool=false;
                                                    mainPro2.cartBool=false;
                                                    callNext(BookDetailsScreen(
                                                      fav: item.favList.contains(widget.userDocId)
                                                          ? true
                                                          : false,
                                                      image: item.bookPhoto,
                                                      tag: index,
                                                      userId: widget.userDocId,
                                                      bookId: item.bookId,
                                                      from: 'E-BOOKS', loginStatus: widget.loginStatus, userName: widget.userName, userPhone: widget.userPhone, cart: false,
                                                      price: '', offerPrice: '', bookName: item.bookName,authorName: item.authorName, bookCategory: item.category, bookCategoryId: item.categoryId,
                                                    ), context);
                                                  },
                                                  onLongPress: () {},
                                                  child: Hero(
                                                    tag: index,
                                                    child: Container(
                                                      width: size.width,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(15.8),
                                                        color: clFEFEFE,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5,
                                                                vertical: 5),
                                                            width: size.width,
                                                            height: 160,
                                                            alignment: Alignment.topRight,
                                                            decoration: BoxDecoration(
                                                                color: clWhite,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(
                                                                        0.09),
                                                                    // Shadow color
                                                                    blurRadius: 6,
                                                                    // Spread of the shadow
                                                                    offset: const Offset(
                                                                        0,
                                                                        4), // Offset of the shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    16),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        item.bookPhoto),
                                                                    fit: BoxFit.cover)),
                                                            child: Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Heart(
                                                                  userId: widget.userDocId,
                                                                  bookId: item.bookId,
                                                                  fav: item.favList
                                                                      .contains(
                                                                      widget.userDocId)
                                                                      ? true
                                                                      : false,

                                                                  from: 'E-BOOKS', bookName: item.bookName, authorName: item.authorName, bookImage: item.bookPhoto, offerPrice: '', price: '', categoryId: item.categoryId,
                                                                )),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                            child: SizedBox(
                                                              width: size.width,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                    size.width / 3.5,
                                                                    child: Text(
                                                                      item.bookName,
                                                                      overflow: TextOverflow.ellipsis,maxLines: 2,
                                                                      style: const TextStyle(
                                                                          fontSize: 12,
                                                                          color: cl353535,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                          "PoppinsRegular"),
                                                                    ),
                                                                  ),
                                                                  Text(item.authorName,
                                                                      overflow: TextOverflow.ellipsis,maxLines: 1,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                          "PoppinsRegular",
                                                                          fontSize: 10,
                                                                          color: cl5B5B5B,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ]),
                        );
                      }
                    ),


                  ),

                  SliverToBoxAdapter(
                      child:                         Container(
                        color: clWhite,
                        child: Column(children: [
                          Consumer<MainProvider>(builder: (context, val1, _) {
                            return val1.advertisementList.isNotEmpty
                                ? Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              height: 150,
                              width: size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          val1.advertisementList[0]),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),
                                  color: cl666666),
                            )
                                : const SizedBox();
                          }),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Categories",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "PoppinsRegular",
                                      color: cl1B4341)),
                            ),
                          ),
                          Consumer<AdminProvider>(
                              builder: (context93,adPro,child) {
                                return GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 69,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                      crossAxisCount: 3,
                                    ),
                                    itemCount: adPro.bookCategoryList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Consumer<MainProvider>(
                                          builder: (context89,value88,child) {
                                            return InkWell(
                                              onTap: (){
                                                if(value88.selectedTab=="BOOK"){
                                                  value88.categoryWiseSortHomeStoreBook(adPro.bookCategoryList[index].id);
                                                }else{
                                                  value88.categoryWiseSortHomeEBook(adPro.bookCategoryList[index].id);
                                                }

                                              },
                                              child: Container(
                                                height: size.height / 13.3968253968254,
                                                width: size.width / 3.513513513513514,
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: index < 3 || index >= 6
                                                        ? clAFD6D4
                                                        : clAFBCD6,
                                                    image: const DecorationImage(
                                                        image:
                                                        AssetImage("assets/categoryBg.png"),
                                                        fit: BoxFit.fill),
                                                    borderRadius: BorderRadius.circular(15)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  adPro.bookCategoryList[index].category,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: clBlack,
                                                      fontFamily: "PoppinsRegular",
                                                      fontSize: size.width / 39,
                                                      fontWeight: FontWeight.w700,
                                                      // height: 1,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            );
                                          }
                                      );
                                    });
                              }
                          ),
                          SizedBox(height: size.height*.08,)

                        ],),
                      )




                  ),                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void bottomSheet(
      BuildContext context99, double height, double width, String userDocId) {
    showModalBottomSheet(
      enableDrag: true,
      scrollControlDisabledMaxHeightRatio: .9,
      backgroundColor: clFEFEFE,
      context: context99,
      builder: (BuildContext context) {
        bool _keyboardVisible = false;

        _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

        return Consumer<MainProvider>(builder: (context4, mainPro, _) {
          return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24)),
                      child: ClipPath(
                        clipper: CustomShape(),
                        // this is my own class which extendsCustomClipper
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 110,
                            decoration: const BoxDecoration(
                              color: cl1B4341,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24)),
                            ),
                            alignment: Alignment.center,
                            child: AppBar(
                              leading: Image.asset("assets/logo.png"),
                              centerTitle: true,
                              title: const Text(
                                "Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 14,
                                    color: clF0F0F0),
                              ),
                              backgroundColor: Colors.transparent,
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    finish(context);
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                        color: clF7F7F7.withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    Consumer<MainProvider>(builder: (context, maiPro, _) {
                      return GestureDetector(
                        onTap: () {
                          if (maiPro.personalDetailsEdit) {
                            maiPro.showBottomSheet(context);
                          }
                        },
                        child: maiPro.fileImage != null
                            ? Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(maiPro.fileImage!),
                                  fit: BoxFit.fill)),
                        )
                            : maiPro.userProfileImage != ""
                            ? Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      maiPro.userProfileImage),
                                  fit: BoxFit.fill)),
                        )
                            : Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: width / 1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Personal Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 12,
                                      color: cl303030),
                                ),
                                Consumer<MainProvider>(
                                    builder: (context, mainPro, _) {
                                      return GestureDetector(
                                        onTap: () async {
                                          if (mainPro.personalDetailsEdit &&
                                              (mainPro.numberVerified ||
                                                  mainPro.userPhoneController.text ==
                                                      mainPro.userNumber)) {
                                            print("saved");
                                            mainPro.editPersonalDetails(userDocId);
                                            SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                            // prefs.setString('appwrite_token', tocken);
                                            prefs.setString('phone_number',
                                                mainPro.userPhoneController.text);
                                            // mainPro.personalDetailEditClick();
                                          }

                                          if (mainPro.userPhoneController.text !=
                                              mainPro.userNumber) {
                                            mainPro.userPhoneController.text =
                                                mainPro.userNumber;
                                          }

                                          mainPro.personalDetailEditClick();
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 42,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                color: mainPro.personalDetailsEdit
                                                    ? clE8AD14
                                                    : clWhite,
                                                borderRadius: BorderRadius.circular(6)),
                                            child: Text(
                                              mainPro.personalDetailsEdit
                                                  ? "Save"
                                                  : "Edit",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontSize: 12,
                                                  color: cl303030),
                                            )),
                                      );
                                    })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 81,
                          ),
                          Consumer<MainProvider>(builder: (context, value1, _) {
                            return value1.personalDetailsEdit
                                ? ProfileTextFormWidget(
                              width: width,
                              label: 'Name',
                              controller: value1.userNameController,
                              enable: value1.personalDetailsEdit,
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: 'Name',
                              tail: value1.userName,
                            );
                          }),
                          SizedBox(
                            height: height / 81,
                          ),
                          Consumer<MainProvider>(builder: (context, value2, _) {
                            return value2.personalDetailsEdit
                                ? EditPhoneWidget(
                              width: width,
                              height: height,
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: 'Mobile Number',
                              tail: value2.userNumber,
                            );
                          }),
                          SizedBox(
                            height: height / 81,
                          ),
                          SizedBox(
                            width: width / 1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 12,
                                      color: cl303030),
                                ),
                                Consumer<MainProvider>(builder: (context89, main, _) {
                                  return GestureDetector(
                                    onTap: () async {
                                      main.deliveryDetailEditClick();
                                      if (mainPro.deliveryDetailsEdit) {
                                        print("saved" +
                                            mainPro.userPinCodeController.text);
                                        bool pincodeStatus = await mainPro.getPinCodeApi(mainPro.userPinCodeController.text);
                                        if (pincodeStatus) {
                                          print("condition true");
                                          mainPro.addDeliveryAddress(userDocId);

                                        } else {
                                          /// top snackBar needed

                                        }

                                      }

                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: 42,
                                        height: 24,
                                        decoration: BoxDecoration(
                                            color: main.deliveryDetailsEdit
                                                ? clE8AD14
                                                : clWhite,
                                            borderRadius: BorderRadius.circular(6)),
                                        child: Text(
                                          main.deliveryDetailsEdit
                                              ? "Save"
                                              : "Edit",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 12,
                                              color: cl303030),
                                        )),
                                  );
                                })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 81,
                          ),
                          Consumer<MainProvider>(builder: (context, value3, _) {
                            return value3.deliveryDetailsEdit
                                ? ProfileTextFormWidget(
                              width: width,
                              label: 'Address',
                              controller: value3.userAddressController,
                              enable: value3.deliveryDetailsEdit,
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: "Address",
                              tail: value3.userAddress,
                            );
                          }),
                          SizedBox(
                            height: height / 81,
                          ),
                          // Consumer<MainProvider>(builder: (context, value4, _) {
                          //   return value4.deliveryDetailsEdit
                          //       ? ProfileTextFormWidget(
                          //           width: width,
                          //           label: 'State',
                          //           controller: value4.userStateController,
                          //           enable: value4.deliveryDetailsEdit,
                          //         )
                          //       : ProfileDetailWidget(
                          //           width: width,
                          //           height: height,
                          //           head: "State",
                          //           tail: value4.userState,
                          //         );
                          // }),
                          // SizedBox(
                          //   height: height / 81,
                          // ),
                          // Consumer<MainProvider>(builder: (context, value5, _) {
                          //   return value5.deliveryDetailsEdit
                          //       ? ProfileTextFormWidget(
                          //           width: width,
                          //           label: 'District',
                          //           controller: value5.userDistrictController,
                          //           enable: value5.deliveryDetailsEdit,
                          //         )
                          //       : ProfileDetailWidget(
                          //           width: width,
                          //           height: height,
                          //           head: "District",
                          //           tail: value5.userDistrict,
                          //         );
                          // }),
                          // SizedBox(
                          //   height: height / 81,
                          // ),
                          Consumer<MainProvider>(builder: (context, value7, _) {
                            return value7.deliveryDetailsEdit
                                ? ProfileTextFormWidgetNumber(
                              width: width,
                              label: 'PIN',
                              controller: value7.userPinCodeController,
                              length: 6,
                              enable: value7.deliveryDetailsEdit,
                              onChanged: (p0) {
                                value7.userPinCodeController.text = p0;
                                value7.notifyListeners();
                              },
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: 'PIN',
                              tail: value7.userPin,
                            );
                          }),
                          SizedBox(
                            height: height / 81,
                          ),
                          Consumer<MainProvider>(builder: (context, value6, _) {
                            return value6.deliveryDetailsEdit
                                ? ProfileTextFormWidget(
                              width: width,
                              label: 'Post Office',
                              controller: value6.userPostOfficeController,
                              enable: value6.deliveryDetailsEdit,
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: 'Post Office',
                              tail: value6.userPostOffice,
                            );
                          }),

                          SizedBox(
                            height: _keyboardVisible ? height / 2 : 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
      },
    );
  }
}

enum MobileVarificationState { SHOW_MOBILE_FORM_STATE, SHOW_OTP_FORM_STATE }

class EditPhoneWidget extends StatefulWidget {
  final double width;
  final double height;

  const EditPhoneWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<EditPhoneWidget> createState() => _EditPhoneWidgetState();
}

class _EditPhoneWidgetState extends State<EditPhoneWidget> {
  MobileVarificationState currentSate =
      MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FocusNode _pinPutFocusNode = FocusNode();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String VerificationId = "";
  late var tocken;
  bool showLoading = false;
  bool showTick = false;
  bool numberEx = false;
  LoginProvider loginProvider = LoginProvider();
  Client client = Client();

  @override
  void initState() {
    super.initState();
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('65dc6461e783c157ea1a')
        .setSelfSigned(status: true);
  }

  Future<void> otpsend(BuildContext context, String from) async {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    setState(() {
      showLoading = true;
    });
    if (showTick) {
      final account = Account(client);
      try {
        final sessionToken = await account.createPhoneSession(
            userId: ID.unique(),
            phone: '+91${mainProvider.userPhoneController.text}');

        VerificationId = sessionToken.userId;
        tocken = sessionToken.$id;

        setState(() {
          showLoading = false;
          currentSate = MobileVarificationState.SHOW_OTP_FORM_STATE;
          TimeProvider timeProvider =
          Provider.of<TimeProvider>(context, listen: false);
          if (from != "recent") {
            timeProvider.startCountdown();
          } else {
            timeProvider.resetCountdown();
            timeProvider.startCountdown();
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("OTP sent to phone successfully"),
            duration: Duration(milliseconds: 3000),
          ));
        });
      } catch (e) {
        if (e is AppwriteException) {
          setState(() {
            showLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Sorry, Verification Failed"),
            duration: Duration(milliseconds: 3000),
          ));
        } else {
          setState(() {
            showLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Sorry, Verification Failed"),
            duration: Duration(milliseconds: 3000),
          ));
          // Handle other types of exceptions or errors
          print('An unexpected error occurred: $e');
        }
      }
    }
  }

  Future<void> verify() async {
    setState(() {
      showLoading = true;
    });
    final account = Account(client);
    try {
      final session = await account.updatePhoneSession(
          userId: VerificationId, secret: otpController.text);

      try {
        print("object ddddddd");
        MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);
        mainProvider.numberVerified = true;

        currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Success"),
          duration: Duration(milliseconds: 3000),
        ));

        setState(() {
          showLoading = false;
        });

        if (kDebugMode) {
          print("Login Success");
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // Process the successful response if needed
    } catch (e) {
      if (e is AppwriteException) {
        // Handle AppwriteException
        final errorMessage = e.message ?? 'An error occurred.';

        // Display the error message using a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.purple,
          ),
        );
      } else {
        // Handle other types of exceptions or errors
        print('An unexpected error occurred: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, value2, _) {
      return Column(
        children: [
          ProfileTextFormWidgetNumber(
            onChanged: (p0) {
              setState(() {
                value2.userPhoneController.text = p0;
                if (p0.length == 10) {
                  showTick = true;
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                } else {
                  showTick = false;
                }
                print(value2.userPhoneController.text);
                print("haisdjsj");
              });
            },
            width: widget.width,
            label: 'Mobile Number',
            controller: value2.userPhoneController,
            length: 10,
            enable: value2.personalDetailsEdit,
          ),
          numberEx
              ? const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Number Already Exist",
                  style: TextStyle(color: Colors.red),
                )),
          )
              : const SizedBox(),
          currentSate == MobileVarificationState.SHOW_OTP_FORM_STATE
              ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: widget.height / 83,
              ),
              const Text(
                "OTP",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    fontFamily: "PoppinsRegular"),
              ),
              Consumer<TimeProvider>(builder: (context, timePro, _) {
                return timePro.countdown != 0
                    ? RichText(
                  text: TextSpan(
                    text: "Valid ",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        fontFamily: "PoppinsRegular",
                        color: clA7A7A7),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${timePro.countdown}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: clBlack,
                            fontSize: 10),
                      ),
                      const TextSpan(
                          text: ' Seconds',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              fontFamily: "PoppinsRegular",
                              color: clA7A7A7)),
                    ],
                  ),
                )
                    : const SizedBox();
              }),
              SizedBox(
                height: widget.height / 83,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        // Black color with opacity 0.05 (0D) using hexadecimal representation
                        blurRadius: 10.052813529968262,
                        spreadRadius: 1.436116099357605,
                        offset: Offset(0, 0), // No offset
                      ),
                    ],
                  ),
                  child: PinFieldAutoFill(
                      codeLength: 6,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      currentCode: "",
                      decoration: BoxLooseDecoration(
                          gapSpace: 10,
                          radius: const Radius.circular(11),
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: cl404040,
                              fontFamily: "PoppinsRegular"),
                          bgColorBuilder:
                          const FixedColorBuilder(clWhite),
                          strokeColorBuilder:
                          const FixedColorBuilder(clWhite)),
                      onCodeChanged: (pin) {
                        if (pin!.length == 6) {
                          verify();
                        }
                      }),
                ),
              ),
              SizedBox(
                height: widget.height / 43,
              ),

              Consumer<TimeProvider>(builder: (context, timePro, _) {
                return timePro.countdown != 0
                    ? const SizedBox()
                    : GestureDetector(
                  onTap: () {
                    setState(() {
                      if (showTick) {
                        otpsend(context, "recent");
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("invalid Mobile Number",
                              style:
                              TextStyle(color: Colors.white)),
                          duration: Duration(milliseconds: 3000),
                        ));
                      }
                    });
                  },
                  child: const SizedBox(
                    child: Text(
                      "Recent OTP",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 9,
                          fontFamily: "PoppinsRegular"),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: widget.height / 43,
              ),

              // const SizedBox(height: 20,),
            ],
          )
              : const SizedBox(
            height: 0,
          ),
          value2.userNumber != value2.userPhoneController.text &&
              !value2.numberVerified
              ? TextButton(
            onPressed: () async {
              bool checkPhoneNumber = false;
              checkPhoneNumber = await value2
                  .checkNumberExist(value2.userPhoneController.text);
              if (!checkPhoneNumber) {
                setState(() {
                  numberEx = false;

                  if (showTick) {
                    otpsend(context, "login");
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("invalid Mobile Number",
                          style: TextStyle(color: Colors.white)),
                      duration: Duration(milliseconds: 3000),
                    ));
                  }
                });
              } else {
                setState(() {
                  numberEx = true;
                });
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(clE8AD14),
              foregroundColor: MaterialStateProperty.all<Color>(clWhite),
            ),
            child: showLoading
                ? SizedBox(height: 25, width: 25, child: waitingIndicator)
                : Text(
              'Verify Number',
              style: TextStyle(
                  color: cl303030,
                  fontFamily: "PoppinsRegular",
                  fontSize: widget.width / 32.5,
                  fontWeight: FontWeight.w700,
                  // height: 1,
                  letterSpacing: 1),
            ),
          )
              : value2.numberVerified
              ? const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Verified ✓",
              style: TextStyle(color: Colors.green),
            ),
          )
              : const SizedBox(),
        ],
      );
    });
  }
}

class CardDetail {
  final String cardBgAsset;
  final String balance;
  final String cardNumber;

  const CardDetail({
    required this.cardBgAsset,
    required this.balance,
    required this.cardNumber,
  });
}
