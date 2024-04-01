class FavoriteModel{

  String id;
  String authorName;
  String bookName;
  String bookImage;
  String bookId;
  String offerPrice;
  String price;
  String bookType;
  String categoryId;

  FavoriteModel(this.id, this.authorName, this.bookName, this.bookImage,
      this.bookId, this.offerPrice, this.price,this.bookType,this.categoryId,);
}

class SalesReportModel{

  String bookId;
  String authorName;
  String bookName;
  String bookImage;
  String price;
  String dateMilli;
  double totalPrice;
  int totalCount;

  SalesReportModel(this.bookId, this.authorName, this.bookName, this.bookImage,this.price,this.dateMilli, {this.totalPrice = 0, this.totalCount = 0});
}