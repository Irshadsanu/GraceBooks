import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';

class AddAdvertisement extends StatelessWidget {
  const AddAdvertisement({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      floatingActionButton: Consumer<AdminProvider>(
        builder: (context34,value9,child) {
          return !value9.adBool?InkWell(
            onTap: (){
              value9.notifyAdBool();
              value9.addAdvertisement('Spine',context);
            },
            child: Container(
              alignment: Alignment.center,
              width: 328,
              height: 44,
              // padding: const EdgeInsets.symmetric(horizontal: 77, vertical: 10),
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
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ):const CircularProgressIndicator(color: Colors.blueAccent,strokeAlign: BorderSide.strokeAlignInside,strokeWidth: BorderSide.strokeAlignOutside);
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Add Advertisement",
          style: TextStyle(
            color: clBlack,
            fontFamily: "PoppinsRegular",
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: InkWell(
          onTap: (){
            finish(context);

          },
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: clB6B6B6, borderRadius: BorderRadius.circular(71)),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
        ),
      ),
      body: Consumer<AdminProvider>(
        builder: (context3,value2,child) {
          return Column(children: [
            InkWell(
              onTap: (){
                value2.showBottomSheet(context, "ADVERTISEMENT");
              },
              child: value2.advertisementFile!=null?Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 17, right: 18, top: 24),
                width: width,
                height: 154,
                decoration: BoxDecoration(
                    color: clFFFFFF,
                    borderRadius: BorderRadius.circular(9),
                    image: DecorationImage(image: FileImage(value2.advertisementFile!),fit: BoxFit.fill),
                    boxShadow: const [
                      BoxShadow(
                          color: cl000000,
                          spreadRadius: 0,
                          blurRadius: 11.769230842590332)
                    ]),

              ):Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 17, right: 18, top: 24),
                width: width,
                height: 154,
                decoration: BoxDecoration(
                    color: clFFFFFF,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: const [
                      BoxShadow(
                          color: cl000000,
                          spreadRadius: 0,
                          blurRadius: 11.769230842590332)
                    ]),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline,
                    color: cl014D88,),
                    Text(
                      'Add Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 2
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30,),
            value2.advertiseImage!=""? Container(
              margin: const EdgeInsets.only(left: 17, right: 18,),
              width: width,
              height: 158,
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: NetworkImage(value2.advertiseImage),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: (){
                        value2.deletePosterAlert(context,value2.advertiseId,"ADVERTISEMENT");
                      },
                      child: Container(
                          height: 30,width: 75,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: clWhite),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Delete",style: TextStyle(color: Colors.red,fontFamily: "PoppinsRegular",fontSize: 12),),
                              Icon(Icons.delete,color: Colors.red,size: 15,)
                            ],)),
                    ),
                  ),
                ],
              ),
            ): Container(
              height: height*.45,
                alignment: Alignment.center,
                child: const Text("No Data Found!!!", style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w500,

            ),)),
          ]);
        }
      ),
    ));
  }
}
