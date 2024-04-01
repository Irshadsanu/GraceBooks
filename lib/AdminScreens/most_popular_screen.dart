import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_book_latest/AdminScreens/admin_book_details_Page.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../Model/book_Model.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import 'addBook _Screen.dart';
import 'add_E_Book_Screen.dart';

class MostPopularScreen extends StatefulWidget {
  String userName;
  String userId;
   MostPopularScreen({super.key,required this.userName,required this.userId,});

  @override
  State<MostPopularScreen> createState() => _MostPopularScreenState();
}

class _MostPopularScreenState extends State<MostPopularScreen>with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _tabController = TabController(length: 2, vsync: this);
      print(_tabController.index.toString()+"dlolold");
    });
  }
  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    final double width = queryData.size.width;
    final double height = queryData.size.height;
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    adminProvider.fetchAdminStoreBook();
    adminProvider.fetchAdminEbook();
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Consumer<AdminProvider>(
            builder: (context33,value8,child) {
              return InkWell(
                onTap: (){
                  if(_tabController.index==0){
                    value8.clearBookControllers();
        
                    callNext(AddBookScreen(from: "NEW",bookId: "",userName: widget.userName, userId: widget.userId), context);
                  }else{
                    value8.clearEBookControllers();
                    callNext( AddEbookScreen(bookId: "",from: "NEW",userName: widget.userName, userId: widget.userId), context);
                  }
        
                },
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CircleAvatar(
                    backgroundColor: clE8AD14,
                    radius: 28,
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.add,size: 25),
                    ),
                  ),
                ),
              );
            }
          ),
        
          body: Column(
            children: [
              ClipPath(
                clipper: CustomShape(),
                // this is my own class which extendsCustomClipper
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 140,
                  color: cl1B4341,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      SizedBox(
                        height: 40,
                        width: 80,
                        child: Image.asset("assets/logo.png"),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: clF7F7F7.withOpacity(0.2),
                                shape: BoxShape.circle),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
               TabBar(
                 controller:_tabController,
                unselectedLabelColor: cl1B4341,
                labelColor: cl1B4341,
                labelStyle:   GoogleFonts.poppins(
                   fontSize: 15,
                   fontWeight: FontWeight.w700,
                   color: cl1B4341,
                   letterSpacing: 0.6
               ),
                indicatorSize: TabBarIndicatorSize.label,
        
                indicator:  const UnderlineTabIndicator(
                    insets: EdgeInsets.symmetric(horizontal:25.0),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight:  Radius.circular(18)),
                    borderSide: BorderSide(
                      color: cl1B4341,
                      width: 4,
                    )),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Image.asset(
                      'assets/storeBook.png',
                          color: cl1B4341,
                          scale: 2.4,
                          fit: BoxFit.fill
                    ),
                        const SizedBox(width: 2),
                        // Adjust the spacing between icon and text as needed
                        const Text("Store"),
                      ],
                    ),
                  ),
                   Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //ebook.png
                        Image.asset(
                            'assets/ebook.png',
                            color: cl1B4341,
                            scale: 3,
                            fit: BoxFit.fill
                        ),
                        const SizedBox(width: 2),
                        const Text("E-Books",),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 21.0,left: 18),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Most Popular",
                      style : TextStyle(
                        fontSize : 19,
                        fontFamily : "Poppins",
                        fontWeight : FontWeight.w700,
                        color :cl1B4341,
        
                        letterSpacing :0.8,
                      )),
                ),
              ),
        
               Expanded(
                 child: SizedBox(
                   height: height,
                   child: TabBarView(
                     controller:_tabController,
                     children: [
                       Consumer<AdminProvider>(
                         builder: (context4,value9,child) {
                           return GridView.builder(
                             physics: const ScrollPhysics(),
                             shrinkWrap: true,
                             padding: const EdgeInsets.only(bottom: 20,left: 8,right: 8),
                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 2,
                                 crossAxisSpacing: 10.0,
                                 mainAxisSpacing: 20.0,
                                 mainAxisExtent: 250
                             ),
                             itemCount:  value9.adminStoreBookList.length,
                             itemBuilder: (BuildContext context, int index) {
                               BookModel item = value9.adminStoreBookList[index];
                               return  InkWell(
                                 onTap: () {
                                   callNext( AdminBookDetails(item: item, from: "STORE",userName: widget.userName, userId: widget.userId), context);
                                 },
                                   child: buildStoreItem(width,height,item,"BOOK"));
                             },
                           );
                         }
                       ),
                       Consumer<AdminProvider>(
                         builder: (context5,value98,child) {
                           return GridView.builder(
                             physics: const ScrollPhysics(),
                             padding: const EdgeInsets.only(bottom: 20,left: 8,right: 8),
                             shrinkWrap: true,
                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 2,
                                 crossAxisSpacing: 10.0,
                                 mainAxisSpacing: 20.0,
                                 mainAxisExtent: 250
                             ),
                             itemCount: value98.adminEBookList.length,
                             itemBuilder: (BuildContext context, int index) {
                               BookModel item2=value98.adminEBookList[index];
                               return  InkWell(
                                 onTap: () {
                                   callNext( AdminBookDetails(item: item2,from: "E-BOOK",userName: widget.userName, userId: widget.userId), context);
                                 },
                                   child: buildStoreItem(width,height,item2,"E-BOOK"));
                             },
                           );
                         }
                       ),
                       // Tab 2: My Orders
        
                     ],
                   ),
                 ),
               ),
            ],
          ),
        
        ),
      ),
    );
  }

  Widget buildStoreItem(double width,double height,BookModel item,String type) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.8),
        color: clFEFEFE,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            width: width,
            height: 160,
            alignment: Alignment.topRight,
            decoration:BoxDecoration(
                color: clWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.09), // Shadow color
                    blurRadius: 6, // Spread of the shadow
                    offset: const Offset(0, 4), // Offset of the shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
                image:  DecorationImage(
                    image: NetworkImage(item.bookPhoto),
                    fit: BoxFit.cover)
            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width/3.5,
                    child:  Text(
                     item.bookName,
                      maxLines: 2,
                      style:  const TextStyle(
                          fontSize:12,
                          color: cl353535,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PoppinsRegular"),
                    ),
                  ),

                   Text(
                       item.author,
                       maxLines: 1,
                       style: const TextStyle(
                      fontFamily: "PoppinsRegular",
                      fontSize:10,
                      color: cl5B5B5B,
                      fontWeight: FontWeight.bold)),

                      type!="E-BOOK"? Text("₹${item.offerPrice}", style: const TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize:10,
                          color: cl5B5B5B,
                          fontWeight: FontWeight.bold)):const SizedBox(),


                  type!="E-BOOK"? Text("₹${item.price}", style: const TextStyle(
                      fontFamily: "PoppinsRegular",
                      fontSize:8,
                      color: cl5B5B5B,
                      fontWeight: FontWeight.bold,
                      decoration:TextDecoration.lineThrough
                  )):const SizedBox(),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
