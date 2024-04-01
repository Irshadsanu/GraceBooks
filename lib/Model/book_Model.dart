import 'package:cloud_firestore/cloud_firestore.dart';

import 'orderModel.dart';

class BookModel{
  String id;
  String author;
  String bookName;
  String bookPhoto;
  String category;
  String language;
  String price;
  String offerPrice;
  String publisher;
  String pages;
  String publisherDateMilli;
  String description;
  String catId;
  String bookWidth;
  String bookHeight;
  Timestamp publishDate;
  String pdfName;
  String pdfUrl;
  BookModel(this.id,this.author,this.bookName,this.bookPhoto,this.category,this.language,this.price,this.offerPrice,
      this.publisher,this.pages,this.publisherDateMilli,this.description,this.catId,this.bookWidth,this.bookHeight,
      this.publishDate,this.pdfName,this.pdfUrl);
}

class CategoryModel{
  String id;
  String category;

  CategoryModel(this.id,this.category,);
}


class MyOrderModel{
  String bookName;
  String bookPhoto;
  String authorName;
  String orderStatus;
  String placedDate;
  String dispatchedDate;
  String deliveredDate;
  List<ItemModel> items;


  MyOrderModel(this.bookName,this.bookPhoto,this.authorName,this.orderStatus,this.placedDate,this.dispatchedDate,this.deliveredDate,this.items,);
}
