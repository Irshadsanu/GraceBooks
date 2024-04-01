import 'package:flutter/material.dart';
import 'package:grace_book_latest/Model/store_book_model.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/user_home_bottom_navigation_bar.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';

class ReadingFinishScreen extends StatelessWidget {
  final String bookName;
  final String authorName;
  final String bookImage;
  final String userId;
  final String userName;
  final String userPhone;
  final String loginStatus;

  const ReadingFinishScreen(
      {super.key,
      required this.bookName,
      required this.authorName,
      required this.bookImage, required this.userId, required this.userName, required this.userPhone, required this.loginStatus});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Container(
      color: clWhite,
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: clF7F7F7,
                    child: Column(
                      children: [
                        ClipPath(
                          clipper: BottomWaveClipper(),
                          child: Container(
                            height: height / 2.132804232804233,
                            width: width,
                            color: cl1B4341,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipPath(
                                  clipper: CustomShape(),
                                  child: Container(
                                    height: height / 7.672727272727273,
                                    color: clWhite,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(top: height / 84.4),
                                    child: AppBar(
                                      elevation: 0,
                                      scrolledUnderElevation: 0,
                                      leading: IconButton(
                                          onPressed: () {},
                                          icon: const CircleAvatar(
                                              radius: 18,
                                              backgroundColor: clF7F7F7,
                                              child: Icon(
                                                Icons.clear,
                                                size: 18,
                                              ))),
                                      title: Image.asset(
                                        "assets/splash logo.png",
                                        scale: 3,
                                      ),
                                      centerTitle: true,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height / 7.033333333333333,
                                  width: width / 4.193548387096774,
                                  decoration: BoxDecoration(
                                      color: clWhite,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(bookImage),
                                          fit: BoxFit.fill)),
                                ),
                                SizedBox(
                                  height: height / 42.2,
                                ),
                                SizedBox(
                                  width: width / 1.203703703703704,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width / 1.287128712871287,
                                        child: Text(
                                          bookName,
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
                                      Text(
                                        authorName,
                                        style: TextStyle(
                                            color: clWhite,
                                            fontFamily: "PoppinsRegular",
                                            fontSize: width / 27.85714285714286,
                                            fontWeight: FontWeight.w500,
                                            // height: 1,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 20.58536585365854,
                        ),
                        SizedBox(
                          width: width / 1.603056768558952,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width / 2.603056768558952,
                                height: height / 10.918032786885246,
                                child: Image.asset("assets/BACKGROUND.png"),
                              ),
                              Text(
                                'Congratulation !',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cl1B4341,
                                    fontFamily: "PoppinsRegular",
                                    fontSize: width / 15.25,
                                    fontWeight: FontWeight.w500,
                                    // height: 1,
                                    letterSpacing: 1),
                              ),
                              Text(
                                'Your Book Reading Has Completed',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: cl1B4341,
                                  fontFamily: "PoppinsRegular",
                                  fontSize: width / 29.85714285714286,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Celebrating the End of One Chapter and the Beginning of Countless More: A Grateful Salute to Fellow Book Devotees',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cl505050,
                                    fontFamily: "PoppinsRegular",
                                    fontSize: width / 39,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 20.58536585365854,
                        ),
                        TextButton(
                          onPressed: () {
                            callNextReplacement(UserHomeBottom(loginStatus:loginStatus , userDocId: userId, userName: userName, userPhone: userPhone, index: 0), context);

                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(cl1B4341),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: Text(
                            'Home',
                            style: TextStyle(
                                color: clWhite,
                                fontFamily: "PoppinsRegular",
                                fontSize: width / 39,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1),
                          ),
                        ),
                        SizedBox(
                          height: height / 20.58536585365854,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 20.58536585365854,
                  ),
                  Container(
                    width: width / 1.203703703703704,
                    child: Column(
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

                        Consumer<MainProvider>(
                          builder: (context,main,_) {
                            return GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 107,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 4,
                                ),
                                itemCount: main.suggestionBookList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  StoreBookModel item =main.suggestionBookList[index];
                                  print(main.suggestionBookList.length);
                                  print("xakjwedgawkgfwei");
                                  return Container(
                                    height: height / 7.44,
                                    width: width / 5.2,
                                    decoration: BoxDecoration(
                                      color: clWhite,
                                      image: DecorationImage(image: NetworkImage(item.bookPhoto),fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(15)),
                                  );
                                });
                          }
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 50.58536585365854,
                  ),

                  Consumer<MainProvider>(
                    builder: (context,val,_) {
                      return Container(
                        width: width / 1.167664670658683,
                        height: height / 5.341772151898734,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(val.advertisementList[0],),fit: BoxFit.fill),
                            color: clAFD6D4,
                            borderRadius: BorderRadius.circular(11)),
                      );
                    }
                  ),
                  SizedBox(
                    height: height / 20.58536585365854,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

