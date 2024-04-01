import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Model/store_book_model.dart';
import '../UserScreens/payment_Receipt_Screen.dart';
import '../UserScreens/user_home_bottom_navigation_bar.dart';


class PaymentSuccessScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userPhone;
  final String orderCount;
  final String amount;
  final String paymentStatus;
  StoreBookModel storeBookList;

   PaymentSuccessScreen({super.key,required this.userId,required this.userName,required this.userPhone,required this.orderCount,required this.amount,required this.paymentStatus,required this.storeBookList});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      MainProvider mainProvider =
      Provider.of<MainProvider>(context, listen: false);
      print(mainProvider.donorStatus.toString() + "11144555");

      if (widget.paymentStatus == "SUCCESS") {
        print("wise code here");
        callNextReplacement(PaymentReceiptScreen(storeBookList: widget.storeBookList, userId: widget.userId,
          userName:widget.userName, userPhone: widget.userPhone, orderCount: widget.orderCount, amount:widget.amount,), context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context9,value9,child) {
          return widget.paymentStatus== "SUCCESS"?Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:height*.1 ,),

              const Center(
                child: Text(
                  "Payment Success",

                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff039d46),
                    height: 30/25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "Order Placed",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff039d46),
                  height: 17/14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height*.15,),
              Lottie.asset('assets/paymentsuccessful.json',width: width,
              height: height*.35,)



            ],
          ): Column(
            children: [
              SizedBox(height:height*.1 ,),
              const Center(
                child: Text(
                  "Payment Failed ",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff404040),
                    height: 30/25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "Please Try Again",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffd90000),
                  height: 17/14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height*.18,),
          Lottie.asset('assets/paymentfailed.json',width:width,height:  height*.2 ),
          SizedBox(height: height*.3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      callNextReplacement( UserHomeBottom(loginStatus: 'Logged', userDocId:widget.userId, userName: widget.userName, userPhone: widget.userPhone, index: 0,), context);
                    },
                    child: Container(
                      width: 110,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Color(0xFFE8AD14)),
                          borderRadius: BorderRadius.circular(54),
                        ),
                      ),
                      child: const Text(
                        'Home',
                        style: TextStyle(
                          color:Colors.black,
                          fontSize: 9,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: 0.90,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      // callNextReplacement( UserHomeBottom(loginStatus: 'Logged', userDocId:widget.userId,), context);
                    },
                    child: Container(
                      width: 110,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFE8AD14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(54),
                        ),
                      ),
                      child: const Text(
                        'Retry',
                        style: TextStyle(
                          color:Colors.black,
                          fontSize: 9,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: 0.90,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        }
      ),


    );
  }
}
