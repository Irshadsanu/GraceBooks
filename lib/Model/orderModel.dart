import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id ;
  String customerName;
  String bookName;
  String amount;
  Timestamp orderDate;
  String customerPhone;
  String orderStatus;
  String address;
  List<ItemModel> items;
  String paymentMethod;

  OrderModel(this.id,this.customerName,this.bookName,this.amount,this.orderDate,
      this.customerPhone,this.orderStatus,this.address,this.items,this.paymentMethod);
}


class ItemModel {
  String bookId;
  String itemName;
  String itemImage;
  String authorName;
  String itemPrice;
  String catId;
  String catName;
  int quantity;

  ItemModel(this.bookId,this.itemName,this.itemImage,this.authorName,this.itemPrice,this.catId,this.catName,this.quantity);

}