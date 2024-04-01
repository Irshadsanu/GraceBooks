import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/my_colors.dart';

class Update extends StatelessWidget {
  String text;
  String button;
  String ADDRESS;
  Update({Key? key,required this.text,required this.button,required this.ADDRESS}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // backgroundColor: cl_113B4C,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Image.asset("assets/gracelogo.png",height: 60,),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(text,
                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontFamily: 'Montserrat',fontSize: 16),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: (){
                    _launchURL(ADDRESS);
                  },
                  child: Container(
                    height: 40,
                    width: 168,
                    alignment: Alignment.center,
                    decoration:
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color:cl1B4341,
                    ),
                    child: Text(button,style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),),
                  ),
                ),
              ),


            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: width,
          color:Colors.transparent ,
          child: Image.asset("assets/spineLogo.png",scale: 4,),
        ),


      ),
    );

  }
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
