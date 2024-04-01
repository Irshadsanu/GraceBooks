import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class PaymentReports extends StatelessWidget {
  const PaymentReports({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    String firstDate = "DD/MM/YYYY";
    String lastDate = "DD/MM/YYYY";
    AdminProvider adminProvider = Provider.of<AdminProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: Container(
              decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xffB6B6B6).withOpacity(.17)),
                height: 35,
                width: 35,
                child: const Icon(
                  Icons.chevron_left,
                  color: clBlack,
                  size: 30,
                ))),
        title:  const Text("Payment Reports",
            style: TextStyle(
                color: clBlack,
                fontFamily: "PoppinsRegular",
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),

      body: Column(
        children: [
          SizedBox(height: 15),
          Container(width: width,height: 75,
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.symmetric(horizontal: 26,vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage("assets/payRepBg.png"),fit: BoxFit.fill),
            ),
            child: Consumer<AdminProvider>(
              builder: (context,value741,child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: width/4,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SvgPicture.asset(
                                'assets/svg/soldBook.svg',
                              ),
                            ),
                            Text("${value741.totalSoledBook}",style: TextStyle(color: clWhite,fontSize: 24,fontWeight: FontWeight.bold,fontFamily: "PoppinsRegular"),),
                          ],
                        ),
                        Text("Sold Books",style: TextStyle(color: clWhite,fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "PoppinsRegular"),)

                      ],
                    ),
                    ),
                    SizedBox(width: width/2.5,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SvgPicture.asset(
                                'assets/svg/₹.svg',
                              ),
                            ),
                            Text(getAmount(double.parse(value741.totalAmountCollected.toStringAsFixed(0))),style: const TextStyle(color: clWhite,fontSize: 24,fontWeight: FontWeight.bold,fontFamily: "PoppinsRegular"),),
                          ],
                        ),
                        Text("   Collected Amount",style: TextStyle(color: clWhite,fontSize: 10,fontWeight: FontWeight.w500,fontFamily: "PoppinsRegular"),)

                      ],
                    ),
                    ),

                  ],
                );
              }
            ),
          ),

          SizedBox(height: 10,),

          Consumer<AdminProvider>(
            builder: (context,value789,child) {
              return Container(
                width: width * .9,
                height: 40,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
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
                  decoration: InputDecoration(
                    suffixIcon: SizedBox(
                      width: width * .12,
                      child:
                          Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          const Icon(Icons.search,
                              color: Colors.black,
                              size: 22),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: SvgPicture.asset(
                              'assets/svg/filter.svg',height: 20,
                            ),
                          ),
                        ],
                      )

                    ),
                    contentPadding:
                    const EdgeInsets.only(bottom: 1),
                    hintText: 'Search here..',
                    hintStyle: const TextStyle(
                      color: Color(0xFFB1B1B1),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.14,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    value789.filterAdminpaymentReport(text);
                  },
                ),
              );
            }
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<AdminProvider>(
                  builder: (context,value456,child) {
                    return InkWell(
                      onTap: () {
                        value456.exportExcel(value456.filterAdminAllOrderModelList);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                            color: clWhite,
                            boxShadow:[
                              BoxShadow(
                                color: Colors.black38.withOpacity(.05), // Shadow color
                                blurRadius: 6, // Spread of the shadow
                                offset: const Offset(0, 4), // Offset of the shadow
                              ),
                            ]
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/excel.png',height: 30,width: 20,
                            ),
                            const SizedBox(width: 4),
                            const Text("Export to\nExcel",style: TextStyle(color: clBlack,fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "PoppinsRegular"),)
                          ],
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(width: 10,),
                Consumer<AdminProvider>(
                  builder: (context,value121,child) {
                    return InkWell(
                      onTap: () {
                        value121.showCalendarDialog(context,"PAYMENT_REPORT");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 17,horizontal: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                            color: clWhite,
                            boxShadow:[
                              BoxShadow(
                                color: Colors.black38.withOpacity(.05), // Shadow color
                                blurRadius: 6, // Spread of the shadow
                                offset: const Offset(0, 4), // Offset of the shadow
                              ),
                            ]
                        ),
                        child: Row(
                          children:[
                            Text("${value121.selectedFirstDate} - ${value121.selectedSecondDate}",style: const TextStyle(color: Color(0xffB1B1B1),fontSize: 10,fontWeight: FontWeight.w500,fontFamily: "PoppinsRegular"),),
                            const Icon(Icons.calendar_month_outlined,color: clBlack)
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),

          Expanded(
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Consumer<AdminProvider>(
                  builder: (context,value444,child) {
                    return value444.filterAdminAllOrderModelList.isEmpty?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/out-of-stock.png"),opacity: 0.7)),
                            ),
                            Text("No data Found !",
                                style: TextStyle(
                                    color: clBlack,
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))
                          ],
                        )

                        :ListView.builder(
                      itemCount: value444.filterAdminAllOrderModelList.length,
                      itemBuilder: (context, index) {
                        var item = value444.filterAdminAllOrderModelList[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color: clWhite,
                            boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05), // Shadow color
                            blurRadius: 6, // Spread of the shadow
                            offset: const Offset(0, 4), // Offset of the shadow
                          ),
                        ]),
                        width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 50,child: Text("Name",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clA7A7A7),)),
                                  Text(" : ",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clBlack),),
                                  Text(item.customerName,style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clBlack),),
                                ],
                              ),
                              Text("₹ ${item.amount}",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.bold,fontSize: 14,color: clBlack),),


                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 50,child: Text("Mobile",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clA7A7A7),)),
                                  Text(" : ",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clBlack),),
                                  Text(item.customerPhone,style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clBlack),),

                                ],
                              ),
                              Text(DateFormat('dd-MM-yy hh:mm aa' ).format(item.orderDate.toDate()),style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 8,color: clA7A7A7),),

                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 50,child: Text("Books",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clA7A7A7),)),
                              Text(" : ",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clBlack),),
                              Expanded(
                                // width: 200,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: item.items.length,
                                  itemBuilder: (context, index) {
                                    var listItem = item.items[index];
                                    return  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: 160,
                                            child: Text(listItem.itemName,style: const TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 12,color: clBlack),overflow:TextOverflow.ellipsis)),
                                        Text(listItem.itemPrice,style:  const TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w700,fontSize: 8,color: Colors.black))
                                        
                                      ],
                                    );
                                  }
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      );
                    },);
                  }
                ),
              )
          ),

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