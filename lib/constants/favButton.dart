import 'package:flutter/material.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:grace_book_latest/constants/my_colors.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:grace_book_latest/login_screen.dart';
import 'package:provider/provider.dart';

class Heart extends StatefulWidget {
  final String userId;
  final String from;
  final String bookId;
  final bool fav;

  final String bookName;
  final String authorName;
  final String bookImage;
  final String offerPrice;
  final String price;
  final String categoryId;
  const Heart({super.key, required this.userId, required this.bookId, required this.fav,  required this.from, required this.bookName, required this.authorName, required this.bookImage, required this.offerPrice, required this.price,required this.categoryId});

  @override
  _HeartState createState() => _HeartState();
}
class _HeartState extends State<Heart> with SingleTickerProviderStateMixin{
  AnimationController ?_controller;
  Animation<Color?>? _colorAnimation;
  Animation<double?>? _sizeAnimation;
  Animation<double> ?_curve;
  bool isFav=false;
  bool isFirstOpen=true;
  bool isFun=false;
  @override
  void initState() {

    _controller=AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
    );
    _curve=CurvedAnimation(parent: _controller!, curve: Curves.slowMiddle);
    _colorAnimation = ColorTween(begin:widget.fav ? clE8AD14 : clD2D2D2, end:widget.fav ? clD2D2D2 : clE8AD14).animate(_curve!);
    _sizeAnimation=TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(tween: Tween(begin: 20,end: 40), weight: 40),
          TweenSequenceItem<double>(tween: Tween(begin: 40,end: 20), weight: 40),
        ]
    ).animate(_curve!);
    _controller!.addListener(() {
    });
    _controller!.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        setState(() {
          isFav=true;
          isFun=false;
        });
      }
      if(status==AnimationStatus.dismissed){
        setState(() {
          isFav=false;
          isFun=true;

        });
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
if(isFirstOpen){
  isFun=widget.fav;
  isFirstOpen=false;
}


    return AnimatedBuilder(
        animation: _controller!,
        builder:(context,_){
          return Consumer<MainProvider>(
            builder: (context,main,_) {
              return GestureDetector(
                child: Icon(
                  Icons.favorite,
                  color: _colorAnimation!.value,
                  size: _sizeAnimation!.value,
                ),
                onTap: () {
                  if(widget.userId!=""){
                  isFav?_controller!.reverse():_controller!.forward();

                  if(!isFun){
                    print("AAAAAAAAAAAADDDDDDDDDDDD");

                    main.addFavorite(widget.userId,widget.bookId,widget.from,widget.bookName,widget.authorName,widget.bookImage,widget.price,widget.offerPrice,widget.categoryId);
                  }else{
                    print("RRRRRRRRRRRRRMOOOOOOOV");

                    main.unLike(widget.userId,widget.bookId,widget.from,widget.categoryId);

                  }}else{
                    callNext(LoginScreen(), context);
                  }
                },
              );
            }
          );
        }
    );
  }
}