class StaffModel{
  String id;
  String name;
  String phone;
  String photo;
  String place;
  String type;
  String date;
  String status;
  StaffModel(this.id,this.name,this.phone,this.photo,this.place,this.type,this.date,this.status,);
}
class CarouselModel{
  String id;
  String image;
  String addedBy;
  String date;


  CarouselModel(this.id,this.image,this.addedBy,this.date);
}



class SearchModel{
  String id;
  String name;
  String bookType;
  SearchModel(this.id,this.name,this.bookType);
}