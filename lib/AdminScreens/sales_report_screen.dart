import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
          "Sales Report",
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

          Consumer<AdminProvider>(
            builder: (context22,value8,child) {
              return InkWell(
                child: Container(
                  // width: width * .9,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 5.15,
                        offset: Offset(0, 2.58),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,

                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 1),
                      hintText: 'Search here..',
                      hintStyle:    GoogleFonts.poppins(
                        color: clB1B1B1,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 0.14,
                      ),
                      border: InputBorder.none,
                      suffixIcon: SizedBox(
                          width: width * .12,
                          child: const Icon(Icons.search, color: Colors.black, size: 22)
                      ),
                    ),
                    onChanged: (text) {
                      value8.filterSalesReport(text);
                    },
                  ),
                ),
              );
            }
          ),
          const SizedBox(height: 10,),
          Consumer<AdminProvider>(
              builder: (context22,value81,child) {
              return Container(
                // width: width * .9,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                height: 40,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 5.15,
                      offset: Offset(0, 2.58),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: TextField(
                  onTap: (){
                    value81.showCalendarDialog(context,"SALES_REPORT");
                  },
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(),
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 1),
                    hintText: "${value81.saleFirstDate} - ${value81.saleSecondDate}"                ,

                    hintStyle:   GoogleFonts.poppins(
                      color: clB1B1B1,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 0.14,
                    ),
                    border: InputBorder.none,
                    suffixIcon: SizedBox(
                        width: width * .12,
                        child: const Icon(Icons.calendar_month_outlined, color: Colors.black, size: 22)
                    ),
                  ),
                  onChanged: (text) {

                  },
                ),
              );
            }
          ),
          const SizedBox(height: 10,),
          Consumer<AdminProvider>(
            builder: (context21,value456,child) {
              return Text("Total Earnings : ₹ ${getAmount(value456.totalAmountCollected)}",
              style: GoogleFonts.inter(
                color: cl1B4341,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),);
            }
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Consumer<AdminProvider>(
              builder: (context12,adPro,child) {
                return  adPro.filterSalesReportList.isNotEmpty?ListView.builder(
                    itemCount: adPro.filterSalesReportList.length,
                    itemBuilder: (context, index) {
                      var item=adPro.filterSalesReportList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10,left: 14,right: 14),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 9),
                        // height: 140,
                        decoration: BoxDecoration(
                            color: clFFFFFF,
                            borderRadius: BorderRadius.circular(21),
                            boxShadow: [
                              BoxShadow(
                                  color: clBDBDBD.withOpacity(0.25),
                                  offset: const Offset(2, 4),
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 88,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      color: clCDCDCD,
                                      borderRadius: BorderRadius.circular(25),
                                      image:  DecorationImage(
                                          image: NetworkImage(item.bookImage),
                                          fit: BoxFit.cover)),
                                ),

                                 const SizedBox(width: 8,),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width*0.5,
                                      child: Text(
                                        item.bookName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                            color: cl353535,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                           ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                      Text(
                                      item.authorName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: cl5B5B5B,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "PoppinsRegular"),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                  ],
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(height: 3),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 7.0),
                                          child: Text("₹${item.price}",
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: clBlack
                                              )),
                                        ),
                                      ],))
                              ],
                            ),
                             const SizedBox(height: 5,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(),
                                Column(
                                  children: [
                                    Text("Sold",
                                        style : GoogleFonts.poppins(
                                          fontSize : 11,
                                          fontWeight : FontWeight.w400,
                                          color : cl767676.withOpacity(0.9),
                                        )
                                    ),
                                    Text( "${item.totalCount.toStringAsFixed(0)} Pcs",
                                        style : GoogleFonts.poppins(
                                          fontSize : 11,
                                          fontWeight : FontWeight.w600,
                                          color : clBlack,
                                        )
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Total Earning",
                                        style : GoogleFonts.poppins(
                                          fontSize : 11,
                                          fontWeight : FontWeight.w400,
                                          color : cl767676.withOpacity(0.9),
                                        )
                                    ),
                                    Text("₹${getAmount(item.totalPrice)}",
                                        style : GoogleFonts.inter(
                                          fontSize : 11,
                                          fontWeight : FontWeight.w600,
                                          color : clBlack,
                                        )
                                    )
                                  ],
                                ),

                              ],
                            )
                          ],
                        ),
                      );
                    }):Container(
                  height: height*.45,
                  alignment: Alignment.center,
                  child: const Text(
                    "No Date Found",
                    style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
  formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}
