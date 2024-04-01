class EbookModel{
  String bookId;
  String bookName;
  String bookPhoto;
  String authorName;
  String bookDescription;
  String category;
  String categoryId;
  List<String> favList;
  List<String> libraryList;

  EbookModel(this.bookId,this.bookName, this.bookPhoto, this.authorName,this.bookDescription,this.category,this.categoryId,this.favList,this.libraryList);
}