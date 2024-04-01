import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_book_latest/AdminScreens/addBook%20_Screen.dart';
import 'package:grace_book_latest/AdminScreens/add_E_Book_Screen.dart';
import 'package:grace_book_latest/AdminScreens/add_carousel_page.dart';
import 'package:grace_book_latest/AdminScreens/orders_screen.dart';
import 'package:grace_book_latest/AdminScreens/payment_report_screen.dart';
import 'package:grace_book_latest/AdminScreens/sales_report_screen.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/Providers/login_provider.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import 'add_advertisement.dart';
import 'admin_delivery_details.dart';

class AdminHomeScreen extends StatelessWidget {
  final String userId;
  final String userName;
  final String userNumber;
  final String userType;

  const AdminHomeScreen({super.key, required this.userId, required this.userName, required this.userNumber, required this.userType});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var outputDayNode2 = DateFormat('dd/MM/yy');
    return Scaffold(

      body: SingleChildScrollView(
        child: Consumer<AdminProvider>(
          builder: (context34,value8,child) {
            return Column(
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
                            Consumer<AdminProvider>(
                              builder: (context,value969,child) {
                                return InkWell(
                                  onTap: () async {
                                    value969.logOut(context);
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                        // color: clF7F7F7.withOpacity(0.2),
                                        image: DecorationImage(image: NetworkImage("https://foihus.org/wp-content/uploads/2020/10/teammember-500x500-1-400x400.jpg")),
                                        shape: BoxShape.circle),
                                  ),
                                );
                              }
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Consumer<AdminProvider>(
                              builder: (context,value858,child) {
                                return Row(
                                  children: [
                                    Image.asset("assets/library.png",color: cl1B4341),
                                     Text(value858.totalSoledBook.toString(),
                                      style: TextStyle(
                                        color: cl1B4341,
                                        fontSize: 27,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w800,

                                      ),)
                                  ],
                                );
                              }
                            ),
                            const Text("Sold Books",
                              style: TextStyle(
                                color: cl1B4341,
                                fontSize: 13.5,
                                fontFamily: "PoppinsRegular",
                                fontWeight: FontWeight.w600,
                              ),)
                          ],
                        ),
                      ),
                      Consumer<AdminProvider>(
                        builder: (context,value456,child) {
                          return Container(
                            child:  Column(
                              children: [
                                Row(
                                  children: [
                                    // Image.asset("assets/library.png",color: cl1B4341,),
                                    Icon(Icons.currency_rupee,color: cl1B4341,weight: 20),
                                    Text(getAmount(value456.totalAmountCollected),
                                      style: TextStyle(
                                        color: cl1B4341,
                                        fontSize: 27,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w800,

                                      ),)
                                  ],
                                ),
                                Text("Collected Amount",
                                  style: TextStyle(
                                    color: cl1B4341,
                                    fontSize: 13.5,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w600,
                                  ),)
                              ],
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  // 189
                  height: height*.26,
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/homeBgrnd.png"),fit:BoxFit.fill),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                callNext(AddEbookScreen(from: "NEW",bookId:"", userName: userName, userId: userId ,), context);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/addEbook.png"),
                                  const Text("\nAdd E-Book",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                callNext(AddBookScreen(from: "NEW",bookId: "", userName: userName, userId: userId,), context);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/addEbook.png"),
                                  const Text("\nAdd Book",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                value8.fetchCarouselImages();
                                callNext(AddCarousel(), context);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/addCarousel.png"),
                                  const Text("\nAdd Carousel",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                value8.advertisementFile=null;
                                value8.fetchAdvertisement();
                                callNext(const AddAdvertisement(), context);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/addAdvertisement.png"),
                                  const Text("Add\nAdvertisement",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          InkWell(
                            onTap: (){
                              var todayDate = DateTime.now();
                             var tod =  todayDate.add(const Duration(hours: 24));
                             var tod2 = todayDate.subtract(Duration(
                                 hours: todayDate.hour,
                                 minutes: todayDate.minute,
                                 seconds: todayDate.second));
                              value8.adminOrderListDateWise(tod2,tod);
                              callNext(const PaymentReports(), context);
                            },
                            child: Container(
                              height: 44,
                              width: width*.37,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: cl1B4341,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Payment Reports ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12
                                    ),),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                    color: Colors.white,
                                    size: 15,)
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              callNext(const SalesReportScreen(), context);
                            },
                            child: Container(
                              height: 44,
                              width: width*.37,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: cl1B4341,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sales Reports ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12
                                    ),),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                    color: Colors.white,
                                    size: 15,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child:  Row(
                          children: [
                            const Text("Latest Orders",
                              style: TextStyle(
                                color: cl1B4341,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",

                              ),),
                            const SizedBox(width: 5,),
                            Container(
                              height: 28,
                              width: 28,
                              alignment: Alignment.center,
                              decoration:  BoxDecoration(
                                  color: clB6B6B6.withOpacity(0.4),
                                  shape: BoxShape.circle),
                              child:  Text(value8.adminOrderModelList.length.toString(),
                                style: TextStyle(
                                  color: cl1B4341,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Poppins",

                                ),),
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          value8.fetchAdminOrderPlaced();
                          value8.fetchAdminOrderDispatched();
                          value8.fetchAdminOrderDelivered();

                          callNext(OrdersScreen(initialTab: 0,userId: userId,userName:  userName,), context);
                        },
                        child: Container(
                          width: 150,
                          alignment: Alignment.center,
                          height: 43,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: clE8AD14,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const  Text(
                            'More Orders',
                            style: TextStyle(
                              color: cl1B4341,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Consumer<AdminProvider>(
                    builder: (context,value000,child) {
                      return ListView.builder(
                        itemCount: value000.adminOrderModelList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var item =  value000.adminOrderModelList[index];
                          return InkWell(
                            onTap: () {
                              callNext(AdminDeliveryDetails(item: item,userName: userName,userId: userId), context);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 7),
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
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
                                    flex: 7,
                                    child:  Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                              image: const DecorationImage(
                                                  image: NetworkImage("https://foihus.org/wp-content/uploads/2020/10/teammember-500x500-1-400x400.jpg"),
                                                  fit: BoxFit.fill)
                                          ),
                                        ),
                                        const SizedBox(width: 8,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                child: Text("Order Date : ${outputDayNode2.format(item.orderDate.toDate())}",
                                                    style: GoogleFonts.inter(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 13,
                                                      color: clF00000.withOpacity(0.7),

                                                    ),
                                                    overflow:TextOverflow.ellipsis)
                                            ),

                                          ],
                                        ),


                                      ],
                                    ),),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 3),
                                          Text("₹${item.amount}",
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: clBlack
                                              )),
                                        ],))
                                ],
                              ),
                            ),
                          );
                        },);
                    }
                  ),
                ),

              ],
            );
          }
        ),
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