import 'package:flutter/material.dart';
import 'package:grace_book_latest/Model/favorite_model_class.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/constants/favButton.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';

class UserFavouriteScreen extends StatelessWidget {
  final String userDocId;
  const UserFavouriteScreen({Key? key, required this.userDocId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CustomShape(),
            // this is my own class which extendsCustomClipper
            child: Container(
              height: 130,
              color: cl1B4341,
              alignment: Alignment.bottomCenter,
              child: AppBar(leading: GestureDetector(
                  onTap: (){
                    finish(context);
                  },
                  child: Icon(Icons.arrow_back_ios,color: clWhite,size: 17,)),
                  backgroundColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  centerTitle: true,title:Image.asset("assets/logo.png",scale: 2,) ),

              // SizedBox(
              //   height: 34,
              //   width: 70,
              //   child: ,
              // ),
            ),
          ),
          const Text(
            "Favorite",
            style: TextStyle(
                color: cl1B4341,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.w600,
                fontSize: 14),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Consumer<MainProvider>(builder: (context, mainPro, _) {
              return ListView.builder(
                itemCount: mainPro.allFavoriteList.length,
                itemBuilder: (context, index) {
                  FavoriteModel item = mainPro.allFavoriteList[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                    child: Container(
                      width: width,
                      // height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: clBDBDBD40.withOpacity(0.15),
                            blurRadius: 10.0,
                            spreadRadius: 0.0, // Spread radius set to 0
                            offset: const Offset(
                                2.0, 4.0), // Adjust offset as needed
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 75,
                              height: 100,
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
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Text(
                                            item.bookName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: cl353535,
                                                fontFamily: 'PoppinsRegular',
                                                fontSize: 14),
                                          ),
                                        ),
                                        Heart(userId: userDocId, bookId: item.bookId, fav: true,  from: "FAV-SCREEN", bookName: item.bookName, authorName: item.authorName, bookImage: item.bookImage, offerPrice: item.offerPrice, price: item.price, categoryId: item.categoryId,)
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
                                  item.bookType=="BOOKS"?  Text('₹ ${item.offerPrice}',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: cl1B4341)):const SizedBox(),
                                    item.bookType=="BOOKS"?    Text('₹ ${item.price}',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'PoppinsRegular',
                                            fontWeight: FontWeight.w600,
                                            color: clA7A7A7,
                                            decoration:
                                                TextDecoration.lineThrough)):const SizedBox(),
                                    item.bookType!="BOOKS"?  Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 63,
                                            height: 31,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(58),
                                                color: clF4F4F4),
                                            child: const Text(
                                              "E-Book",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontWeight: FontWeight.w600,
                                                  color: cl1B4341),
                                            ))):const SizedBox()
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
    );
  }
}
