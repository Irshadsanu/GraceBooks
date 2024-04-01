import 'dart:collection';

import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../Providers/login_provider.dart';
import '../Providers/timer_provider.dart';
import '../constants/my_colors.dart';

enum MobileVarificationState { SHOW_MOBILE_FORM_STATE, SHOW_OTP_FORM_STATE }

class LoginScreenAdmin extends StatefulWidget {
  const LoginScreenAdmin({super.key});

  @override
  State<LoginScreenAdmin> createState() => _LoginScreenAdminState();
}

class _LoginScreenAdminState extends State<LoginScreenAdmin> {
  MobileVarificationState currentSate =
      MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FocusNode _pinPutFocusNode = FocusNode();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String VerificationId = "";
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

  void fixedOtpChecking() {
    fixedOtpList.clear();

    setState(() {
      mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
        if (databaseEvent.snapshot.exists) {
          print("object");
          fixedOtpList.clear();
          Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

          map.forEach((key, value) {
            print("va${value}df${key}");
            fixedOtpList.add(key.toString());
          });

          print(fixedOtpList.toString() + "ef");
          print(fixedOtpList.contains("9048001001"));
        }
      });
    });
  }

  void checkValueForKey(String targetKey, String pin) {
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

              if (valueControllerValue == pin) {
                loginProvider.adminAuthorized(
                    "LOGIN", "+91${phoneController.text}", "tocken", context);
              }
            }
          });
        }
      });
    });
  }

  Future<void> otpsend(BuildContext context) async {
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
                userId: ID.unique(), phone: '+91${phoneController.text}');

            VerificationId = sessionToken.userId;
            tocken = sessionToken.$id;

            setState(() {
              showLoading = false;
              currentSate = MobileVarificationState.SHOW_OTP_FORM_STATE;
              TimeProvider timeProvider =
                  Provider.of<TimeProvider>(context, listen: false);

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("OTP sent to phone successfully"),
                duration: Duration(milliseconds: 3000),
              ));
            });
          } catch (e) {
            if (e is AppwriteException) {
              setState(() {
                showLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Sorry, Verification Failed"),
                duration: Duration(milliseconds: 3000),
              ));
            } else {
              setState(() {
                showLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Sorry, Verification Failed"),
                duration: Duration(milliseconds: 3000),
              ));
              // Handle other types of exceptions or errors
              print('An unexpected error occurred: $e');
            }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Admin not found"),
            duration: Duration(milliseconds: 3000),
          ));
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

        LoginProvider loginProvider = LoginProvider();
        var phone = phoneController.text.trim();
        db
            .collection("USERS")
            .where("PHONE", isEqualTo: phone)
            .get()
            .then((value) async {
          if (value.docs.isNotEmpty) {
            loginProvider.adminAuthorized(
                "LOGIN", "+91$phone", tocken, context);
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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                width: 231.50,
                height: 110.49,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/gracelogo.png"),
                        fit: BoxFit.fill)),
              ),
              const Spacer(),
              const Text(
                'Log In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF404040),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: width / 1.1,
                decoration: BoxDecoration(
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
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: cl404040,
                      fontSize: 13,
                      fontFamily: "PoppinsRegular"),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    labelStyle: const TextStyle(
                        color: cl7A7A7A,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(width: 0.4, color: clWhite)),
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
                  onChanged: (value) {
                    setState(() {
                      if (value.length == 10) {
                        showTick = true;
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      } else {
                        showTick = false;
                      }
                    });
                  },
                ),
              ),
              currentSate == MobileVarificationState.SHOW_OTP_FORM_STATE
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: height / 83,
                        ),
                        const Text(
                          "OTP",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              fontFamily: "PoppinsRegular"),
                        ),
                        SizedBox(
                          height: height / 83,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  // Black color with opacity 0.05 (0D) using hexadecimal representation
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
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: cl404040,
                                        fontFamily: "PoppinsRegular"),
                                    bgColorBuilder:
                                        const FixedColorBuilder(clWhite),
                                    strokeColorBuilder:
                                        const FixedColorBuilder(clWhite)),
                                onCodeChanged: (pin) {
                                  if (pin!.length == 6) {
                                    if (fixedOtpList
                                        .contains(phoneController.text)) {
                                      checkValueForKey(
                                          phoneController.text.toString(),
                                          otpController.text.toString());
                                    } else {
                                      verify();
                                    }
                                  }
                                }),
                          ),
                        ),

                        SizedBox(
                          height: height / 43,
                        ),

                        // const SizedBox(height: 20,),
                      ],
                    )
                  : SizedBox(
                      height: height / 83,
                    ),
              SizedBox(
                height: height / 83,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (showTick) {
                      if (fixedOtpList
                          .contains(phoneController.text.toString())) {
                        setState(() {
                          currentSate =
                              MobileVarificationState.SHOW_OTP_FORM_STATE;
                        });
                      } else {
                        otpsend(context,);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("invalid Mobile Number",
                            style: TextStyle(color: Colors.white)),
                        duration: Duration(milliseconds: 3000),
                      ));
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 324,
                  height: 44,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 77, vertical: 10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1B4341),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(43),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height / 83,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
