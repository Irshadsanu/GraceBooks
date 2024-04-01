import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/AdminProvider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class AddCarousel extends StatelessWidget {
  const AddCarousel({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
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
        title:  const Text("Add Carousel",
            style: TextStyle(
                color: clBlack,
                fontFamily: "PoppinsRegular",
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Consumer<AdminProvider>(
          builder: (context8,value88,child) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal:20 ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 25,
                mainAxisExtent: 174
              ),
              itemCount: value88.carouselImageList.length+1,
              itemBuilder: (BuildContext context, int index) {
                return index==0||value88.carouselImageList.isEmpty? InkWell(
                  onTap: () {
                    value88.showBottomSheet(context, "CAROUSEL");
                  },
                  child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: clWhite,
                          boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(.05), // Shadow color
                        blurRadius: 6, // Spread of the shadow
                        offset: const Offset(0, 4), // Offset of the shadow
                      ),]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 25,height: 25,decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 1),),child: Icon(Icons.add)),
                        const Text("Add More\nImage",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.bold,fontSize: 14,color: clA7A7A7),textAlign: TextAlign.center),

                      ],
                    ),
                      ),
                ):Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),image: DecorationImage(image: NetworkImage( value88.carouselImageList[index-1].image),fit: BoxFit.fill,),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(.05), // Shadow color
                        blurRadius: 6, // Spread of the shadow
                        offset: const Offset(0, 4), // Offset of the shadow
                      ),]
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        value88. deletePosterAlert(context,value88.carouselImageList[index-1].id,"CAROUSEL");
                      },
                      child: Container(
                          height: 30,width: 70,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: clWhite),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Delete",style: TextStyle(color: Colors.red,fontFamily: "PoppinsRegular",fontSize: 12),),
                        Icon(Icons.delete,color: Colors.red,size: 15,)
                      ],)),
                    ),
                    const SizedBox(height: 15,)
                  ],
                ),
                );
              },
            );
          }
        ),
      )
    );
  }
}
