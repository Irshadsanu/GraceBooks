import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class AddStaffScreen extends StatelessWidget {
  const AddStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double mWidth, mHeight;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.99),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: Container(
                decoration: BoxDecoration(shape: BoxShape.circle,color: const Color(0xffB6B6B6).withOpacity(.17)),
                height: 35,
                width: 35,
                child: const Icon(
                  Icons.chevron_left,
                  color: clBlack,
                  size: 30,
                ))),
        centerTitle: true,
        title: const Text(
          "Add Staff",
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
      body: Consumer<AdminProvider>(
        builder: (context3,value4,child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: (){
                      value4.showBottomSheet(context, "STAFF");
                    },
                    child:value4.staffPhoto==null?Container(
                      width: 74,
                      height: 74,
                      alignment: Alignment.center,
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
                      child: Image.asset(
                        "assets/addPhoto.png",
                        scale: 3,
                      ),
                    ):Container(
                      width: 74,
                      height: 74,
                      decoration: ShapeDecoration(
                        image: DecorationImage(image: FileImage(value4.staffPhoto!),fit: BoxFit.fill),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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
            
            
                    ),
                  ),
                ),
                Text(
                  value4.staffPhoto==null?'Add Photo':"Photo Uploaded",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 3.1,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 11,),
                  width: mWidth*.9,
                  decoration: _shapeDecorationNew(),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      hintText: "Name",
                      hintStyle: const TextStyle(color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,),
                    ),
                    controller: value4.staffName,
                    onChanged: (newValue) {
            
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please fill Name";
                      }else {
                        return null;
                      }
            
                    },
                  ),
                ),
                Container(
                  width: mWidth*.9,
                  decoration: _shapeDecorationNew(),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
            
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      hintText: "Mobile Number",
                      hintStyle: const TextStyle(color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,),
                    ),
                    controller: value4.staffPhone,
                    onChanged: (newValue) {
            
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please fill Mobile Number";
                      }else {
                        return null;
                      }
            
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 11,),
                  width: mWidth*.9,
                  decoration: _shapeDecorationNew(),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      hintText: "Place",
                      hintStyle: const TextStyle(color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,),
                    ),
                    controller: value4.staffPlace,
                    onChanged: (newValue) {
            
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please fill Place";
                      }else {
                        return null;
                      }
            
                    },
                  ),
                ),
                Consumer<AdminProvider>(
                    builder: (context5,value5,child) {
                      return Container(
                        // margin: const EdgeInsets.only(top: 16),
                        width: mWidth*.9,
                        decoration: _shapeDecorationNew(),
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue
                          textEditingValue) {
                            return (value5.accessList)
                                .where((String wardd) =>
                                wardd
                                    .toLowerCase()
                                    .contains(
                                    textEditingValue
                                        .text
                                        .toLowerCase()))
                                .toList();
                          },
                          displayStringForOption:
                              (String option) =>
                          option,
                          fieldViewBuilder: (BuildContext
                          context,
                              TextEditingController
                              fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) {
                              fieldTextEditingController.text = value4.accessControl.text;
            
                            });
            
                            return TextFormField(
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                prefixIcon:Container(
                                    width: 5,
                                    height: 5,
                                    margin: const EdgeInsets.all(9),
                                    decoration: BoxDecoration(
                                      color: cl1B4341,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const Icon(Icons.key,color: Colors.white,size: 15,)),
                                suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                    horizontal: 15),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0),
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0),
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0),
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                                hintText: "Access Control",
                                hintStyle: const TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,),
                              ),
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              textAlign: TextAlign.start,
            
                              validator: (value2) {
                                if (value2!.trim().isEmpty ||
                                    !value5.accessList.map((item) => item)
                                        .contains(value2)) {
                                  return "Please select Access Control";
                                } else {
                                  return null;
                                }
                              },
                            );
                          },
                          onSelected: (String selection) {
                            value4.accessControl.text=selection;
                          },
                          optionsViewBuilder: (BuildContext
                          context,
                              AutocompleteOnSelected<String>
                              onSelected,
                              Iterable<String> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width:  mWidth / 2,
                                  height:mHeight* .3,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding:
                                    const EdgeInsets.all(
                                        10.0),
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context,
                                        int index) {
                                      final String option =
                                      options
                                          .elementAt(index);
            
                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          width: mWidth,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                    option,
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                const SizedBox(
                                                    height: 14)
                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                ),
            SizedBox(height: mHeight*.2,)
              ],
            ),
          );
        }
      ),
      floatingActionButton:  Consumer<AdminProvider>(
          builder: (context33,value88,child) {
            return Padding(
              padding:  EdgeInsets.only(bottom: mHeight*.02),
              child: !value88.addStaffBool?InkWell(
                onTap: (){
                  value88.notifyStaff();
                  value88.addStaffFun("Spine",context);
                },
                child: Container(
                  width: mWidth*.9,
                  alignment: Alignment.center,
                  height: 43,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.01),
                      end: Alignment(1, 0.01),
                      colors: [Color(0xFF1B4341), Color(0xFF285D5B)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(49),
                    ),
                  ),
                  child: const  Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ):const CircularProgressIndicator(color: Colors.blueAccent,strokeAlign: BorderSide.strokeAlignInside,strokeWidth: BorderSide.strokeAlignOutside),
            );
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  ShapeDecoration _shapeDecorationNew() {
    return ShapeDecoration(
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
    );
  }

}
