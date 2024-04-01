import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UserScreens/home_Screen.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import 'MainProvider.dart';

class WidgetProvider extends ChangeNotifier{

  void bottomSheet(
      BuildContext context99, double height, double width, String userDocId) {
    showModalBottomSheet(
      enableDrag: true,
      scrollControlDisabledMaxHeightRatio: .9,
      backgroundColor: clFEFEFE,
      context: context99,
      builder: (BuildContext context) {
        bool _keyboardVisible = false;

        _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

        return Consumer<MainProvider>(builder: (context4, mainPro, _) {
          return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24)),
                      child: ClipPath(
                        clipper: CustomShape(),
                        // this is my own class which extendsCustomClipper
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 110,
                            decoration: const BoxDecoration(
                              color: cl1B4341,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24)),
                            ),
                            alignment: Alignment.center,
                            child: AppBar(
                              leading: Image.asset("assets/logo.png"),
                              centerTitle: true,
                              title: const Text(
                                "Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 14,
                                    color: clF0F0F0),
                              ),
                              backgroundColor: Colors.transparent,
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    finish(context);
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                        color: clF7F7F7.withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    Consumer<MainProvider>(builder: (context, maiPro, _) {
                      return GestureDetector(
                        onTap: () {
                          if (maiPro.personalDetailsEdit) {
                            maiPro.showBottomSheet(context);
                          }
                        },
                        child: maiPro.fileImage != null
                            ? Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(maiPro.fileImage!),
                                  fit: BoxFit.fill)),
                        )
                            : maiPro.userProfileImage != ""
                            ? Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      maiPro.userProfileImage),
                                  fit: BoxFit.fill)),
                        )
                            : Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: width / 1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Personal Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 12,
                                      color: cl303030),
                                ),
                                Consumer<MainProvider>(
                                    builder: (context, mainPro, _) {
                                      return GestureDetector(
                                        onTap: () async {
                                          if (mainPro.personalDetailsEdit &&
                                              (mainPro.numberVerified ||
                                                  mainPro.userPhoneController.text ==
                                                      mainPro.userNumber)) {
                                            print("saved");
                                            mainPro.editPersonalDetails(userDocId);
                                            SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                            // prefs.setString('appwrite_token', tocken);
                                            prefs.setString('phone_number',
                                                mainPro.userPhoneController.text);
                                            // mainPro.personalDetailEditClick();
                                          }

                                          if (mainPro.userPhoneController.text !=
                                              mainPro.userNumber) {
                                            mainPro.userPhoneController.text =
                                                mainPro.userNumber;
                                          }

                                          mainPro.personalDetailEditClick();
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 42,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                color: mainPro.personalDetailsEdit
                                                    ? clE8AD14
                                                    : clWhite,
                                                borderRadius: BorderRadius.circular(6)),
                                            child: Text(
                                              mainPro.personalDetailsEdit
                                                  ? "Save"
                                                  : "Edit",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontSize: 12,
                                                  color: cl303030),
                                            )),
                                      );
                                    })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 81,
                          ),
                          Consumer<MainProvider>(builder: (context, value1, _) {
                            return value1.personalDetailsEdit
                                ? ProfileTextFormWidget(
                              width: width,
                              label: 'Name',
                              controller: value1.userNameController,
                              enable: value1.personalDetailsEdit,
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: 'Name',
                              tail: value1.userName,
                            );
                          }),
                          SizedBox(
                            height: height / 81,
                          ),
                          Consumer<MainProvider>(builder: (context, value2, _) {
                            return value2.personalDetailsEdit
                                ? EditPhoneWidget(
                              width: width,
                              height: height,
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: 'Mobile Number',
                              tail: value2.userNumber,
                            );
                          }),
                          SizedBox(
                            height: height / 81,
                          ),
                          SizedBox(
                            width: width / 1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 12,
                                      color: cl303030),
                                ),
                                Consumer<MainProvider>(
                                    builder: (context89, main, _) {
                                      return GestureDetector(
                                        onTap: () async {
                                          main.deliveryDetailEditClick();
                                          if (mainPro.deliveryDetailsEdit) {
                                            print("saved${mainPro.userPinCodeController.text}");
                                            bool pincodeStatus =
                                            await mainPro.getPinCodeApi(
                                                mainPro.userPinCodeController.text);
                                            if (pincodeStatus) {
                                              print("condition true");
                                              mainPro.addDeliveryAddress(userDocId);
                                            } else {
                                              /// top snackBar needed
                                            }
                                          }
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 42,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                color: main.deliveryDetailsEdit
                                                    ? clE8AD14
                                                    : clWhite,
                                                borderRadius: BorderRadius.circular(6)),
                                            child: Text(
                                              main.deliveryDetailsEdit
                                                  ? "Save"
                                                  : "Edit",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontSize: 12,
                                                  color: cl303030),
                                            )),
                                      );
                                    })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 81,
                          ),
                          Consumer<MainProvider>(builder: (context, value3, _) {
                            return value3.deliveryDetailsEdit
                                ? ProfileTextFormWidget(
                              width: width,
                              label: 'Address',
                              controller: value3.userAddressController,
                              enable: value3.deliveryDetailsEdit,
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: "Address",
                              tail: value3.userAddress,
                            );
                          }),
                          SizedBox(
                            height: height / 81,
                          ),
                          // Consumer<MainProvider>(builder: (context, value4, _) {
                          //   return value4.deliveryDetailsEdit
                          //       ? ProfileTextFormWidget(
                          //           width: width,
                          //           label: 'State',
                          //           controller: value4.userStateController,
                          //           enable: value4.deliveryDetailsEdit,
                          //         )
                          //       : ProfileDetailWidget(
                          //           width: width,
                          //           height: height,
                          //           head: "State",
                          //           tail: value4.userState,
                          //         );
                          // }),
                          // SizedBox(
                          //   height: height / 81,
                          // ),
                          // Consumer<MainProvider>(builder: (context, value5, _) {
                          //   return value5.deliveryDetailsEdit
                          //       ? ProfileTextFormWidget(
                          //           width: width,
                          //           label: 'District',
                          //           controller: value5.userDistrictController,
                          //           enable: value5.deliveryDetailsEdit,
                          //         )
                          //       : ProfileDetailWidget(
                          //           width: width,
                          //           height: height,
                          //           head: "District",
                          //           tail: value5.userDistrict,
                          //         );
                          // }),
                          // SizedBox(
                          //   height: height / 81,
                          // ),
                          Consumer<MainProvider>(builder: (context, value7, _) {
                            return value7.deliveryDetailsEdit
                                ? ProfileTextFormWidgetNumber(
                              width: width,
                              label: 'PIN',
                              controller: value7.userPinCodeController,
                              length: 6,
                              enable: value7.deliveryDetailsEdit,
                              onChanged: (p0) {
                                value7.userPinCodeController.text = p0;
                                value7.notifyListeners();
                              },
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: 'PIN',
                              tail: value7.userPin,
                            );
                          }),
                          SizedBox(
                            height: height / 81,
                          ),
                          Consumer<MainProvider>(builder: (context, value6, _) {
                            return value6.deliveryDetailsEdit
                                ? ProfileTextFormWidget(
                              width: width,
                              label: 'Post Office',
                              controller: value6.userPostOfficeController,
                              enable: value6.deliveryDetailsEdit,
                            )
                                : ProfileDetailWidget(
                              width: width,
                              height: height,
                              head: 'Post Office',
                              tail: value6.userPostOffice,
                            );
                          }),

                          SizedBox(
                            height: _keyboardVisible ? height / 2 : 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
      },
    );
  }
}