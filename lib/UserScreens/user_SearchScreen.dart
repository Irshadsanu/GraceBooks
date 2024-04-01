import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/userMenuScreen.dart';
import 'package:grace_book_latest/UserScreens/user_FavoriteScreen.dart';
import 'package:provider/provider.dart';

import '../Model/searchBookModel.dart';
import '../Model/staffModel.dart';
import '../Model/store_book_model.dart';
import '../Providers/widget_provider.dart';
import '../constants/favButton.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../login_screen.dart';
import 'book_details_screen.dart';
class UserSearchScreen extends StatelessWidget {
  final String loginStatus;
  final String userDocId;
  final String userName;
  final String userPhone;
   UserSearchScreen({Key? key,required this.loginStatus, required this.userDocId,required this.userName,required this.userPhone,}) : super(key: key,);

  List<String> exmpText=["Best Sellers","Cultural Study","Developmental Studies",
  "Environmental Studies","Islam","Maapila Padhanam","Environmental Studies","Islam","Maapila Padhanam"];
  @override
  Widget build(BuildContext context) {
    double width, height;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

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
            const SizedBox(height: 5,),

            Consumer<MainProvider>(
              builder: (context21,mainPro,child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Autocomplete<SearchModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return (mainPro.searchBookList)
                          .where((SearchModel wardd) => wardd.name
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()))
                          .toList();
                    },
                    displayStringForOption: (SearchModel option) => option.name,
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        fieldTextEditingController.text =  mainPro.searchBookName;
                      });

                      return TextFormField(
                        style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: cl1B4341,
                            prefixIcon: const Icon(Icons.search,color: clFFFFFF,size: 20,),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 15),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(37),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(37),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(37),
                          ),
                          hintText: " Search book/E-book",
                            hintStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "PoppinsRegular"
                            )
                        ),
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        textAlign: TextAlign.start,
                        validator: (value2) {
                          if (value2!.trim().isEmpty ||
                              !mainPro.searchBookList
                                  .map((item) => item.name)
                                  .contains(value2)) {
                            return "Please select category";
                          } else {
                            return null;
                          }
                        },
                      );
                    },
                    onSelected: (SearchModel selection) {
                      mainPro.searchBookName = selection.name;
                      print("dmmmmmmmmmmmmmmmmmmmmmmmmme${selection.bookType}");
                      mainPro.fetchSearchBooks("${selection.bookType}S",selection.id);
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<SearchModel> onSelected,
                        Iterable<SearchModel> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            width: width / 1.6,
                            height: height * .3,
                            color: Colors.white,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(10.0),
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final SearchModel option = options.elementAt(index);

                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    width: width,
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(option.name,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 10)
                                        ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            ),

            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(left:15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Categories",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: "PoppinsRegular",
                  color: cl303030,
                ),),
              ),
            ),
            const SizedBox(height: 20,),
            Consumer<AdminProvider>(
              builder: (context21,admPro,child) {
                return  Consumer<MainProvider>(
                    builder: (context11,mainPro,child) {
                    return Container(
                      height: 100,
                      padding: const EdgeInsets.only(left: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(admPro.bookCategoryList.length, (index){
                            return InkWell(
                              onTap: (){
                                mainPro.searchBookCategoryWise(admPro.bookCategoryList[index].id,);
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: cl255654,
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(color: cl999999,width: 0.5)
                                ),
                                child: Text(admPro.bookCategoryList[index].category,
                                  style: const TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: clFFFFFF
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  }
                );
              }
            ),
            const SizedBox(height: 20,),
            Consumer<MainProvider>(
              builder: (context1,mainPro,child) {
                return  mainPro.userSearchBookList.isNotEmpty?ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: mainPro.userSearchBookList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context,int index){
                  StoreBookModel item= mainPro.userSearchBookList[index];
                  return InkWell(
                    onTap: (){
                      if (loginStatus == "Logged") {
                        if(item.bookType=="BOOKS"){
                        mainPro.fetchBookDetailsByItem(item.bookId);
                        mainPro.libraryBool=false;
                        callNext(
                            BookDetailsScreen(
                              fav: item.favoriteList.contains(userDocId)
                                  ? true
                                  : false,
                              image: item.bookPhoto,
                              tag: index,
                              userId: userDocId,
                              bookId: item.bookId,
                              from: 'BOOKS', item: item, loginStatus: loginStatus, userName: userName, userPhone: userPhone,
                              cart: false, price: item.bookPrice, offerPrice: item.bookOfferPrice, bookName: item.bookName, authorName: item.authorName,
                              bookCategory: item.bookCategory, bookCategoryId: item.bookCategoryId,
                            ),
                            context);
                      }else{
                          mainPro.fetchEbookDetailsByItem(item.bookId);
                          mainPro.libraryBool=false;
                          mainPro.cartBool=false;

                          callNext(BookDetailsScreen(
                            fav: item.favoriteList.contains(userDocId)
                                ? true
                                : false,
                            image: item.ebookPhoto,
                            tag: index,
                            userId: userDocId,
                            bookId: item.bookId,
                            from: 'E-BOOKS', loginStatus: loginStatus, userName: userName, userPhone: userPhone, cart: false,
                            price: '', offerPrice: '', bookName: item.bookName,authorName: item.authorName, bookCategory: item.bookCategory, bookCategoryId: item.bookCategoryId,
                          ),
                              context);


                        }
                      }
                      else {
                        callNext(
                            const LoginScreen(), context);
                      }


                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      // height: 140,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        color: clFFFFFF,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: clBDBDBD.withOpacity(0.25),
                            offset: const Offset(2, 4),
                            blurRadius: 10
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 75,
                                decoration: BoxDecoration(
                                    color: clCDCDCD,
                                  borderRadius: BorderRadius.circular(8),
                                  image:  DecorationImage(
                                    image: item.bookType=="BOOK"?NetworkImage(item.bookPhoto):NetworkImage(item.ebookPhoto),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: width/1.7,
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Text(item.bookName,//The Guide And Guardian The Guide And Guardian The Guide And Guardian
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                  color: cl353535,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "PoppinsRegular"
                                ),),
                                  const SizedBox(height: 5,),
                                   Text(item.authorName,//Author Name Author Name Author Name Author Name Author NameAuthor NameAuthor Name
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: cl5B5B5B,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "PoppinsRegular"
                                    ),),
                                  const SizedBox(height: 5,),

                              ],)),

                              Heart(
                                userId: userDocId,
                                bookId: item.bookId,
                                fav: item.favoriteList
                                    .contains(
                                    userDocId)
                                    ? true
                                    : false,
                                from: 'BOOKS', bookName: item.bookName, authorName: item.authorName, bookImage: item.bookPhoto,offerPrice: item.bookOfferPrice,price: item.bookPrice, categoryId:item.bookCategoryId,
                              )
                            ],
                          ),
                          item.bookType!="BOOKS"?Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 63,
                              height: 31,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF4F4F4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(58),
                                ),
                              ),
                              child: const Text(
                                'E-Book',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1B4341),
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0.09,
                                  letterSpacing: 0.55,
                                ),
                              ),
                            ),
                          ):const SizedBox()

                        ],
                      ),
                    ),
                  );
                          }):Container(
                  alignment: Alignment.center,
                  height: height*.4,
                  child: const Text("No data found",style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                );
              }
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
