import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:grace_book_latest/UserScreens/reading_finish_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/MainProvider.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class PDFViewer extends StatefulWidget {
  final String pdfLink;
  final int currentPage;
  final String bookName;
  final String authorName;
  final String bookImage;
  final String userId;
  final String userName;
  final String userPhone;
  final String loginStatus;

  const PDFViewer(
      {super.key, required this.pdfLink, required this.currentPage, required this.bookName, required this.authorName, required this.bookImage, required this.userId, required this.userName, required this.userPhone, required this.loginStatus});

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  String? _localFilePath;
  PDFViewController? controller;
  int pages = 0;
  int indexPages = 0;
  bool isNightMode = false;

  @override
  initState()  {
    super.initState();
    _downloadFile();
    setSharedPrif();
    screenShotProtect();
  }

  Future<void>screenShotProtect()async{
    if(Platform.isAndroid){
   await ScreenProtector.protectDataLeakageOn();}
    else{
      await ScreenProtector.preventScreenshotOn();

    }

  }
  Future<void>screenShotProtectDispose()async{
    if(Platform.isAndroid){
      await ScreenProtector.protectDataLeakageOff();}
    else{
      await ScreenProtector.preventScreenshotOff();

    }

  }
  @override
  void dispose() async {

    screenShotProtectDispose();
    super.dispose();
  }
  Future<void> _downloadFile() async {
    final url = widget.pdfLink;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/document.pdf');
    await file.writeAsBytes(bytes);
    setState(() {
      _localFilePath = file.path;
    });
  }
  Future<void> setSharedPrif() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pageIndex', indexPages+1);
    await prefs.setString('pdfUrl', widget.pdfLink);
    await prefs.setString('bookImage',widget.bookImage);
    await prefs.setString('authorName', widget.authorName);
    await prefs.setString('bookName', widget.bookName);
  }



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: clWhite,
      width: width,
      height: height,
      child: SafeArea(
        child: PopScope(
          onPopInvoked: (al){
            MainProvider mainProvier =
            Provider.of<MainProvider>(context, listen: false);
            mainProvier.getSharedData();
          },
          child: Scaffold(
            // backgroundColor: const Color(0xFFEFEFEF),
            backgroundColor: clWhite,
            body: SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      height: height / 7.672727272727273,
                      color: clWhite,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: height / 84.4),
                      child: AppBar(
                        backgroundColor: clWhite,
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        leading: IconButton(
                            onPressed: () {
                              MainProvider mainProvier =
                              Provider.of<MainProvider>(context, listen: false);
                              mainProvier.getSharedData();

                              finish(context);
                            },
                            icon: const CircleAvatar(
                                radius: 18,
                                backgroundColor: clF7F7F7,
                                child: Icon(
                                  Icons.clear,
                                  size: 18,
                                ))),
                        title: Image.asset(
                          "assets/splash logo.png",
                          scale: 3,
                        ),
                        centerTitle: true,
                      ),
                    ),
                  ),
                  _localFilePath != null
                      ? Expanded(
                    child: PDFView(
                      defaultPage: widget.currentPage,
                      filePath: _localFilePath,
                      fitEachPage: true,
                      enableSwipe: true,nightMode: isNightMode,
                      swipeHorizontal: true,
                      onRender: (pages) =>
                          setState(() => this.pages = pages!),
                      onViewCreated: (controller) {
                        setState(() => this.controller = controller);
                      },
                      onPageChanged: (indexPage, b) async {
                        setState(() => indexPages = indexPage!);
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('pageIndex', indexPages);
                      },
                      autoSpacing: false,
                      fitPolicy: FitPolicy.BOTH,
                      pageFling: false,
                    ),
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  ),
                  _localFilePath != null
                      ? Container(
                    width: width / 1.1,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3FBDBDBD),
                          blurRadius: 10.90,
                          offset: Offset(2, 4),
                          spreadRadius: -1,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (indexPages > 0) {
                              final page = indexPages = indexPages - 1;
                              controller?.setPage(page);
                            }
                          },
                          child: const CircleAvatar(
                            backgroundColor: clE8AD14,
                            radius: 17,
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 23,
                        ),
                        Text(
                          '${indexPages + 1}/${pages}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF151515),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.60,
                          ),
                        ),
                        const SizedBox(
                          width: 23,
                        ),
                        GestureDetector(
                          onTap: () {
                            if(pages==indexPages+1){
                              callNext( ReadingFinishScreen(bookName: widget.bookName, authorName:  widget.authorName,
                                bookImage:  widget.bookImage, userId: widget.userId, userName: widget.userName, userPhone: widget.userPhone, loginStatus: widget.loginStatus,), context);
                            }else{
                              final page = indexPages + 1;
                              controller?.setPage(page);
                            }

                          },
                          child: const CircleAvatar(
                            backgroundColor: clE8AD14,

                            radius: 17,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                            ),
                          ),
                        ),


                      ],
                    ),
                  )
                      : const SizedBox()
                  ,
                  SizedBox(height: height/35,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}