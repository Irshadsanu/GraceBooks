import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/book_details_screen.dart';
import 'package:grace_book_latest/UserScreens/home_Screen.dart';
import 'package:grace_book_latest/UserScreens/pdf_view_screen.dart';
import 'package:grace_book_latest/UserScreens/reading_finish_Screen.dart';
import 'package:grace_book_latest/UserScreens/user_SearchScreen.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import 'my_CartScreen.dart';
import 'my_LibraryScreen.dart';

class UserHomeBottom extends StatefulWidget {
  final String loginStatus;
  final String userDocId;
  final String userName;
  final String userPhone;
  final int index;

  const UserHomeBottom(
      {Key? key,
      required this.loginStatus,
      required this.userDocId,
      required this.userName,
      required this.userPhone,
      required this.index})
      : super(key: key);

  @override
  State<UserHomeBottom> createState() => _UserHomeBottomState();
}

class _UserHomeBottomState extends State<UserHomeBottom> {
  @override
  int pageIndex = 0;

  // bool hideKeyBoard=Padding.e;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    double mWidth, mHeight;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    bool hideKeyBoard = queryData.viewInsets.bottom != 0;
    final pages = [
      HomeScreen(
        loginStatus: widget.loginStatus,
        userDocId: widget.userDocId,
        userName: widget.userName,
        userPhone: widget.userPhone,
      ),
      UserSearchScreen(
        loginStatus: widget.loginStatus,
        userDocId: widget.userDocId,
        userName: widget.userName,
        userPhone: widget.userPhone,
      ),
      MyLibraryScreen(
        userDocId: widget.userDocId,
        loginStatus: widget.loginStatus,
        userName: widget.userName,
        userPhone: widget.userPhone,
      ),
      MyCartScreen(
        userDocId: widget.userDocId,
        loginStatus: widget.loginStatus,
        userName: widget.userName,
        userPhone: widget.userPhone,
      ),
    ];
    return Scaffold(
      // backgroundColor: const Color(0xffC4DFCB),

      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !hideKeyBoard,
        child: Consumer<MainProvider>(builder: (context, main, _) {
          return main.defaultBookImage!=null? GestureDetector(
            onTap: (){
              if(main.defaultBookPdfLink!=null){
              callNext(PDFViewer(pdfLink: main.defaultBookPdfLink!, currentPage: main.defaultPage!,
                  bookName: main.defaultBookName!, authorName: main.defaultBookAuthor!, bookImage: main.defaultBookImage!,
                  userId: widget.userDocId, userName: widget.userName, userPhone: widget.userPhone,
                  loginStatus: widget.loginStatus), context);}
            },
            child: CircleAvatar(
                backgroundColor: clE8AD14,
                radius: 34,
                child: Center(
                    child: CircleAvatar(
                  backgroundImage: NetworkImage(main.defaultBookImage!),
                  radius: 30,
                ))

                ),
          ):const SizedBox();
        }),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 74,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: cl1B4341,
        // gradient: LinearGradient(
        //
        //     colors: [cl1B4341,cl1B4341],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter
        // )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Consumer<MainProvider>(builder: (context12, mainPro, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  // padding: EdgeInsets.only(left: 30,),
                  padding: EdgeInsets.zero,
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      mainPro.selectedTab = "BOOK";
                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ? Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.only(left: 6),
                                alignment: Alignment.bottomCenter,
                                height: 30,
                                width: 40,
                                child: Image.asset('assets/bulb.png'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/home_select.png',
                                  scale: 1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Home',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                )
                              ],
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/home_select.png',
                              scale: 1,
                              color: clBEBEBE,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Home',
                              style: TextStyle(
                                  color: clBEBEBE,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                            ),
                          ],
                        )),
              Consumer<MainProvider>(builder: (context1, value9, child) {
                return IconButton(
                    padding: EdgeInsets.zero,
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 1;
                        value9.searchBookName = "";
                        value9.userSearchBookList.clear();
                      });
                    },
                    icon: pageIndex == 1
                        ? Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 6),
                                  alignment: Alignment.bottomCenter,
                                  height: 30,
                                  width: 40,
                                  child: Image.asset('assets/bulb.png'),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/search.png',
                                    scale: 1,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Search',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/search.png',
                                scale: 1,
                                color: clBEBEBE,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Search',
                                style: TextStyle(
                                    color: clBEBEBE,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          ));
              }),
              if(mainPro.defaultBookPdfLink!=null)
              const SizedBox(),
              if(mainPro.defaultBookPdfLink!=null)
                const SizedBox(),
              IconButton(
                  enableFeedback: false,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  icon: pageIndex == 2
                      ? Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.only(left: 6),
                                // color: Colors.red,
                                alignment: Alignment.bottomCenter,
                                height: 30,
                                width: 40,
                                child: Image.asset('assets/bulb.png'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/library.png',
                                  scale: 1,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'My Library',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/library.png',
                              scale: 1,
                              color: clBEBEBE,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'My Library',
                              style: TextStyle(
                                  color: clBEBEBE,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                            ),
                          ],
                        )),
              Consumer<MainProvider>(builder: (context92, maiPro, child) {
                return IconButton(
                    enableFeedback: false,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        maiPro.clearCartDetails();
                        pageIndex = 3;
                      });
                    },
                    icon: pageIndex == 3
                        ? Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 6),
                                  alignment: Alignment.bottomCenter,
                                  height: 30,
                                  width: 40,
                                  child: Image.asset('assets/bulb.png'),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/cart.png',
                                    scale: 1,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/cart.png',
                                scale: 1,
                                color: clBEBEBE,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Cart',
                                style: TextStyle(
                                    color: clBEBEBE,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          ));
              }),
            ],
          );
        }),
      ),
    );
  }
}
