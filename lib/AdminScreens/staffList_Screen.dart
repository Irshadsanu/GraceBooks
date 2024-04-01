import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import 'addStafff_screen.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double mWidth, mHeight;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    adminProvider. fetchStaffs();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: CustomShape(),
            // this is my own class which extendsCustomClipper
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 140,
              color: cl1B4341,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 80,
                    child: Image.asset("assets/logo.png"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
            child: TextFormField(
              focusNode: FocusNode(),
              enableInteractiveSelection: true,
              toolbarOptions: const ToolbarOptions(
                paste: true,),
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.text,
              autofocus: false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      21.28,
                    ),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      21.28,
                    ),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      21.28,
                    ),
                    borderSide: const BorderSide(color: Colors.grey)),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                hintText: 'Search here ',
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintStyle: const TextStyle(
                  color: Color(0xFFB1B1B1),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              textAlign: TextAlign.center,
              onChanged: (text) {
                adminProvider.filterStaffList(text);
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer<AdminProvider>(
            builder: (context3,value66,child) {
              return  Text(
                'Total Staffs - ${value66.filterStaffsList.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF1B4341),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              );
            }
          ),
          Expanded(
            child: Consumer<AdminProvider>(
                builder: (context35,value64,child) {
                return ListView.builder(
                  itemCount: value64.filterStaffsList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                    var item=value64.filterStaffsList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 16),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0C000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child:ListTile(
                        leading: Container(
                          margin: const EdgeInsets.symmetric(vertical: 2,),
                          height: 60,
                          width: 60,
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                              image:item.photo!=""? NetworkImage(item.photo):const AssetImage("assets/photo.png") as ImageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title:  Text(item.name,style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),),
                        subtitle:  Text(item.phone,style: const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),),
                        trailing: InkWell(
                            onTap: (){
                              value64.deletePosterAlert(context,item.id,"STAFF");

                            },
                            child: const Icon(Icons.delete,color: Colors.red,size: 25,)),

                      ),



                    );

                    });
              }
            ),
          )
        ],
      ),

      floatingActionButton: Consumer<AdminProvider>(
        builder: (context33,value83,child) {
          return InkWell(
            onTap: (){
              value83.clearStaffControllers();
              callNext(const AddStaffScreen(), context);
            },
            child: Container(
              width: 55,
              height: 55,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFE8AD14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(55),
                ),
              ),
              child: const Icon(Icons.add,),
            ),
          );
        }
      ),
    );
  }
}
