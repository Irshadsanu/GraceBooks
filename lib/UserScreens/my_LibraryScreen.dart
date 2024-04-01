import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/userMenuScreen.dart';
import 'package:grace_book_latest/UserScreens/user_FavoriteScreen.dart';
import 'package:provider/provider.dart';

import '../Model/save_to_library_model.dart';
import '../Providers/widget_provider.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../login_screen.dart';
import 'book_details_screen.dart';

class MyLibraryScreen extends StatelessWidget {
  final String userDocId;
  final String loginStatus;
  final String userName;
  final String userPhone;
  const MyLibraryScreen({Key? key, required this.userDocId, required this.loginStatus,required this.userName,required this.userPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 130,
              color: cl1B4341,
              child:  AppBar(
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: cl1B4341,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        callNext( UserMenu(loginStatus: loginStatus, userDocId: userDocId, userName: userName, userPhone: userPhone,), context);
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
                                  if(loginStatus=="Logged"){
                                    val1.fetchFavorite(userDocId);
                                  }
                                  callNext(UserFavouriteScreen(userDocId: userDocId,), context);

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
                          return Consumer<WidgetProvider>(builder: (context, wid, _) {
                            return GestureDetector(
                              onTap: () {
                                if (loginStatus == "Logged") {
                                  mai.personalDetailsEdit = false;
                                  mai.deliveryDetailsEdit = false;
                                  mai.fileImage = null;
                                  wid. bottomSheet(
                                      context, height, width, userDocId);
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
                                  :Container(
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
                          }
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const Text(
            "My Library",
            style: TextStyle(
                color: cl1B4341,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.w600,
                fontSize: 14),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<MainProvider>(builder: (context, mainPro, _) {
                return ListView.builder(
                    cacheExtent: 10,
                    itemCount: mainPro.savedLibraryList.length,
                    itemBuilder: (context, index) {
                      SaveToLibraryModel item = mainPro.savedLibraryList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: (){
                            mainPro.fetchEbookDetailsByItem(item.bookId);
                            mainPro.libraryBool=false;
                            mainPro.cartBool=false;
                            callNext(BookDetailsScreen(
                              fav: mainPro.libraryFavList.contains(userDocId)
                                  ? true
                                  : false,
                              image: item.bookImage,
                              tag: index,
                              userId: userDocId,
                              bookId: item.bookId,
                              from: 'E-BOOKS', loginStatus: loginStatus, userName: userName, userPhone: userPhone, cart: false,
                              price: '', offerPrice: '', bookName: item.bookName,authorName: item.authorName, bookCategory: item.category, bookCategoryId: item.categoryId,
                            ), context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3FBDBDBD),
                                  blurRadius: 10.90,
                                  offset: Offset(2, 4),
                                  spreadRadius: -1,
                                )
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: height / 8.34,
                                  width: width / 5.24,
                                  decoration: BoxDecoration(
                                      color: clCDCDCD,
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(item.bookImage),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 10,
                                          child: Text(
                                            item.bookName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: cl353535,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "PoppinsRegular"),
                                          ),
                                        ),
                                        Flexible(
                                            fit: FlexFit.tight,
                                            flex: 1,
                                            child: Consumer<MainProvider>(
                                              builder: (context,va,_) {
                                                return SizedBox(
                                                  height: 30,
                                                  child: PopupMenuButton(
                                                    color:Colors.red ,
                                                    itemBuilder: (context) {
                                                      return [
                                                        const PopupMenuItem(
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
                                                      va.removeSavedLibrary(userDocId,item.bookId,item.docId,);
                                                    },
                                                  ),
                                                );
                                              }
                                            ))
                                      ],
                                    ),

                                    Text(
                                      item.authorName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: cl5B5B5B,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "PoppinsRegular"),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      item.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: cl5B5B5B,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "PoppinsRegular"),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    item.status == "Reading"
                                        ? Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "${item.status}...",
                                              style: const TextStyle(
                                                  fontFamily: "PoppinsRegular",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: cl1B4341),
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
            ),
          )
        ],
      ),
    );
  }
}
