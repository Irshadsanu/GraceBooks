import 'package:flutter/material.dart';
import 'package:grace_book_latest/Model/orderModel.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/AdminProvider.dart';

class AdminDeliveryDetails extends StatelessWidget {
  OrderModel item;
  String userId;
  String userName;
  AdminDeliveryDetails({super.key,required this.item,required this.userId , required this.userName});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0x2BB6B6B6) ,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Center(
          child: InkWell(
            onTap: () {
              finish(context);
            },
            child: Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0x2BB6B6B6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(71),
                ),
              ),
              child: const Center(
                  child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 17,
              )),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Order Details',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: 0.70,
          ),
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 32.96,
              ),
              SizedBox(
                width: width / 1.113134328358209,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.customerName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              item.customerPhone,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Order date: ${ DateFormat('dd/MM/yy').format(item.orderDate.toDate())}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: height / 34.33333333333333,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0x16B6B6B6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(71),
                                ),
                              ),
                              alignment: Alignment.center,
                              child:  Text(
                                maxLines: 1,
                                item.orderStatus=="DISPATCHED"?"Orders Dispatched!" :item.orderStatus=="DELIVERED"?"Orders Delivered":'Orders Pending!',
                                style: TextStyle(
                                  color: Color(0xFF404040),
                                  fontSize: 12,
                                  fontFamily: 'PoppinsRegular',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: height / 45.77777777777778,
              ),
              SizedBox(
                width: width / 1.113134328358209,
                child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: item.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      var listItem = item.items[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: width / 1.113134328358209,
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21.28),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 11.77,
                                offset: Offset(0, 3.92),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    width: width / 13.1,
                                    height: height / 12.67692307692308,
                                  )),
                              Flexible(
                                  fit: FlexFit.tight,
                                  flex: 4,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width / 49.125),
                                    child:  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listItem.itemName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF353535),
                                            fontSize: 14,
                                            fontFamily: 'PoppinsRegular',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.70,
                                          ),
                                        ),
                                        Text(
                                          listItem.catName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF5A5A5A),
                                            fontSize: 11,
                                            fontFamily: 'PoppinsRegular',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.55,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                               Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '₹${listItem.itemPrice}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: height / 45.77777777777778,
              ),
              SizedBox(
                width: width / 1.113134328358209,

                child: Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text:  TextSpan(
                      text: "Total Amount ",
                      style: TextStyle(
                        color: Color(0xFF353535),
                        fontSize: 14,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.70,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:  '₹${item.items.fold(0.0,(pV, element) => pV + double.parse(element.itemPrice)).toStringAsFixed(0)}',
                          style: TextStyle(
                            color: Color(0xFF404040),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            height: 0,
                          ),
                        )
                        //           '₹800',
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height / 45.77777777777778,
              ),
              Container(
                width: width / 1.113134328358209,
                // height: 156,
                padding: const EdgeInsets.all(24),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.28),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 11.77,
                      offset: Offset(0, 3.92),
                      spreadRadius: 0,
                    )
                  ],
                ),

                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    'Delivery Details',
                    style: TextStyle(
                      color: Color(0xFF404040),
                      fontSize: 14,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.42,
                    ),
                  ),

                    Text(
                      item.customerName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,

                      ),
                    ),Text(
                      item.customerPhone,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),Text(
                      item.address,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],),

              ),
              SizedBox(
                height: height / 45.77777777777778,
              ),
              Container(
                // height: height / 2.20911528150134,
                width: width / 1.113134328358209,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/INVOICE.png"),
                        fit: BoxFit.fill)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'INVOICE',
                          style: TextStyle(
                            color: Color(0xFF404040),
                            fontSize: 40,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.20,
                          ),
                        ),
                        Image.asset(
                          "assets/splash logo.png",
                          scale: 3,
                        )
                      ],
                    ),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.customerName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          item.customerPhone,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Order date: ${ DateFormat('dd/MM/yy').format(item.orderDate.toDate())}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 83,
                    ),
                    Image.asset("assets/invoiceline.png"),
                    SizedBox(
                      height: height / 83,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: item.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          var listItems = item.items[index];
                          return Row(
                            children: [
                              Flexible(
                                  flex:1,
                                  fit: FlexFit.tight ,

                                  child: Text("${index + 1}.")),
                               Flexible(
                                  flex:9,
                                  fit: FlexFit.tight ,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(listItems.itemName))),
                               Flexible(
                                flex:2,
                                fit: FlexFit.tight ,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '₹${listItems.itemPrice}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: height / 83,
                    ),
                    Image.asset("assets/invoiceline.png"),
                    SizedBox(
                      height: height / 83,
                    ),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex:10,
                          fit: FlexFit.tight ,
                          child: Text(
                            'Total Amount ',
                            style: TextStyle(
                              color: Color(0xFF353535),
                              fontSize: 14,
                              fontFamily: "PoppinsRegular",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.70,
                            ),
                          ),
                        ),
                        Flexible(
                          flex:2,
                          fit: FlexFit.tight ,

                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '₹${item.items.fold(0.0,(pV, element) => pV + double.parse(element.itemPrice)).toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Color(0xFF404040),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 153,
                    ),

                     const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex:10,
                          fit: FlexFit.tight ,
                          child:Text(
                            'Tax',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'PoppinsRegular',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Flexible(
                          flex:2,
                          fit: FlexFit.tight ,

                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '00.0',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 83,
                    ),

                    Image.asset("assets/invoiceline.png"),
                    SizedBox(
                      height: height / 83,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(
                        item.paymentMethod,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                        Text(
                          ' ${ DateFormat('dd-MM-yy hh:mm aa').format(item.orderDate.toDate())}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],),

                    SizedBox(height: height/34.33333333333333,),

                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Thank you',
                        style: TextStyle(
                          color: Color(0xFF404040),
                          fontSize: 24,
                          fontFamily: 'Port Lligat Slab',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.72,
                        ),
                      ),
                    ),
                    SizedBox(height: height/34.33333333333333,),

                  ],
                ),
              ),
              SizedBox(
                height: height / 83,
              ),
              item.orderStatus=="DELIVERED"?  SizedBox():SizedBox(
                height: height/20.6,
                width: width / 1.03134328358209,

                child: Consumer<AdminProvider>(
                    builder: (context,value101,child) {
                    return MaterialButton(
                      onPressed: () {

                        value101.orderDetailsAlert(context,item.id,item.orderStatus=="DISPATCHED"?"Delivered":"Dispatched",userId,userName);

                        // Add your onPressed functionality here
                      },

                      color: Colors.transparent, // Transparent color so that the gradient shows
                      elevation: 0, // No shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(49),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1.00, -0.01),
                            end: Alignment(1, 0.01),
                            colors: [Color(0xFF285D5B),Color(0xFF1B4341), ],
                          ),
                          borderRadius: BorderRadius.circular(49),
                        ),
                        child: Center(
                          child: Text(
                           item.orderStatus=="DELIVERED"? 'Delivered':item.orderStatus=="DISPATCHED"?"Delivered":"Dispatched",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),SizedBox(
                height: height / 83,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
