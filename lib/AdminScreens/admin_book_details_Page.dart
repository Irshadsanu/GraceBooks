import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_book_latest/AdminScreens/addBook%20_Screen.dart';
import 'package:grace_book_latest/AdminScreens/add_E_Book_Screen.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:provider/provider.dart';

import '../Model/book_Model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class AdminBookDetails extends StatelessWidget {
  String userName;
  String userId;
  BookModel item;
  String from;
  AdminBookDetails({super.key,required this.userName,required this.userId,required this.item,required this.from});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    String description ="Lorem ipsum dolor sit amet consectetur. Tristique vel fermentum egestas augue. Nibh nisi mattis sed vulputate egestas neque at orci. Diam cursus est nunc amet tellus. Eleifend nisl non auctor pulvinar in id. Amet euismod at sollicitudin purus diam eu ";
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: Container(
                decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xffB6B6B6).withOpacity(.17)),
                height: 35,
                width: 35,
                child: Icon(
                  Icons.chevron_left,
                  color: clBlack,
                  size: 30,
                ))),
        title:  Text("Book Details",
            style: const TextStyle(
                color: clBlack,
                fontFamily: "PoppinsRegular",
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(width: width/2.8,height: 163,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: NetworkImage(item.bookPhoto),fit: BoxFit.fill),)),
            
              const SizedBox(height: 20),
             from == "E-BOOK"? SizedBox():Align(
                alignment: Alignment.topLeft,
                child: Container(height: 90,
                  width: width/2.5,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2,color: Color(0xffDBDEE5))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/₹.svg',color: clBlack,height: 17,
                          ),
                          Text(item.price,style: TextStyle(color: clBlack,fontFamily: "PoppinsRegular",fontSize: 22,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Text("Price",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 13,color: Color(0xff637087)),),
            
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
            
              Align(alignment: Alignment.topLeft,child: Text(item.bookName,style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.bold,fontSize: 14,color: clBlack),)),
              Align(alignment: Alignment.topLeft,child: Text(item.author,style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,fontSize: 13,color: Color(0xff637087)),)),
            
            
              const SizedBox(height: 10,),
              Align(alignment: Alignment.topLeft,child: Text("Description",style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.bold,fontSize: 12,color: clBlack),)),
              Align(alignment: Alignment.topLeft,child: Text(item.description,style: TextStyle(fontFamily: "PoppinsRegular",fontWeight: FontWeight.w500,height: 2.5,fontSize: 12,color: clBlack),)),


              const SizedBox(height: 60,),
            ]),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Consumer<AdminProvider>(
          builder: (context,value111,child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    value111.deleteBookAlert(context,item.id,from);
                  },
                  child: Container(
                    height: 37,
                    width: width/2.5,
                    decoration: BoxDecoration(
                      color: clF0F2F5,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("Remove Book",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "PoppinsRegular",fontSize: 13,color: clBlack))),),
                ),
                InkWell(
                  onTap: () {

                    if(from=="STORE") {
                      value111.editStoreBook(item);
                      callNext(AddBookScreen(from: "EDIT", bookId: item.id, userName: userName, userId: userId,),
                          context);
                    }else{
                      value111.editEbook(item);
                      callNext(AddEbookScreen(bookId: item.id,from: "EDIT", userName: userName, userId: userId,), context);
                    }
                  },
                  child: Container(
                    height: 37,
                    width: width/2.5,
                    decoration: BoxDecoration(
                      color: cl1C4543,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(child: Text("Edit Book",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "PoppinsRegular",fontSize: 13,color: clWhite))),),
                ),
              ],
            );
          }
        ),
      ),

    );
  }
}
