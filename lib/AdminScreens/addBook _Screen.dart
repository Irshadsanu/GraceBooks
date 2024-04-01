import 'package:flutter/material.dart';
import 'package:grace_book_latest/Providers/AdminProvider.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../Model/book_Model.dart';
import '../constants/my_colors.dart';

class AddBookScreen extends StatelessWidget {

  String userName;
  String userId;
  String from;
  String bookId;
   AddBookScreen({super.key,required this.userName,required this.userId,required this.from,required this.bookId,});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
   final  GlobalKey<FormState> formKey2= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double mWidth, mHeight;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
          "Add Book",
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
      body: SingleChildScrollView(
        child: Consumer<AdminProvider>(
          builder: (context3,value73,child) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){
                        value73.showBottomSheet(context, "BOOK");
                      },
                      child:value73.authorPhoto!=null?Container(
                        width: 74,
                        height: 74,
                        decoration: ShapeDecoration(
                          image: DecorationImage(image: FileImage(value73.authorPhoto!),fit: BoxFit.fill),
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


                      ):
                      from=="EDIT"&&value73.bookImage!=""?Container(
                        width: 74,
                        height: 74,
                        decoration: ShapeDecoration(
                          image: DecorationImage(image: NetworkImage(value73.bookImage),fit: BoxFit.fill),
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


                      ):Container(
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
                      )
                    ),
                  ),
                   Text(
                    value73.authorPhoto==null?'Add Book Image':"Image Uploaded",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 3.1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<AdminProvider>(builder: (context5, value5, child) {
                        return Container(
                          width: mWidth * .62,
                          decoration: _shapeDecorationNew(),
                          child: Autocomplete<CategoryModel>(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              return (value5.bookCategoryList)
                                  .where((CategoryModel wardd) => wardd.category
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase()))
                                  .toList();
                            },
                            displayStringForOption: (CategoryModel option) => option.category,
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                fieldTextEditingController.text = value5.bookCategoryCt.text;
                              });

                              return TextFormField(
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  suffixIcon:
                                  const Icon(Icons.keyboard_arrow_down_outlined),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 15),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  hintText: " Category",
                                  hintStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                controller: fieldTextEditingController,
                                focusNode: fieldFocusNode,
                                textAlign: TextAlign.start,
                                validator: (value2) {
                                  if (value2!.trim().isEmpty ||
                                      !value5.bookCategoryList
                                          .map((item) => item.category)
                                          .contains(value2)) {
                                    return "Please select category";
                                  } else {
                                    return null;
                                  }
                                },
                              );
                            },
                            onSelected: (CategoryModel selection) {
                              value5.bookCategoryCt.text = selection.category;
                              value5.bookCategoryIdCt.text = selection.id;
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<CategoryModel> onSelected,
                                Iterable<CategoryModel> options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  child: Container(
                                    width: mWidth / 2,
                                    height: mHeight * .3,
                                    color: Colors.white,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(10.0),
                                      itemCount: options.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final CategoryModel option = options.elementAt(index);

                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
                                          },
                                          child: Container(
                                            color: Colors.white,
                                            width: mWidth,
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(option.category,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold)),
                                                  const SizedBox(height: 10)
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
                      }),
                      Consumer<AdminProvider>(builder: (context577, value55, child) {

                        return InkWell(
                          onTap: (){
                            value55.trueCategoryBool();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 6),
                            width: mWidth*.26,
                            height: 46,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE8AD14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            child:  const Text(
                              ' Add Category',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9.8,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ),
                        );
                      }
                      ),
                    ],
                  ),
                  Consumer<AdminProvider>(
                      builder: (context8,value58,child) {
                        return value58.addCategoryBool?Container(
                          margin: const EdgeInsets.only(top: 13),
                          height: mHeight*.225,
                          width: mWidth*.9,
                          padding: const EdgeInsets.only(top: 18, left: 8, right: 8, bottom: 0),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFEFEFEF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
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
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5,top: 2,bottom: 2),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Add Category',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0.08,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 15,),
                                width: mWidth * .9,
                                decoration: _shapeDecorationNew(),
                                child: Form(
                                  key: formKey2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 12),
                                      border: OutlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.circular(21.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.circular(21.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.circular(21.0),
                                      ),
                                      hintText: "Category Name",
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    controller: value58.addCategoryCt,
                                    onChanged: (newValue) {},
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return "Please fill Category Name";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      value58. falseCategoryBool();
                                    },
                                    child: Container(
                                      width: mWidth*.33,
                                      height: 33,
                                      alignment: Alignment.center,
                                      decoration: ShapeDecoration(
                                        color:Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(37),
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
                                      child: const Text("Cancel",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 0.10,
                                      ),),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      var form =formKey2.currentState;
                                      if(form!.validate()){
                                        value58.saveCategory(userName,context);
                                      }

                                    },
                                    child: Container(
                                      width: mWidth*.33,
                                      height: 33,
                                      alignment: Alignment.center,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFE8AD14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(37),
                                        ),
                                      ),
                                      child: const Text("Save Category",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),),
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),


                        ):const SizedBox();
                      }
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
                        hintText: "Book Name",
                        hintStyle: const TextStyle(color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,),
                      ),
                      controller: value73.bookNameCt,
                      onChanged: (newValue) {

                      },
                      validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please fill Book Name";
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
                        hintText: "Author",
                        hintStyle: const TextStyle(color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,),
                      ),
                      controller: value73.authorCt,
                      onChanged: (newValue) {

                      },
                      validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please fill";
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
                      keyboardType: TextInputType.multiline,
                      minLines: 1, //Normal textInputField will be displayed
                      maxLines: 100,
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
                        hintText: "Description",
                        hintStyle: const TextStyle(color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,),
                      ),
                      controller: value73.descriptionCt,
                      onChanged: (newValue) {

                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please fill";
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
                        hintText: "Language",
                        hintStyle: const TextStyle(color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,),
                      ),
                      controller: value73.languageCt,
                      onChanged: (newValue) {

                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please fill";
                        }else {
                          return null;
                        }

                      },
                    ),
                  ),
                  Container(
                    width: mWidth*.9,
                    margin: const EdgeInsets.symmetric(vertical: 11,),

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
                        hintText: "Publisher",
                        hintStyle: const TextStyle(color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,),
                      ),
                      controller: value73.publisherCt,
                      onChanged: (newValue) {

                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please fill";
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
                      onTap: (){
                        value73.publicationDate(context,"BOOK");
                      },
                      readOnly: true,
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
                        hintText: "Publication Date",
                        hintStyle: const TextStyle(color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,),
                      ),
                      controller: value73.publishDateCt,
                      onChanged: (newValue) {

                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please fill";
                        }else {
                          return null;
                        }

                      },
                    ),
                  ),

                  SizedBox(
                    width: mWidth*.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: mWidth*.42,
                          margin: const EdgeInsets.symmetric(vertical: 11,),

                          decoration: _shapeDecorationNew(),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
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
                              hintText: "Dimension Inch (W)",
                              hintStyle: const TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,),
                            ),
                            controller: value73.bookWidth,
                            onChanged: (newValue) {

                            },
                          ),
                        ),
                        Container(
                          width: mWidth*.42,
                          margin: const EdgeInsets.symmetric(vertical: 11,),

                          decoration: _shapeDecorationNew(),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
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
                              hintText: "Dimension Inch (H)",
                              hintStyle: const TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,),
                            ),
                            controller: value73.bookHeight,
                            onChanged: (newValue) {

                            },

                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: mWidth*.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: mWidth*.42,
                          decoration: _shapeDecorationNew(),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
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
                              hintText: "Current Price",
                              hintStyle: const TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,),
                            ),
                            controller: value73.bookPrice,
                            onChanged: (newValue) {

                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Please fill";
                              }else {
                                return null;
                              }

                            },
                          ),
                        ),
                        Container(
                          width: mWidth*.42,
                          decoration: _shapeDecorationNew(),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
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
                              hintText: "Offer%",
                              hintStyle: const TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,),
                            ),
                            controller: value73.offerPrice,

                            onChanged: (newValue) {

                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Please fill";
                              }else {
                                return null;
                              }

                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    width: mWidth*.9,
                    margin: const EdgeInsets.only(top: 11,),
                    decoration: _shapeDecorationNew(),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
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
                        hintText: "Number of Pages",
                        hintStyle: const TextStyle(color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,),
                      ),
                      controller: value73.pagesCt,
                      onChanged: (newValue) {

                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please fill";
                        }else {
                          return null;
                        }

                      },
                    ),
                  ),
                  SizedBox(height: mHeight*.12,)

                ],
              ),
            );
          }
        ),
      ),
      floatingActionButton:  Consumer<AdminProvider>(
          builder: (context33,value88,child) {
            return Padding(
              padding:  EdgeInsets.only(bottom: mHeight*.02),
              child: !value88.addBookBool?InkWell(
                onTap: (){
                  var form= formKey.currentState;
                  if(form!.validate()){
                      if(value88.authorPhoto != null || value88.bookImage!=""){
                        value88.notifyAddBookBool();
                        if(from != "EDIT") {
                          value88.addBooks(context,"NEW","");
                        }else{
                          value88.addBooks(context,"EDIT",bookId);
                        }

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(" Please upload Book Image"),
                          backgroundColor: Colors.red,
                          duration: Duration(milliseconds: 3000),
                        ));

                      }
                  }

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
