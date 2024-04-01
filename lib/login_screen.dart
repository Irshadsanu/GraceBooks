import 'dart:collection';

import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/UserScreens/user_home_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'Providers/login_provider.dart';
import 'Providers/timer_provider.dart';
import 'constants/myWidgets.dart';
import 'constants/my_colors.dart';
import 'constants/my_functions.dart';



enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FocusNode _pinPutFocusNode = FocusNode();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String VerificationId ="";
  late var tocken;
  bool showLoading = false;
  bool showTick = false;
  LoginProvider loginProvider = LoginProvider();
  // TimeProvider timeProvider = TimeProvider();

  Client client = Client();

  @override
  void initState() {
    super.initState();
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('65dc6461e783c157ea1a')
        .setSelfSigned(status: true);
    fixedOtpChecking();
  }

  List<String> fixedOtpList = [];

  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  void fixedOtpChecking(){
    fixedOtpList.clear();

    setState(() {


      mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
        if(databaseEvent.snapshot.exists){
          print("object");
          fixedOtpList.clear();
          Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

          map.forEach((key, value) {
            print("va${value}df${key}");
            fixedOtpList.add(key.toString());
          });

          print(fixedOtpList.toString()+"ef");
          print(fixedOtpList.contains("9048001001"));
        }
      });
    });


  }

  void checkValueForKey(String targetKey,String pin) {

    setState(() {
      mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
        if (databaseEvent.snapshot.exists) {
          Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

          map.forEach((key, value) {
            String keyControllerValue = key.toString();
            String valueControllerValue = value.toString();

            if (keyControllerValue == targetKey) {
              // The targetKey exists in the database
              // Do something with the corresponding value
              print("Value for key $targetKey is $valueControllerValue");

              if(valueControllerValue==pin){
                loginProvider.userAuthorized("LOGIN","+91${phoneController.text}", "tocken",context);
              }

            }
          });
        }
      });
    });
  }


  Future<void> otpsend(BuildContext context,String from) async {
    setState(() {
      showLoading = true;
    });
    if (showTick) {
      db
          .collection("USERS")
          .where("PHONE", isEqualTo: phoneController.text)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {

          final account = Account(client);
          try {
            final sessionToken = await account.createPhoneSession(
                userId: ID.unique(),
                phone: '+91${phoneController.text}');

            VerificationId = sessionToken.userId;
            tocken = sessionToken.$id;

            setState(() {
              showLoading = false;
              currentSate =
                  MobileVarificationState.SHOW_OTP_FORM_STATE;
              TimeProvider timeProvider =
              Provider.of<TimeProvider>(context, listen: false);
              if(from=="recent"){
                print("reset Count Down");

                timeProvider.resetCountdown();
                timeProvider.startCountdown();

              }else{
                print("Start Count Down");
                timeProvider.startCountdown();

              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                content: Text("OTP sent to phone successfully"),
                duration: Duration(milliseconds: 3000),
              ));
            });

          } catch (e) {
            if (e is AppwriteException) {
              setState(() {
                showLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar( const SnackBar(
                content: Text("Sorry, Verification Failed"),
                duration: Duration(milliseconds: 3000),
              ));
            } else {
              setState(() {
                showLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                content: Text("Sorry, Verification Failed"),
                duration: Duration(milliseconds: 3000),
              ));
              // Handle other types of exceptions or errors
              print('An unexpected error occurred: $e');
            }
          }
        }
        else {
          final account = Account(client);
          try {
            final sessionToken = await account.createPhoneSession(
                userId: ID.unique(),
                phone: '+91${phoneController.text}');

            VerificationId = sessionToken.userId;
            tocken = sessionToken.$id;

            setState(() {
              showLoading = false;
              currentSate =
                  MobileVarificationState.SHOW_OTP_FORM_STATE;
              TimeProvider timeProvider =
              Provider.of<TimeProvider>(context, listen: false);
              if(from=="recent"){
                print("reset Count Down");

                timeProvider.resetCountdown();
                timeProvider.startCountdown();

              }else{
                print("Start Count Down");
                timeProvider.startCountdown();

              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                content: Text("OTP sent to phone successfully"),
                duration: Duration(milliseconds: 3000),
              ));
            });

          } catch (e) {
            if (e is AppwriteException) {
              setState(() {
                showLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar( const SnackBar(
                content: Text("Sorry, Verification Failed"),
                duration: Duration(milliseconds: 3000),
              ));
            } else {
              setState(() {
                showLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                content: Text("Sorry, Verification Failed"),
                duration: Duration(milliseconds: 3000),
              ));
              // Handle other types of exceptions or errors
              print('An unexpected error occurred: $e');
            }
          }

        }
      });
    }


  }

  Future<void> verify() async {
    setState(() {
      showLoading = true;
    });
    final account = Account(client);
    try {

      final session = await account.updatePhoneSession(
          userId: VerificationId, secret: otpController.text);




      try {

        print("object ddddddd");




        print("sfsfsfsfsfsf");
        LoginProvider loginProvider = LoginProvider();
        var phone = phoneController.text.trim();
        db
            .collection("USERS")
            .where("PHONE", isEqualTo: phone)
            .get()
            .then((value) async {
          if (value.docs.isNotEmpty) {
            loginProvider.userAuthorized("LOGIN","+91$phone", tocken,context);
          } else {

            DateTime now = DateTime.now();

            String docId = now.millisecondsSinceEpoch.toString();
            HashMap<String, Object> userMap = HashMap();
            HashMap<String, Object> map = HashMap();

            userMap["ID"] = docId;
            userMap["REG_DATE"] = now;
            userMap["NAME"] = nameController.text;
            userMap["PHONE"] = phone;
            userMap["TYPE"] = "CUSTOMER";
            userMap["REF"] = "CUSTOMER/$docId";
            map["ID"] = docId;
            map["REG_DATE"] = now;
            map["NAME"] = nameController.text;
            map["PHONE"] = phone;
            map["TYPE"] = "CUSTOMER";
            db
                .collection("CUSTOMERS")
                .doc(docId)
                .set(map, SetOptions(merge: true));
            db
                .collection("USERS")
                .doc(docId)
                .set(userMap, SetOptions(merge: true));

            MainProvider mainProvider =
            Provider.of<MainProvider>(context, listen: false);
            mainProvider.fetchUserDetails(docId);
            callNextReplacement( UserHomeBottom(loginStatus: "Logged", userDocId: docId, userName: nameController.text, userPhone: phone, index: 0,), context);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('appwrite_token', tocken);
            prefs.setString('phone_number', phone);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Success"),
          duration: Duration(milliseconds: 3000),
        ));

        setState(() {
          showLoading = false;
        });

        if (kDebugMode) {
          print("Login Success");
        }

      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // Process the successful response if needed
    } catch (e) {
      if (e is AppwriteException) {
        // Handle AppwriteException
        final errorMessage = e.message ?? 'An error occurred.';

        // Display the error message using a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.purple,
          ),
        );
      } else {
        // Handle other types of exceptions or errors
        print('An unexpected error occurred: $e');
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: clF0F0F0,

      child: SafeArea(
        child: Scaffold(
          backgroundColor: clF0F0F0,
          body: Stack(
            children: [
              SizedBox(
                width: width,
                height: height,
                child: Column(

                  children: [
                    SizedBox(height: height/17.04081632653061,),

                    Image.asset("assets/gracelogo.png",scale: 4.5,),
                    SizedBox(height: height/15.18181818181818,),

                    SvgPicture.asset("assets/svg/freeloginAllusers.svg",
                        fit: BoxFit.fill),
                // Spacer(),

                  ],
                ),
              ),
              Positioned(
                bottom: 0,

                child: Container(
                  width: width,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1F000000), // Color with opacity
                          offset: Offset(0, -8), // Offset in the x, y dimensions
                          blurRadius: 42.8, // Spread radius
                          // Spread radius in CSS corresponds to blurRadius in Flutter BoxShadow
                        ),
                      ],
                      color: clWhite,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(44),
                          topLeft: Radius.circular(44)

                      )),
                  child: Padding(
                    padding:  EdgeInsets.all(width/22),
                    child: Column(
                      children: [
                        const Text("Log In",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "PoppinsRegular"),),

                        const SizedBox(height: 12,),
                        Container(
                          width:width ,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0D000000),
                                blurRadius: 7,
                                spreadRadius: 1,
                                offset: Offset(0, 0), // Adjust as needed
                              ),
                            ],
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: cl404040,
                                fontSize: 13,
                                fontFamily: "PoppinsRegular"
                            ),

                            controller: nameController,
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle:  const TextStyle(
                                color: cl7A7A7A,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(width: 0.4, color: clWhite)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 0.4, color: clWhite),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 0.4, color: clWhite),
                              ),
                              hintText: 'Name',
                              filled: true,
                              fillColor: clWhite,
                              hintStyle: const TextStyle(color: cl7A7A7A, fontSize: 12),

                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          width:width ,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0D000000),
                                blurRadius: 7,
                                spreadRadius: 1,
                                offset: Offset(0, 0), // Adjust as needed
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: phoneController,
                            style: const TextStyle(fontWeight: FontWeight.w500,color: cl404040,fontSize: 13,fontFamily: "PoppinsRegular"),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Mobile Number",
                              labelStyle:  const TextStyle(
                                  color: cl7A7A7A, fontFamily: 'PoppinsRegular', fontSize: 12,fontWeight: FontWeight.w700),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(width: 0.4, color: clWhite)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 0.4, color: clWhite),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 0.4, color: clWhite),
                              ),
                              hintText: 'Mobile Number',
                              filled: true,
                              fillColor: clWhite,
                              hintStyle: const TextStyle(color: cl7A7A7A, fontSize: 12),

                            ),
                            onChanged: (value){
                              setState(() {
                                if (value.length == 10) {
                                  showTick = true;
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                } else {
                                  showTick = false;
                                }
                              });
                            },
                          ),
                        ),

                        currentSate == MobileVarificationState.SHOW_OTP_FORM_STATE?  Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: height/83,),
                            const Text("OTP",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  fontFamily: "PoppinsRegular"
                              ),),
                            Consumer<TimeProvider>(
                              builder: (context, timePro, _){
                                return timePro.countdown!=0? RichText(
                                  text: TextSpan(text: "Valid ",
                                    style:const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9,
                                        fontFamily: "PoppinsRegular"
                                        ,color: clA7A7A7
                                    ),
                                    children: <TextSpan>[

                                      TextSpan(
                                        text: "${timePro.countdown}",
                                        style: const TextStyle(fontWeight: FontWeight.bold,color: clBlack,fontSize: 10),
                                      ),
                                      const TextSpan(
                                        text: ' Seconds',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 9,
                                            fontFamily: "PoppinsRegular",
                                          color: clA7A7A7
                                        )
                                      ),
                                    ],
                                  ),):const SizedBox();
                              }
                            ),
                            SizedBox(height: height/83,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x0D000000), // Black color with opacity 0.05 (0D) using hexadecimal representation
                                      blurRadius: 10.052813529968262,
                                      spreadRadius: 1.436116099357605,
                                      offset: Offset(0, 0), // No offset
                                    ),
                                  ],
                                ),
                                child: PinFieldAutoFill(
                                    codeLength: 6,
                                    controller: otpController,
                                    keyboardType: TextInputType.number,
                                    autoFocus: true,
                                    currentCode: "",
                                    decoration: BoxLooseDecoration(
                                        gapSpace: 10,
                                        radius: const Radius.circular(11),
                                        textStyle: const TextStyle(fontSize: 20, color: cl404040,fontFamily: "PoppinsRegular"),
                                        bgColorBuilder: const FixedColorBuilder(clWhite),
                                        strokeColorBuilder: const FixedColorBuilder(clWhite)),
                                    onCodeChanged: (pin) {
                                      if (pin!.length == 6) {
                                        if(fixedOtpList.contains(phoneController.text)){
                                          checkValueForKey(phoneController.text.toString(),otpController.text.toString());
                                        }else{

                                          verify();
                                        }
                                      }
                                    }),
                              ),
                            ),
                            SizedBox(height: height/43,),

                            Consumer<TimeProvider>(
                                builder: (context, timePro, _) {
                                  return  timePro.countdown!=0?const SizedBox():

                                  GestureDetector(
                                    onTap: (){
                                      setState(() {

                                        if(showTick){
                                          if(fixedOtpList.contains(phoneController.text.toString())){
                                            setState(() {
                                              currentSate = MobileVarificationState
                                                  .SHOW_OTP_FORM_STATE;
                                            });

                                          }else{
                                            otpsend(context,"recent");
                                          }


                                        }else{
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text("invalid Mobile Number",style: TextStyle(color: Colors.white)),
                                            duration: Duration(milliseconds: 3000),
                                          ));
                                        }
                                      });

                                    },
                                    child: const SizedBox(
                                      child: Text("Recent OTP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 9,
                                            fontFamily: "PoppinsRegular"
                                        ),),
                                    ),
                                  );
                                }
                            ),
                            SizedBox(height: height/43,),

                            // const SizedBox(height: 20,),
                          ],
                        ) :  SizedBox(height: height/83,),

                        SizedBox(
                          width:width,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {

                                if(showTick){
                                  if(fixedOtpList.contains(phoneController.text.toString())){
                                    setState(() {
                                      currentSate = MobileVarificationState
                                          .SHOW_OTP_FORM_STATE;
                                    });

                                  }else{
                                    otpsend(context,"login");
                                  }


                                }else{
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("invalid Mobile Number",style: TextStyle(color: Colors.white)),
                                    duration: Duration(milliseconds: 3000),
                                  ));
                                }
                              });

                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(43),
                              ), backgroundColor: cl1B4341, // Background color
                              elevation: 10, // Shadow elevation
                            ),
                            child: showLoading
                                ? waitingIndicator
                                : const Text(
                              "Log In",
                              style: TextStyle(
                                color: clWhite,
                                fontSize: 13,
                                fontFamily: "PoppinsRegular",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )


                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }

  // Widget otpWidget(BuildContext context)   {
  //   var height = MediaQuery.of(context).size.height;
  //   var width = MediaQuery.of(context).size.width;
  //   return  SingleChildScrollView(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         SizedBox(height: height/83,),
  //
  //         const Text("OTP",
  //           style: TextStyle(
  //               fontWeight: FontWeight.w700,
  //               fontSize: 14,
  //               fontFamily: "PoppinsRegular"
  //           ),),
  //         Consumer<TimeProvider>(
  //             builder: (context, timePro, _) {
  //               print(timePro.countdown);
  //               print("hai");
  //             return  timePro.countdown!=0?
  //
  //
  //               Text("${timePro.countdown}",
  //               style: const TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 9,
  //                   fontFamily: "PoppinsRegular"
  //               ),): const SizedBox();
  //           }
  //         ),
  //          SizedBox(height: height/83,),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 15),
  //           child: Container(
  //             decoration:  BoxDecoration(
  //               borderRadius: BorderRadius.circular(8),
  //               boxShadow: const [
  //                 BoxShadow(
  //                   color: Color(0x0D000000), // Black color with opacity 0.05 (0D) using hexadecimal representation
  //                   blurRadius: 10.052813529968262,
  //                   spreadRadius: 1.436116099357605,
  //                   offset: Offset(0, 0), // No offset
  //                 ),
  //               ],
  //             ),
  //             child: PinFieldAutoFill(
  //                 codeLength: 6,
  //                  controller: otpController,
  //                 keyboardType: TextInputType.number,
  //                 autoFocus: true,
  //                 currentCode: "",
  //                 decoration: BoxLooseDecoration(
  //                     gapSpace: 10,
  //                     radius: const Radius.circular(11),
  //                     textStyle: const TextStyle(fontSize: 20, color: cl404040,fontFamily: "PoppinsRegular"),
  //                     bgColorBuilder: const FixedColorBuilder(clWhite),
  //                     strokeColorBuilder: const FixedColorBuilder(clWhite)),
  //                 onCodeChanged: (pin) {
  //                   if (pin!.length == 6) {
  //                     if(fixedOtpList.contains(phoneController.text)){
  //                       checkValueForKey(phoneController.text.toString(),otpController.text.toString());
  //                     }else{
  //
  //                       verify();
  //                     }
  //                   }
  //                 }),
  //           ),
  //         ),
  //         SizedBox(height: height/43,),
  //
  //         Consumer<TimeProvider>(
  //             builder: (context, timePro, _) {
  //               return  timePro.countdown!=0?const SizedBox():
  //
  //               GestureDetector(
  //                 onTap: (){
  //                   setState(() {
  //
  //                     if(showTick){
  //                       if(fixedOtpList.contains(phoneController.text.toString())){
  //                         setState(() {
  //                           currentSate = MobileVarificationState
  //                               .SHOW_OTP_FORM_STATE;
  //                         });
  //
  //                       }else{
  //                         otpsend("recent");
  //                       }
  //
  //
  //                     }else{
  //                       ScaffoldMessenger.of(context)
  //                           .showSnackBar(const SnackBar(
  //                         backgroundColor: Colors.red,
  //                         content: Text("invalid Mobile Number",style: TextStyle(color: Colors.white)),
  //                         duration: Duration(milliseconds: 3000),
  //                       ));
  //                     }
  //                   });
  //
  //                 },
  //                 child: const SizedBox(
  //                   child: Text("Recent OTP",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 9,
  //                         fontFamily: "PoppinsRegular"
  //                     ),),
  //                 ),
  //               );
  //             }
  //         ),
  //         SizedBox(height: height/43,),
  //
  //         // const SizedBox(height: 20,),
  //       ],
  //     ),
  //   );
  // }


}
