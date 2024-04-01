class SearchBooksModel{
  String bookId;
  String bookName;
  String bookPhoto;
  String ebookPhoto;
  String authorName;
  String bookPrice;
  String bookType;
  String bookOfferPrice;
  String bookDescription;
  String bookCategory;
  String bookCategoryId;
  List<String> favoriteList;
  List<String> libraryList;

  SearchBooksModel(this.bookId, this.bookName, this.bookPhoto,this.ebookPhoto, this.authorName, this.bookPrice,this.bookType,
      this.bookOfferPrice,this.bookDescription,this.bookCategory,this.bookCategoryId,this.favoriteList,this.libraryList);
}