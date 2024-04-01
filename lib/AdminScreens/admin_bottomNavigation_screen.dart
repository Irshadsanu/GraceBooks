import 'package:flutter/material.dart';
import 'package:grace_book_latest/AdminScreens/admin_home_screen.dart';
import 'package:grace_book_latest/AdminScreens/most_popular_screen.dart';
import 'package:grace_book_latest/AdminScreens/staffList_Screen.dart';

import '../UserScreens/my_LibraryScreen.dart';
import '../constants/my_colors.dart';

class AdminBottomNavigationScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userNumber;
  final String userType;
  const AdminBottomNavigationScreen({super.key, required this.userId, required this.userName, required this.userNumber, required this.userType});

  @override
  State<AdminBottomNavigationScreen> createState() => _AdminBottomNavigationScreenState();
}

class _AdminBottomNavigationScreenState extends State<AdminBottomNavigationScreen> {

  @override
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
       AdminHomeScreen(userId: widget.userId, userName: widget.userName, userNumber:widget.userNumber , userType: widget.userType,),
       MostPopularScreen(userName: widget.userName, userId: widget.userId),
      const StaffListScreen(),
    ];
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 74,
      decoration: const BoxDecoration(
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: cl1B4341,

      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              // padding: EdgeInsets.only(left: 30,),
                padding: EdgeInsets.zero,
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ?
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment:Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(left: 6),
                        alignment: Alignment.bottomCenter,
                        height: 30,
                        width: 40,
                        child: Image.asset('assets/bulb.png'),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/home_select.png',scale: 1,),
                        SizedBox(height: 5,),
                        const Text('Home',style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"
                        ),)
                      ],
                    ),
                  ],
                )
                    :  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/home_select.png',scale: 1,color: clBEBEBE,),
                    SizedBox(height: 5,),
                    const Text('Home',style: TextStyle(
                        color: clBEBEBE,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"
                    ),),
                  ],
                )
            ),
            IconButton(
                padding: EdgeInsets.zero,
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ?    Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment:Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(left: 6),
                        alignment: Alignment.bottomCenter,
                        height: 30,
                        width: 40,
                        child: Image.asset('assets/bulb.png'),
                      ),
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/library.png',scale: 1,color: Colors.white,),
                        SizedBox(height: 5,),
                        const Text('Books',style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"
                        ),),
                      ],
                    ),
                  ],
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/library.png',scale: 1,color: clBEBEBE,),
                    SizedBox(height: 5,),
                    const Text('Books',style: TextStyle(
                        color: clBEBEBE,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"
                    ),),
                  ],
                )
            ),


            IconButton(
                enableFeedback: false,
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: pageIndex == 2
                    ?  Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment:Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(left: 6),
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
                        Image.asset('assets/staffs.png',scale: 1,color: Colors.white,),
                        SizedBox(height: 5,),
                        const Text('Staffs',style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"
                        ),),
                      ],
                    ),
                  ],
                )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/staffs.png',scale: 1,color: clBEBEBE,),
                        SizedBox(height: 5,),
                        const Text('Staffs',style: TextStyle(
                        color: clBEBEBE,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"
                    ),),
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }

}
