class StoreBookModel{
  String bookId;
  String bookName;
  String bookPhoto;
  String authorName;
  String bookPrice;
  String bookType;
  String bookOfferPrice;
  String bookDescription;
  String bookCategory;
  String bookCategoryId;
  List<String> favoriteList;
  List<String> addCartList;
  List<String> libraryList;
  String ebookPhoto;

  StoreBookModel(this.bookId, this.bookName, this.bookPhoto, this.authorName, this.bookPrice,this.bookType,
      this.bookOfferPrice,this.bookDescription,this.bookCategory,this.bookCategoryId,this.favoriteList,this.addCartList,this.libraryList,this.ebookPhoto);
}