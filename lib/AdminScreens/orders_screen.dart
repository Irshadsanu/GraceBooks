import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_book_latest/AdminScreens/sales_report_screen.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import 'admin_delivery_details.dart';

class OrdersScreen extends StatelessWidget {
  int initialTab;
  String userId;
  String userName;
  OrdersScreen({super.key,required this.initialTab,required this.userId,required this.userName});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var outputDayNode2 = DateFormat('dd/MM/yy');
    return DefaultTabController(
      initialIndex: initialTab,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.99),
          automaticallyImplyLeading: false,
          leadingWidth: 60,
          leading: InkWell(
            onTap: () {
              finish(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Orders",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0,
              letterSpacing: 0.70,
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              // unselectedLabelColor: cl1B4341,
              // labelColor: cl1B4341,
              labelStyle:   GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: cl1B4341,
                  letterSpacing: 0.6
              ),
              unselectedLabelStyle:  GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: cl637087,
                  letterSpacing: 0.6
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicator:  const UnderlineTabIndicator(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight:  Radius.circular(18)
                  ),
                  borderSide: BorderSide(
                    color: cl1B4341,
                    width: 4,
                  )),
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Orders"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //ebook.png
                      Text("Dispatched"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //ebook.png
                      SizedBox(width: 2),
                      Text("Delivered"),
                    ],
                  ),
                ),
              ],
            ),

            Expanded(
              child: TabBarView(
                  children: [
                    Consumer<AdminProvider>(
                        builder: (context,value101,child) {
                        return Column(
                          children: [
                            SizedBox(height: 10,),
                            Text("Total - ${value101.adminOrderModelPlaced.length}",
                                style : TextStyle(
                                  fontSize : 13,
                                  fontFamily : "Poppins",
                                  fontWeight : FontWeight.w700,
                                  color :cl1B4341,

                                )
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: ListView.builder(
                                itemCount: value101.adminOrderModelPlaced.length,
                                itemBuilder: (context, index) {
                                  var item = value101.adminOrderModelPlaced[index];
                                  return InkWell(
                                    onTap: () {
                                      callNext(AdminDeliveryDetails(item: item,userName: userName,userId: userId,), context);
                                    },
                                      child: ordersView(width,item));
                                },),
                            ),
                          ],
                        );
                      }
                    ),
                    Consumer<AdminProvider>(
                        builder: (context,value102,child) {
                        return Column(

                          children: [
                            SizedBox(height: 10,),
                            Text("Total - ${value102.adminOrderModelDispatched.length}",
                                style : TextStyle(
                                  fontSize : 13,
                                  fontFamily : "Poppins",
                                  fontWeight : FontWeight.w700,
                                  color :cl1B4341,

                                )
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: ListView.builder(
                                itemCount: value102.adminOrderModelDispatched.length,
                                itemBuilder: (context, index) {
                                var item2 = value102.adminOrderModelDispatched[index];
                                  return InkWell(
                                    onTap: () {
                                  callNext(AdminDeliveryDetails(item: item2,userName: userName,userId: userId,), context);
                                  },
                                      child: ordersView(width,item2));
                                }),
                            ),
                          ],
                        );
                      }
                    ),
                    Consumer<AdminProvider>(
                        builder: (context,value103,child) {
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            Text("Total - ${value103.adminOrderModelDelivered.length}",
                                style : const TextStyle(
                                  fontSize : 13,
                                  fontFamily : "Poppins",
                                  fontWeight : FontWeight.w700,
                                  color :cl1B4341,
                                )
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: ListView.builder(
                                itemCount: value103.adminOrderModelDelivered.length,
                                itemBuilder: (context, index) {
                                  var item3 = value103.adminOrderModelDelivered[index];
                                  return InkWell(
                                      onTap: () {
                                        callNext(AdminDeliveryDetails(item: item3,userId: userId,userName: userName,), context);
                                      },child: ordersView(width,item3));
                                }),
                            ),
                          ],
                        );
                      }
                    ),

              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget ordersView(double width,var item){
    var outputDayNode2 = DateFormat('dd/MM/yy');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21.3),
          color: clWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05), // Shadow color
              blurRadius: 11, // Spread of the shadow
              offset: const Offset(0, 5), // Offset of the shadow
            ),
          ]),
      width: width,
      child:  Row(
        children: [
          Expanded(
            flex: 6,
            child:Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            image: const DecorationImage(
                                image:  NetworkImage("https://foihus.org/wp-content/uploads/2020/10/teammember-500x500-1-400x400.jpg"),
                                fit: BoxFit.fill)
                        ),
                      ),
                    ),
                    // SizedBox(width: 5,),
                    Column(
                      children: [
                        SizedBox(
                          width: width/2.4,
                          child:  Text(item.customerName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
                                color: clBlack
                            ),),
                        ),
                        SizedBox(
                            width: 160,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: item.items.length,
                                itemBuilder: (context, index) {
                                  return Text("- ${item.items[index].itemName}",
                                      style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: clF00000.withOpacity(0.7),

                                      ),
                                      overflow:TextOverflow.ellipsis);
                                }
                            )
                        ),
                        SizedBox(
                            width: 160,
                            child: Text("Order Date :${outputDayNode2.format(item.orderDate.toDate())}",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: clF00000.withOpacity(0.7),
                                    letterSpacing: 0.6
                                ),
                                overflow:TextOverflow.ellipsis)
                        ),

                      ],
                    ),


                  ],
                ),
              ],
            ) ,),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("₹${item.amount}",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: clBlack
                        )),
                  ),
                ],))
        ],
      ),
    );
  }
}
