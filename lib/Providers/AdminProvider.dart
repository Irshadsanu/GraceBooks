import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grace_book_latest/AdminScreens/orders_screen.dart';
import 'package:grace_book_latest/Model/orderModel.dart';
import 'package:grace_book_latest/Providers/login_provider.dart';
import 'package:grace_book_latest/constants/my_functions.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'as xlsio;


import '../AdminScreens/admin_login_screen.dart';
import '../Model/book_Model.dart';
import '../Model/favorite_model_class.dart';
import '../Model/staffModel.dart';
import '../constants/my_colors.dart';

class AdminProvider extends ChangeNotifier {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> accessList = [
    "Admin",
    "Staff",
  ];
  AdminProvider(){
    fetchCategoryList();
    adminOrderListLatest();
    totalCollected();
  }

  // List<String> eBookCategoryList = [
  //   "Art & Architecture",
  //   "Computers",
  //   "Entertainment"
  //       "Family & Relationships",
  //   "Food & Drink",
  //   "Health & Well Being",
  //   "History",
  //   "Home & Garden"
  //       "Reference & Language",
  //   "Religion & Spirituality",
  //   "Science & Nature",
  //   "Social & Cultural Studies",
  //   "Sports",
  //   "Travel"
  // ];
  final ImagePicker picker = ImagePicker();

  /// add book functions
  TextEditingController bookCategoryCt = TextEditingController();
  TextEditingController bookCategoryIdCt = TextEditingController();
  TextEditingController bookNameCt = TextEditingController();
  TextEditingController authorCt = TextEditingController();
  TextEditingController descriptionCt = TextEditingController();
  TextEditingController languageCt = TextEditingController();
  TextEditingController pagesCt = TextEditingController();
  TextEditingController publisherCt = TextEditingController();
  TextEditingController publishDateCt = TextEditingController();
  TextEditingController bookPrice = TextEditingController();
  TextEditingController offerPrice = TextEditingController();
  TextEditingController bookWidth = TextEditingController();
  TextEditingController bookHeight = TextEditingController();
  File? authorPhoto;
  String bookImage = "";
  DateTime publishDate = DateTime.now();
  var outputDayNode = DateFormat('d/MM/yyy');
  bool addBookBool = false;
  notifyAddBookBool() {
    addBookBool = true;
    notifyListeners();
  }

  clearBookControllers() {
    authorPhoto=null;
    publishDate = DateTime.now();
    bookCategoryCt.clear();
    bookCategoryIdCt.clear();
    bookNameCt.clear();
    authorCt.clear();
    descriptionCt.clear();
    languageCt.clear();
    pagesCt.clear();
    publisherCt.clear();
    publishDateCt.clear();
    bookPrice.clear();
    offerPrice.clear();
    bookWidth.clear();
    bookHeight.clear();
    notifyListeners();
  }

  addBooks(BuildContext context,String from,String bookId) async {
    DateTime addDate = DateTime.now();
    String date = DateFormat('dd/MM/yy').format(addDate);
    String newId = addDate.millisecondsSinceEpoch.toString();
    Map<String, Object> bookMap = HashMap();
    bookMap["CATEGORY"] = bookCategoryCt.text;
    bookMap["CATEGORY_ID"] = bookCategoryIdCt.text;
    bookMap["NAME"] = bookNameCt.text;
    bookMap["AUTHOR"] = authorCt.text;
    bookMap["BOOK_ID"] = newId;
    bookMap["DESCRIPTION"] = descriptionCt.text;
    bookMap["PAGES"] = pagesCt.text;
    bookMap["LANGUAGE"] = languageCt.text;
    bookMap["BOOK_WIDTH"] = bookWidth.text;
    bookMap["BOOK_HEIGHT"] = bookHeight.text;
    bookMap["PUBLISHER"] = publisherCt.text;
    bookMap["PUBLISHER_DATE"] = publishDate;
    bookMap["PUBLISHER_DATE_MILLI"] = publishDate.microsecondsSinceEpoch;
    bookMap["PRICE"] = bookPrice.text;
    bookMap["OFFER_PRICE"] = offerPrice.text;
    bookMap["MOST_POPULAR"] = "YES";
    bookMap["STATUS"] = "ACTIVE";
    bookMap["TYPE"] = "BOOK";
    if (authorPhoto != null) {
      Reference reference7 =
          FirebaseStorage.instance.ref().child('BOOK/$newId');
      await reference7.putFile(authorPhoto!).whenComplete(() async {
        await reference7.getDownloadURL().then((value3) {
          bookMap['BOOK_PHOTO'] = value3;
          notifyListeners();
        });
      });
    }else{
      bookMap['BOOK_PHOTO'] = bookImage;
    }
    if(from!="EDIT") {
      db.collection("BOOKS").doc(newId).set(bookMap,SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Book Successfully Added"),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 3000),
      ));
    }else{
      db.collection("BOOKS").doc(bookId).set(bookMap,SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Book Successfully Edited"),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 3000),
      ));
    }
    fetchAdminStoreBook();
    fetchAdminEbook();
if(from=="EDIT") {
  finish(context);
    finish(context);
}else{
  finish(context);
}
    addBookBool = false;
    notifyListeners();
  }

  Future<void> publicationDate(BuildContext context, String from) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != publishDate) {
      publishDate = pickedDate;
      dateSetting(pickedDate, from);
    }
    notifyListeners();
  }

  void dateSetting(DateTime birthDate, String from) {
    if (from == "BOOK") {
      publishDateCt.text = outputDayNode.format(birthDate).toString();
    } else {
      eBookPublicationDateCt.text = outputDayNode.format(birthDate).toString();
    }
  }

 double totalAmountCollected = 0;
 int totalSoledBook = 0;

  void totalCollected (){
    db.collection("TOTAL").doc("TOTAL").snapshots().listen((event) {
      if(event.exists){
        Map<dynamic, dynamic> totalMap = event.data() as Map;
        totalAmountCollected = totalMap["AMOUNT"];
        totalSoledBook = totalMap["BOOK_COUNT"];
      }
      notifyListeners();
    });
  }



  void showBottomSheet(BuildContext context, String from) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.camera_enhance_sharp,
                    color: cl1B4341,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () =>
                      {imageFromCamera(from, context), Navigator.pop(context)}),
              ListTile(
                  leading: const Icon(
                    Icons.photo,
                    color: cl1B4341,
                  ),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () => {
                        imageFromGallery2(from, context),
                        Navigator.pop(context)
                      }),
            ],
          );
        });
    // ImageSource
  }

  imageFromCamera(String from, BuildContext context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      // fileImage = File(pickedFile.path);

      _cropImage(pickedFile.path, from, context);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData(from);
    notifyListeners();
  }

  imageFromGallery2(String from, BuildContext context) async {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    // loadingCropImage=true;
    if (pickedFile != null) {
      _cropImage(pickedFile.path, from, context);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData(from);

    notifyListeners();
  }

  Future<void> _cropImage(
      String path, String from, BuildContext context) async {
    final croppedFile;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    int widthh = queryData.orientation == Orientation.portrait ? 300 : 300;
    croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
          boundary: CroppieBoundary(width: widthh, height: widthh),
          enableZoom: true,
          mouseWheelZoom: false,
          enableExif: true,
          enforceBoundary: true,
          viewPort:
              const CroppieViewPort(width: 180, height: 180, type: 'Square'),
        ),
      ],
    );

    if (croppedFile != null) {
      if (from == "STAFF") {
        staffPhoto = File(croppedFile.path);
      } else if (from == "BOOK") {
        authorPhoto = File(croppedFile.path);
      } else if (from == "ADVERTISEMENT") {
        advertisementFile = File(croppedFile.path);
      } else if (from == "CAROUSEL") {
        carouselFileImage = File(croppedFile.path);
        addCarousel("", context);
      } else if (from == "E-BOOK") {
        eBookPhotoFile = File(croppedFile.path);
      }
      notifyListeners();
    }
  }

  Future<void> retrieveLostData(
    from,
  ) async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
  }

  /// add E-book Functions
  File? eBookPhotoFile;
  String pdfPath = "";
  File? pdfFilePath;
  String ebookImage ="";
  String ebookPdf ="";
  bool addEbookBool = false;
  TextEditingController eBookNameCt = TextEditingController();
  TextEditingController eBookAuthorCt = TextEditingController();
  TextEditingController eBookDescriptionCt = TextEditingController();
  TextEditingController eBookLanguageCt = TextEditingController();
  TextEditingController eBookPublisherCt = TextEditingController();
  TextEditingController eBookPublicationDateCt = TextEditingController();
  TextEditingController eBookPagesCt = TextEditingController();

  pickPDFFilePath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      pdfPath = result.files.single.name.toString();
      pdfFilePath = File(result.files.single.path!);
    }
    notifyListeners();
  }

  notifyAddEbook() {
    addEbookBool = true;
    notifyListeners();
  }

  addEbookFun(BuildContext context2,String from,String bookId) async {
    DateTime addDate = DateTime.now();
    String date = DateFormat('dd/MM/yy').format(addDate);
    String newId = addDate.millisecondsSinceEpoch.toString();
    Map<String, Object> eBookMap = HashMap();
    eBookMap["CATEGORY"] = bookCategoryCt.text;
    eBookMap["CATEGORY_ID"] = bookCategoryIdCt.text;
    eBookMap["NAME"] = eBookNameCt.text;
    eBookMap["AUTHOR"] = eBookAuthorCt.text;
    eBookMap["DESCRIPTION"] = eBookDescriptionCt.text;
    eBookMap["LANGUAGE"] = eBookLanguageCt.text;
    eBookMap["PUBLISHER"] = eBookPublisherCt.text;
    eBookMap["PUBLISHER_DATE"] = publishDate;
    eBookMap["PUBLISHER_DATE_MILLI"] = publishDate.microsecondsSinceEpoch;
    eBookMap["PAGES"] = eBookPagesCt.text;
    eBookMap["TYPE"] = "E-BOOK";
    eBookMap["MOST_POPULAR"] = "YES";
    eBookMap["STATUS"] = "ACTIVE";

    if (pdfFilePath != null) {
      Reference reference7 =
          FirebaseStorage.instance.ref().child('E-BOOK/$newId');
      await reference7.putFile(pdfFilePath!).whenComplete(() async {
        await reference7.getDownloadURL().then((value3) {
          eBookMap['PDF_FILE'] = value3;
          eBookMap['PDF_FILE_NAME'] = pdfPath;
          notifyListeners();
        });
      });
    }else{
      eBookMap['PDF_FILE'] = ebookPdf ;
      eBookMap['PDF_FILE_NAME'] = pdfPath;
    }
    if (eBookPhotoFile != null) {
      Reference reference7 =
          FirebaseStorage.instance.ref().child('E-BOOK-FILE/$newId');
      await reference7.putFile(eBookPhotoFile!).whenComplete(() async {
        await reference7.getDownloadURL().then((value3) {
          eBookMap['E-BOOK_PHOTO'] = value3;
          notifyListeners();
        });
      });
    }else{
      eBookMap['E-BOOK_PHOTO'] = ebookImage;
    }
    if(from!="EDIT") {
      db.collection("E-BOOKS").doc(newId).set(eBookMap,SetOptions(merge: true));
      ScaffoldMessenger.of(context2).showSnackBar(const SnackBar(
        content: Text("E-Book Successfully Added"),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 3000),
      ));
    }else{
      db.collection("E-BOOKS").doc(bookId).set(eBookMap,SetOptions(merge: true));
      ScaffoldMessenger.of(context2).showSnackBar(const SnackBar(
        content: Text("E-Book Successfully Edited"),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 3000),
      ));
    }

    if(from!="EDIT") {
      finish(context2);
    }else{
      finish(context2);
      finish(context2);
    }
    fetchAdminEbook();
    addEbookBool = false;
    notifyListeners();
  }




  clearEBookControllers() {
    addCategoryBool=false;
    pdfPath = "";
    ebookImage = "";
    eBookPhotoFile = null;
    pdfFilePath = null;
    publishDate = DateTime.now();
    bookCategoryCt.clear();
    bookCategoryIdCt.clear();
    eBookNameCt.clear();
    eBookAuthorCt.clear();
    eBookDescriptionCt.clear();
    eBookLanguageCt.clear();
    eBookPagesCt.clear();
    eBookPublisherCt.clear();
    eBookPublicationDateCt.clear();
    notifyListeners();
  }

  /// add staff functions
  File? staffPhoto;
  TextEditingController staffName = TextEditingController();
  TextEditingController staffPhone = TextEditingController();
  TextEditingController staffPlace = TextEditingController();
  TextEditingController accessControl = TextEditingController();
  bool addStaffBool = false;
  notifyStaff() {
    addStaffBool = true;
    notifyListeners();
  }

  clearStaffControllers() {
    staffPhoto = null;
    addStaffBool = false;
    staffName.clear();
    staffPhone.clear();
    staffPlace.clear();
    accessControl.clear();
    notifyListeners();
  }

  addStaffFun(String addedBy, BuildContext context3) async {
    DateTime addDate = DateTime.now();
    String date = DateFormat('dd/MM/yy').format(addDate);
    String newId = addDate.millisecondsSinceEpoch.toString();
    Map<String, Object> staffMap = HashMap();
    staffMap["STAFF_ID"] = newId;
    staffMap["NAME"] = staffName.text;
    staffMap["PHONE"] = staffPhone.text;
    staffMap["PLACE"] = staffPlace.text;
    staffMap["TYPE"] = accessControl.text;
    staffMap["DATE"] = addDate;
    staffMap["DATE_MILLI"] = newId;
    staffMap["REF"] = "STAFF$newId";
    staffMap["ADDED_BY"] = addedBy;
    staffMap["STATUS"] = "ACTIVE";

    if (staffPhoto != null) {
      Reference reference7 =
          FirebaseStorage.instance.ref().child('STAFFS/$newId');
      await reference7.putFile(staffPhoto!).whenComplete(() async {
        await reference7.getDownloadURL().then((value3) {
          staffMap['STAFF_PHOTO'] = value3;
          notifyListeners();
        });
      });
    }
    db.collection("STAFFS").doc(newId).set(staffMap,SetOptions(merge: true));
    db.collection("USERS").doc(newId).set(staffMap,SetOptions(merge: true));
    ScaffoldMessenger.of(context3).showSnackBar(const SnackBar(
      content: Text("Staff Successfully Added"),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 3000),
    ));
    fetchStaffs();
    finish(context3);
    addStaffBool = false;
    notifyListeners();
  }

  /// fetch staffs
  List<StaffModel> staffsList = [];
  List<StaffModel> filterStaffsList = [];

  fetchStaffs() {
    staffsList.clear();
    filterStaffsList.clear();
    db.collection("STAFFS").get().then((value) {
      if (value.docs.isNotEmpty) {
        staffsList.clear();
        filterStaffsList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          staffsList.add(StaffModel(
            element.id,
            map["NAME"] ?? "",
            map["MOBILE"] ?? "",
            map["STAFF_PHOTO"] ?? "",
            map["PLACE"] ?? "",
            map["TYPE"] ?? "",
            map["DATE_MILLI"] ?? "",
            map["STATUS"] ?? "",
          ));
        }
        filterStaffsList = staffsList;
        filterStaffsList.sort((b, a) => a.date.compareTo(b.date));

        notifyListeners();
      }
      notifyListeners();
    });
  }

  void filterStaffList(String item) {
    filterStaffsList = staffsList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.phone.toLowerCase().contains(item.toLowerCase()) ||
            element.place.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }
  deleteStaff(String itemId, BuildContext context4) {
    db.collection("STAFFS").doc(itemId).delete();
    fetchStaffs();
    finish(context4);
    notifyListeners();
  }
  /// add advertisement
  File? advertisementFile;
  bool adBool = false;

  notifyAdBool() {
    adBool = true;
    notifyListeners();
  }

  addAdvertisement(String addedBy, BuildContext context4) async {
    DateTime addDate = DateTime.now();
    String date = DateFormat('dd/MM/yy').format(addDate);
    String newId = addDate.millisecondsSinceEpoch.toString();
    Map<String, Object> map = HashMap();
    map["STATUS"] = "ACTIVE";
    map["ID"] = newId;
    map["ADDED_BY"] = addedBy;
    map["DATE"] = addDate;
    map["DATE_MILLI"] = newId;
    if (advertisementFile != null) {
      Reference reference7 =
          FirebaseStorage.instance.ref().child('STAFFS/$newId');
      await reference7.putFile(advertisementFile!).whenComplete(() async {
        await reference7.getDownloadURL().then((value3) {
          map['IMAGE'] = value3;
          notifyListeners();
        });
      });
    }
    db.collection("ADVERTISEMENTS").doc(newId).set(map,SetOptions(merge: true));

    ScaffoldMessenger.of(context4).showSnackBar(const SnackBar(
      content: Text("Successfully Added"),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 3000),
    ));
    fetchAdvertisement();
    advertisementFile == null;
    adBool = false;
    notifyListeners();
  }

  String advertiseImage = "";
  String advertiseId = "";
  fetchAdvertisement() {
    advertiseImage = "";
    db.collection("ADVERTISEMENTS").get().then((value8) {
      if (value8.docs.isNotEmpty) {
        advertiseImage = "";
        Map<dynamic, dynamic> map = value8.docs.first.data();
        advertiseId = value8.docs.first.id;
        advertiseImage = map["IMAGE"] ?? "";
        notifyListeners();
      }
      notifyListeners();
    });
  }

  deleteAdvertisement(String itemId, BuildContext context4) {
    db.collection("ADVERTISEMENTS").doc(itemId).delete();
    fetchAdvertisement();
    finish(context4);
    notifyListeners();
  }

  ///carousel function
  File? carouselFileImage;
  bool carouselBool = false;
  notifyAddCarousel() {
    carouselBool = true;
    notifyListeners();
  }

  addCarousel(String addedBy, BuildContext context5) async {
    showDialog(
        context: context5,
        builder: (contextLength2) {
          return const Align(
              alignment: Alignment.center,
              child: Text("Please wait\nLoading..."));
        });
    DateTime addDate = DateTime.now();
    String date = DateFormat('dd/MM/yy').format(addDate);
    String newId = addDate.millisecondsSinceEpoch.toString();
    Map<String, Object> map = HashMap();
    map["STATUS"] = "ACTIVE";
    map["ID"] = newId;
    map["ADDED_BY"] = addedBy;
    map["DATE"] = addDate;
    map["DATE_MILLI"] = newId;
    if (carouselFileImage != null) {
      Reference reference7 =
          FirebaseStorage.instance.ref().child('STAFFS/$newId');
      await reference7.putFile(carouselFileImage!).whenComplete(() async {
        await reference7.getDownloadURL().then((value3) {
          map['IMAGE'] = value3;
          notifyListeners();
        });
      });
    }
    db.collection("CAROUSELS").doc(newId).set(map,SetOptions(merge: true));

    ScaffoldMessenger.of(context5).showSnackBar(const SnackBar(
      content: Text("Successfully Added"),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 3000),
    ));
    fetchCarouselImages();
    finish(context5);
    carouselFileImage == null;
    carouselBool = false;
    notifyListeners();
  }

  List<CarouselModel> carouselImageList = [];
  fetchCarouselImages() {
    carouselImageList = [];
    db.collection("CAROUSELS").get().then((value) {
      if (value.docs.isNotEmpty) {
        carouselImageList = [];
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          carouselImageList.add(CarouselModel(
            element.id,
            map["IMAGE"] ?? "",
            map["ADDED_BY"] ?? "",
            map["DATE_MILLI"] ?? "",
          ));
        }
        notifyListeners();
      }
      notifyListeners();
    });
  }

  deleteCarousel(String itemId, BuildContext context4) {
    db.collection("CAROUSELS").doc(itemId).delete();
    fetchCarouselImages();
    finish(context4);
    notifyListeners();
  }


  editStoreBook(BookModel item) async {
    var outputDayNode2 = DateFormat('dd-MM-yyyy');


      authorPhoto=null;
      bookCategoryCt.text = item.category;
      bookCategoryIdCt.text = item.catId;
      bookNameCt.text = item.bookName;
      authorCt.text = item.author;
      descriptionCt.text = item.description;
      pagesCt.text = item.pages;
      languageCt.text = item.language;
      bookWidth.text = item.bookWidth;
      bookHeight.text = item.bookHeight;
      publisherCt.text = item.publisher;
      bookPrice.text = item.price;
      offerPrice.text = item.offerPrice;
      bookImage = item.bookPhoto;
      publishDateCt.text =outputDayNode2.format(item.publishDate.toDate());


      notifyListeners();
  }


  editEbook(BookModel item){
    var outputDayNode2 = DateFormat('dd-MM-yyyy');

    ebookPdf = item.pdfUrl;
    pdfPath = item.pdfName;
    bookCategoryCt.text = item.category;
    bookCategoryIdCt.text = item.catId;
    eBookNameCt.text = item.bookName;
    eBookAuthorCt.text = item.author;
    eBookDescriptionCt.text = item.description;
    eBookLanguageCt.text = item.language;
    eBookPublisherCt.text = item.publisher;
    eBookPublicationDateCt.text = outputDayNode2.format(item.publishDate.toDate());
    eBookPagesCt.text = item.pages;
    ebookImage = item.bookPhoto;
    notifyListeners();
  }
  
  

  /// Fetch book fucnction
  List<BookModel> adminStoreBookList = [];

  fetchAdminStoreBook() {
    adminStoreBookList.clear();
    db.collection("BOOKS").get().then((value) {
      if (value.docs.isNotEmpty) {
        adminStoreBookList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> bookMap = element.data();
          adminStoreBookList.add(BookModel(
              element.id,
              bookMap["AUTHOR"]??"",
              bookMap["NAME"]??"",
            bookMap["BOOK_PHOTO"]??"",
              bookMap["CATEGORY"]??"",
              bookMap["LANGUAGE"]??"",
              bookMap["PRICE"]??"",
              bookMap["OFFER_PRICE"]??"",
              bookMap["PUBLISHER"]??"",
              bookMap["PAGES"]??"",
              bookMap["PUBLISHER_DATE_MILLI"].toString(),
              bookMap["DESCRIPTION"].toString(),
              bookMap["CATEGORY_ID"].toString(),
             bookMap["BOOK_WIDTH"].toString(),
             bookMap["BOOK_HEIGHT"].toString(),
             bookMap["PUBLISHER_DATE"],
            "",""
             ));
        }
        adminStoreBookList.sort((b, a) => a.id.compareTo(b.id));

        notifyListeners();
      }
    });
  }

  /// fetch E-Book Function
  List<BookModel> adminEBookList = [];

  fetchAdminEbook(){
    adminEBookList.clear();
    db.collection("E-BOOKS").get().then((value) {
      if (value.docs.isNotEmpty) {
        adminEBookList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> bookMap = element.data();
          adminEBookList.add(BookModel(
            element.id,
            bookMap["AUTHOR"]??"",
            bookMap["NAME"]??"",
            bookMap["E-BOOK_PHOTO"]??"",
            bookMap["CATEGORY"]??"",
            bookMap["LANGUAGE"]??"",
            "",
            "",
            bookMap["PUBLISHER"]??"",
            bookMap["PAGES"]??"",
            bookMap["PUBLISHER_DATE_MILLI"].toString(),
            bookMap["DESCRIPTION"].toString(),
            bookMap["CATEGORY_ID"].toString(),
            bookMap["BOOK_WIDTH"].toString(),
            bookMap["BOOK_HEIGHT"].toString(),
            bookMap["PUBLISHER_DATE"],
            bookMap["PDF_FILE_NAME"]??"",
            bookMap["PDF_FILE"]??"",
          ));
        }
        adminEBookList.sort((b, a) => a.id.compareTo(b.id));


        notifyListeners();
      }
    });
  }
  /// add category
  bool addCategoryBool=false;
  TextEditingController addCategoryCt = TextEditingController();

  trueCategoryBool(){
    addCategoryBool=true;
    notifyListeners();
  }
  falseCategoryBool(){
    addCategoryBool=false;
    addCategoryCt.clear();
    notifyListeners();
  }

  saveCategory(String addedBy,BuildContext context){
    DateTime addDate = DateTime.now();
    String newId = addDate.millisecondsSinceEpoch.toString();
    Map<String, Object> map = HashMap();
    bookCategoryCt.text = addCategoryCt.text;
    map["CATEGORY"] = addCategoryCt.text;
    map["CATEGORY_ID"] = newId;
    map["STATUS"] = "ACTIVE";
    map["DATE"] =addDate;
    map["DATE_MILLI"] =newId;
    map["ADDED_BY"] =addedBy;
    db.collection("CATEGORIES").doc(newId).set(map,SetOptions(merge: true));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Book Successfully Added"),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 3000),
    ));
    falseCategoryBool();
    fetchCategoryList();
  }
/// fetch Category

  List<CategoryModel> bookCategoryList = [];
void fetchCategoryList(){
  bookCategoryList.clear();
  db.collection("CATEGORIES").get().then((value) {
    if(value.docs.isNotEmpty){
      bookCategoryList.clear();
      for(var element in value.docs){
        Map<dynamic,dynamic>map=element.data();
        bookCategoryList.add(CategoryModel(element.id, map["CATEGORY"]??""));
      }
      notifyListeners();
    }

  });

}

List<OrderModel> adminOrderModelList = [];

adminOrderListLatest(){
  print("dfvdvdfvd");
 db.collection("ORDERS").orderBy("ORDER_TIME",descending: true).limit(10).get().then((value) {
   print("sdVDAFASCACACSD");
   print(value.docs.length.toString()+'ooooooooooooooooi');
   adminOrderModelList.clear();
   if(value.docs.isNotEmpty){
     print("asd");
     for (var element in value.docs){
       List<ItemModel> itemsList = []; // Move it here to avoid clearing inside loop
       db.collection("ORDERS")
           .doc(element.id)
           .collection("ITEMS")
           .get()
           .then((itemValue) {
         if (itemValue.docs.isNotEmpty) {
           for (var elements2 in itemValue.docs) {
             Map<dynamic, dynamic> itemMap = elements2.data();
             itemsList.add(ItemModel(
               itemMap ["BOOK_ID"] ?? "",
               itemMap ["ITEM_NAME"] ?? "",
               itemMap ["BOOK_PHOTO"] ?? "",
               itemMap ["AUTHOR"] ?? "",
               itemMap ["ITEM_PRICE"] ?? "",
               itemMap ["ITEM_CATEGORY_ID"] ?? "",
               itemMap ["ITEM_CATEGORY"] ?? "",
               itemMap ["QUANTITY"] ?? "",
             ));
           }
         }
         print(itemsList.length);
         // Notify listeners here, inside the completion block of fetching items
         notifyListeners();
       });

       print("1111111111111111111111111111111111111");
       Map<dynamic, dynamic> orderMap = element.data();
     adminOrderModelList.add(OrderModel(
         element.id,
         orderMap["CUSTOMER_NAME"]??"",
         orderMap["ITEM_NAME"]??"",
         orderMap["ITEM_TOTAL_AMOUNT"]??"",
         orderMap["ORDER_TIME"]??"",
         orderMap["CUSTOMER_PHONE"]??"",
         orderMap["ORDER_STATUS"]??"",
         orderMap["ADDRESS"]??"",
       itemsList,
         orderMap["PAYMENT_APP"]??"",
     )
     );
     }
     notifyListeners();
   }
 });
 print(adminOrderModelList.length.toString()+"dsklakfsdldkfdsl");
 notifyListeners();
}


  List<OrderModel> adminAllOrderModelList = [];
  List<OrderModel> filterAdminAllOrderModelList = [];
String selectedFirstDate = "";
String selectedSecondDate = "";

adminOrderListDateWise(var firstDate, var secondDate){
  final formatter = DateFormat('dd/MM/yyyy');
  selectedFirstDate = formatter.format(firstDate);
  selectedSecondDate = formatter.format(secondDate);
  print("dfvdvdfvd");
 db.collection("ORDERS")
     .where("ORDER_TIME" ,isGreaterThanOrEqualTo: firstDate)
     .where("ORDER_TIME",isLessThanOrEqualTo: secondDate)
     .orderBy("ORDER_TIME",descending: true).get().then((value) {

   print("sdVDAFASCACACSD");
   print(value.docs.length.toString()+'ooooooooooooooooi');


   adminAllOrderModelList.clear();
   filterAdminAllOrderModelList.clear();
   notifyListeners();

   if(value.docs.isNotEmpty){
     print("asd");
     for (var element in value.docs){
       List<ItemModel> itemsList = []; // Move it here to avoid clearing inside loop


       print("111111111111111111111__1111111111111111");
       Map<dynamic, dynamic> orderMap = element.data();

       for (var elements2 in orderMap["ORDER_ITEMS"]) {
         Map<dynamic, dynamic> itemMap = elements2;
         itemsList.add(ItemModel(
           itemMap ["BOOK_ID"] ?? "",
           itemMap ["ITEM_NAME"] ?? "",
           itemMap ["BOOK_PHOTO"] ?? "",
           itemMap ["AUTHOR"] ?? "",
           itemMap ["ITEM_PRICE"] ?? "",
           itemMap ["ITEM_CATEGORY_ID"] ?? "",
           itemMap ["ITEM_CATEGORY"] ?? "",
           itemMap ["QUANTITY"] ?? "",
         ));
       }

       adminAllOrderModelList.add(OrderModel(
         element.id,
         orderMap["CUSTOMER_NAME"]??"",
         orderMap["ITEM_NAME"]??"",
         orderMap["ITEM_TOTAL_AMOUNT"]??"",
         orderMap["ORDER_TIME"]??"",
         orderMap["CUSTOMER_PHONE"]??"",
         orderMap["ORDER_STATUS"]??"",
         orderMap["ADDRESS"]??"",
       itemsList,
         orderMap["PAYMENT_APP"]??"",
     )
     );
     }
     notifyListeners();
   }
 });
  filterAdminAllOrderModelList = adminAllOrderModelList;
 print(adminAllOrderModelList.length.toString()+"dsklakfsdldkfdsl");
 notifyListeners();
}


  filterAdminpaymentReport(String item){
    filterAdminAllOrderModelList = adminAllOrderModelList.where((element) =>
    element.customerName.toLowerCase().contains(item.toLowerCase()) ||
        element.items.any((element2) => element2.itemName.toLowerCase().contains(item.toLowerCase())))
        .toList();
    notifyListeners();
  }


  void exportExcel(List<OrderModel> ordersList,) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    final List<Object> headerRow = [
      'SL',
      'Customer Name',
      'Customer Phone',
      'Order Details', // Combine details of each item into a single cell
      'Total Amount',
      'Order Date',
      'Order Status',
      'Address',
      'Payment Method',
    ];

    sheet.importList(headerRow, 1, 1, false);

    int rowIndex = 2;
    for (int i = 0; i < ordersList.length; i++) {
      final OrderModel order = ordersList[i];

      // Combine item details into a single string
      String orderDetails = '';
      for (int j = 0; j < order.items.length; j++) {
        final ItemModel item = order.items[j];
        orderDetails +=
        '${item.itemName} by ${item.authorName}, Price: ${item.itemPrice}, Quantity: ${item.quantity}\n';
      }

      final List<Object> rowData = [
        rowIndex - 1,
        order.customerName,
        order.customerPhone,
        orderDetails,
        order.amount,
        DateFormat("yyyy-MM-dd hh:mm:ss").format(order.orderDate.toDate()),
        order.orderStatus,
        order.address,
        order.paymentMethod,
      ];

      sheet.importList(rowData, rowIndex, 1, false);
      rowIndex++;
    }

    sheet.getRangeByIndex(1, 1, 1, headerRow.length).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    // workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final fileName = '$path/OrdersReport.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);

    // if (from == "DOWNLOAD") {
    //   OpenFile.open(fileName);
    // } else {
      File testFile = File("$path/OrdersReport.xlsx");

      if (!await testFile.exists()) {
        await testFile.create(recursive: true);
        testFile.writeAsStringSync("Test for sharing documents file");
      }
      ShareExtend.share(testFile.path, "file");
    // }
  }






  List<OrderModel> adminOrderModelPlaced = [];
  List<OrderModel> adminOrderModelDispatched = [];
  List<OrderModel> adminOrderModelDelivered = [];
  fetchAdminOrderPlaced() {
    print("dfvdvdfvd");
    db.collection("ORDERS")
        .where("ORDER_STATUS", isEqualTo: "PLACED")
        .orderBy("ORDER_TIME", descending: true)
        .get()
        .then((value) {
      print("sdVDAFASCACACSD");
      print(value.docs.length.toString() + 'ooooooooooooooooi');
      adminOrderModelPlaced.clear();
      if (value.docs.isNotEmpty) {
        print("asd");
        for (var element in value.docs) {
          List<ItemModel> itemsList = []; // Move it here to avoid clearing inside loop

          Map<dynamic, dynamic> orderMap = element.data();

          for (var elements2 in orderMap["ORDER_ITEMS"]) {
            Map<dynamic, dynamic> itemMap = elements2;
            itemsList.add(ItemModel(
              itemMap ["BOOK_ID"] ?? "",
              itemMap ["ITEM_NAME"] ?? "",
              itemMap ["BOOK_PHOTO"] ?? "",
              itemMap ["AUTHOR"] ?? "",
              itemMap ["ITEM_PRICE"] ?? "",
              itemMap ["ITEM_CATEGORY_ID"] ?? "",
              itemMap ["ITEM_CATEGORY"] ?? "",
              itemMap ["QUANTITY"] ?? "",
            ));
          }
          adminOrderModelPlaced.add(OrderModel(
            element.id,
            orderMap["CUSTOMER_NAME"] ?? "",
            orderMap["ITEM_NAME"] ?? "",
            orderMap["ITEM_TOTAL_AMOUNT"] ?? "",
            orderMap["ORDER_TIME"] ?? "",
            orderMap["CUSTOMER_PHONE"] ?? "",
            orderMap["ORDER_STATUS"] ?? "",
            orderMap["ADDRESS"] ?? "",
            itemsList,
            orderMap["PAYMENT_APP"]??"",
          ));
        }
        // Don't notify listeners here, as it will be notified multiple times
      }
      // Notify listeners outside the loop, once all orders are processed
      notifyListeners();
    });
  }
  fetchAdminOrderDispatched() {
    print("dfvdvdfvd");
    db.collection("ORDERS")
        .where("ORDER_STATUS", isEqualTo: "DISPATCHED")
        .orderBy("ORDER_TIME", descending: true)
        .get()
        .then((value) {
      print("sdVDAFASCACACSD");
      print(value.docs.length.toString() + 'ooooooooooooooooi');
      adminOrderModelDispatched.clear();
      if (value.docs.isNotEmpty) {
        print("asd");
        for (var element in value.docs) {
          List<ItemModel> itemsList = []; // Move it here to avoid data corruption


          Map<dynamic, dynamic> orderMap = element.data();
          for (var elements2 in orderMap["ORDER_ITEMS"]) {
            Map<dynamic, dynamic> itemMap = elements2;
            itemsList.add(ItemModel(
              itemMap ["BOOK_ID"] ?? "",
              itemMap ["ITEM_NAME"] ?? "",
              itemMap ["BOOK_PHOTO"] ?? "",
              itemMap ["AUTHOR"] ?? "",
              itemMap ["ITEM_PRICE"] ?? "",
              itemMap ["ITEM_CATEGORY_ID"] ?? "",
              itemMap ["ITEM_CATEGORY"] ?? "",
              itemMap ["QUANTITY"] ?? "",
            ));
          }
          adminOrderModelDispatched.add(OrderModel(
            element.id,
            orderMap["CUSTOMER_NAME"] ?? "",
            orderMap["ITEM_NAME"] ?? "",
            orderMap["ITEM_TOTAL_AMOUNT"] ?? "",
            orderMap["ORDER_TIME"] ?? "",
            orderMap["CUSTOMER_PHONE"] ?? "",
            orderMap["ORDER_STATUS"] ?? "",
            orderMap["ADDRESS"] ?? "",
            itemsList,
            orderMap["PAYMENT_APP"]??"",
          ));
        }
      }
      // Notify listeners outside the loop, once all orders are processed
      notifyListeners();
    });
  }

  fetchAdminOrderDelivered() {
    print("dfvdvdfvd");
    db.collection("ORDERS")
        .where("ORDER_STATUS", isEqualTo: "DELIVERED")
        .orderBy("ORDER_TIME", descending: true)
        .get()
        .then((value) {
      print("sdVDAFASCACACSD");
      print(value.docs.length.toString() + 'ooooooooooooooooi');
      adminOrderModelDelivered.clear();
      if (value.docs.isNotEmpty) {
        print("asd");
        for (var element in value.docs) {
          List<ItemModel> itemsList = []; // Move it here to avoid data corruption

          Map<dynamic, dynamic> orderMap = element.data();

          for (var elements2 in orderMap["ORDER_ITEMS"]) {
            Map<dynamic, dynamic> itemMap = elements2;
            itemsList.add(ItemModel(
              itemMap ["BOOK_ID"] ?? "",
              itemMap ["ITEM_NAME"] ?? "",
              itemMap ["BOOK_PHOTO"] ?? "",
              itemMap ["AUTHOR"] ?? "",
              itemMap ["ITEM_PRICE"] ?? "",
              itemMap ["ITEM_CATEGORY_ID"] ?? "",
              itemMap ["ITEM_CATEGORY"] ?? "",
              itemMap ["QUANTITY"] ?? "",
            ));
          }
          adminOrderModelDelivered.add(OrderModel(
            element.id,
            orderMap["CUSTOMER_NAME"] ?? "",
            orderMap["ITEM_NAME"] ?? "",
            orderMap["ITEM_TOTAL_AMOUNT"] ?? "",
            orderMap["ORDER_TIME"] ?? "",
            orderMap["CUSTOMER_PHONE"] ?? "",
            orderMap["ORDER_STATUS"] ?? "",
            orderMap["ADDRESS"] ?? "",
            itemsList,
            orderMap["PAYMENT_APP"]??"",
          ));
        }
      }
      // Notify listeners outside the loop, once all orders are processed
      notifyListeners();
    });
  }



  adminChangeOrderStatus(BuildContext context, String itemID,String from,String userId,String userName){



    DateTime addDate = DateTime.now();
    Map<String, Object> statusMap = HashMap();
    if(from.toUpperCase()=="DISPATCHED") {
      statusMap["ORDER_STATUS"] = "DISPATCHED";
      statusMap["ORDER_STATUS_DISPATCHED_BY_NAME"] = userName;
      statusMap["ORDER_STATUS_DISPATCHED_BY_ID"] = userId;
      statusMap["ORDER_STATUS_DISPATCHED_BY_DATE"] = addDate;
      statusMap["ORDER_STATUS_DISPATCHED_BY_DATE_MILLI"] =addDate.microsecondsSinceEpoch.toString();
    }else{
      statusMap["ORDER_STATUS"] = "DELIVERED";
      statusMap["ORDER_STATUS_DELIVERED_BY_NAME"] = userName;
      statusMap["ORDER_STATUS_DELIVERED_BY_ID"] = userId;
      statusMap["ORDER_STATUS_DELIVERED_BY_DATE"] = addDate;
      statusMap["ORDER_STATUS_DELIVERED_BY_DATE_MILLI"] =addDate.microsecondsSinceEpoch.toString();
    }

    db.collection("ORDERS").doc(itemID).set(statusMap,SetOptions(merge: true));
    notifyListeners();
    if(from.toUpperCase()=="DISPATCHED") {
      callNextReplacement(OrdersScreen(initialTab: 1,userId:userId ,userName: userName,), context);
    }else{
      callNextReplacement(OrdersScreen(initialTab: 2,userId:userId ,userName: userName), context);
    }

    fetchAdminOrderDelivered();
    fetchAdminOrderDispatched();
    fetchAdminOrderPlaced();
  }



  deletePosterAlert(BuildContext context, String itemID, String from) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            scrollable: true,
            title: const Text(
              "Delete Alert !!!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Do you want to Delete?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "AnekMalayalamRegular"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                            // color: clC00000,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: clC00000, width: 1)),
                        child: TextButton(
                            child: const Text(
                              'NO',
                              style: TextStyle(color: clC00000),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                          color: clFFFFFF,
                          gradient: LinearGradient(
                            colors: [
                              clC00000,
                              clC00000.withOpacity(0.65),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                            child: const Text('YES',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              if (from == "ADVERTISEMENT") {
                                deleteAdvertisement(itemID, context);
                              } else if(from=="STAFF") {
                                deleteStaff(itemID, context);
                              } else {
                                deleteCarousel(itemID, context);
                              }
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }



  deleteBook(String bookId,String from,BuildContext context){
  if(from == "STORE"){
    db.collection("BOOKS").doc(bookId).delete();
    fetchAdminStoreBook();
  }else{
    db.collection("E-BOOKS").doc(bookId).delete();
    fetchAdminEbook();
  }
  finish(context);
  notifyListeners();
  }
  
  
  deleteBookAlert(BuildContext context, String itemID, String from) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            scrollable: true,
            title: const Text(
              "Delete Alert !!!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Do you want to Delete?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "AnekMalayalamRegular"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                          // color: clC00000,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: clC00000, width: 1)),
                        child: TextButton(
                            child: const Text(
                              'NO',
                              style: TextStyle(color: clC00000),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                          color: clFFFFFF,
                          gradient: LinearGradient(
                            colors: [
                              clC00000,
                              clC00000.withOpacity(0.65),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                            child: const Text('YES',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              deleteBook(itemID,from,context);
                              finish(context);
                            }
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }


  orderDetailsAlert(BuildContext context, String itemID, String from,String userId,String userName) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            scrollable: true,
            title:  Text(
              "$from Alert !!!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Do you want to $from this order?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "AnekMalayalamRegular"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                          // color: clC00000,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xFF285D5B), width: 1)),
                        child: TextButton(
                            child: const Text(
                              'NO',
                              style: TextStyle(color: Color(0xFF285D5B)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                          color: clFFFFFF,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF285D5B),
                              Color(0xFF1B4341).withOpacity(0.65),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                            child: const Text('YES',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              adminChangeOrderStatus(context,itemID,from,userId,userName);
                              // finish(context);
                            }
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }



  DateRangePickerController dateRangePickerController =
  DateRangePickerController();
  final DateTime _startDate = DateTime.now();
  final DateTime _endDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime secondDate = DateTime.now();
  DateTime endDate2 = DateTime.now();
  String startDateFormat = '';
  String endDateFormat = '';
  String showSelectedDate = '';
  bool isDateSelected = false;

  //firstDateUserHis  endDate2UserHis
  void showCalendarDialog(BuildContext context,String fromWhere) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: dateRangePickerController,
          initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 25.0,

          showTodayButton: false,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) async {
            isDateSelected = true;
            // isDateSelected = true;
            dateRangePickerController.selectedRange = val as PickerDateRange?;
            if (dateRangePickerController.selectedRange!.endDate == null) {
              ///single date picker
              firstDate = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.startDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              final formatter = DateFormat('dd/MM/yyyy');

              showSelectedDate = formatter.format(firstDate);
              if(fromWhere=="PAYMENT_REPORT"){
                await adminOrderListDateWise(firstDate2, endDate2);
              }else{
                await fetchSalesReportCalenderWise(firstDate2, endDate2);
              }






              notifyListeners();
            } else {
              ///two dates select picker
              firstDate = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.endDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              isDateSelected = true;

              final formatter = DateFormat('dd/MM/yyyy');
              startDateFormat = formatter.format(firstDate);
              endDateFormat = formatter.format(secondDate);
              if (startDateFormat != endDateFormat) {
                showSelectedDate = "$startDateFormat - $endDateFormat";
              } else {
                showSelectedDate = startDateFormat;
              }
              if(fromWhere=="PAYMENT_REPORT"){
                await adminOrderListDateWise(firstDate2, endDate2);
              }else{
                await fetchSalesReportCalenderWise(firstDate2, endDate2);

              }


              notifyListeners();
            }
            finish(context);
          },
          onCancel: () async {
            isDateSelected = false;
            dateRangePickerController.selectedRange = null;
            dateRangePickerController.selectedDate = null;
            showSelectedDate = '';
             if(fromWhere=="SALES_REPORT"){
               fetchSalesReport();
               saleFirstDate = "";
               saleSecondDate = "";
             }
            notifyListeners();
            finish(context);
          },
        ),
      );
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            // title: Container(
            //     child: Text('Printers', style: TextStyle(color: my_white))),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }
List<SalesReportModel>salesReportList=[];
List<SalesReportModel>filterSalesReportList=[];


  fetchSalesReport(){
    salesReportList.clear();
    filterSalesReportList.clear();
    db.collection("SALES_REPORT").get().then((value3) {
      if(value3.docs.isNotEmpty){
        salesReportList.clear();
        filterSalesReportList.clear();
        print("salesreportttttttttttttt ");
        Map<String, List<SalesReportModel>> orderBookList = {};
        for(var element in value3.docs){
          Map<dynamic, dynamic> reportMap = element.data();
          String bookId =reportMap["BOOK_ID"]??"";
          String authorName = reportMap["AUTHOR"]??"";
          String bookName = reportMap["ITEM_NAME"]??"";
          String bookImage = reportMap["BOOK_PHOTO"]??"";
          String bookPrice = reportMap["ITEM_PRICE"]??"";
          String dateMilli = reportMap["DATE_MILLI"]??"";
          if (!orderBookList.containsKey(bookId)) {
            orderBookList[bookId] = [];
          }

          orderBookList[bookId]!.add(SalesReportModel(
              bookId,
              authorName,
              bookName,
              bookImage,
              bookPrice,
              dateMilli,
          ));
        }
        orderBookList.forEach((bookId, orders) {
          // double totalCount = orders.fold(0, (previousValue, e) => previousValue + e.totalCount);
          double totalAmount = orders.fold(0, (previousValue, e) => previousValue + double.parse(e.price));
          String bookId = orders.isNotEmpty ? orders.first.bookId : "";
          String authorName = orders.isNotEmpty ? orders.first.authorName : "";
          String bookName = orders.isNotEmpty ? orders.first.bookName : "";
          String bookImage =  orders.first.bookImage;
          String bookPrice =  orders.first.price;
          String dateMillis =  orders.first.dateMilli;
          int orderCount = orders.length;

          salesReportList.add(SalesReportModel(
            bookId,
            authorName,
            bookName,
            bookImage,
            bookPrice,
              dateMillis,
              totalPrice: totalAmount,
              totalCount: orderCount
          ));
          filterSalesReportList=salesReportList;
          filterSalesReportList.sort((b, a) => a.dateMilli.compareTo(b.dateMilli));

          notifyListeners();
        });
      }else{
        salesReportList.clear();
        filterSalesReportList.clear();
        notifyListeners();
      }
      notifyListeners();


    });

  }
  String saleFirstDate = "";
  String saleSecondDate = "";
  fetchSalesReportCalenderWise(var firstDate, var secondDate){
    final formatter = DateFormat('dd/MM/yyyy');
    saleFirstDate = formatter.format(firstDate);
    saleSecondDate = formatter.format(secondDate);
    salesReportList.clear();
    filterSalesReportList.clear();
    db.collection("SALES_REPORT")
        .where("ORDER_TIME" ,isGreaterThanOrEqualTo: firstDate)
        .where("ORDER_TIME",isLessThanOrEqualTo: secondDate)
        .orderBy("ORDER_TIME",descending: true)
        .get().then((value3) {
      if(value3.docs.isNotEmpty){
        salesReportList.clear();
        filterSalesReportList.clear();
        print("salesreportttttttttttttt ");
        Map<String, List<SalesReportModel>> orderBookList = {};
        for(var element in value3.docs){
          Map<dynamic, dynamic> reportMap = element.data();
          String bookId =reportMap["BOOK_ID"]??"";
          String authorName = reportMap["AUTHOR"]??"";
          String bookName = reportMap["ITEM_NAME"]??"";
          String bookImage = reportMap["BOOK_PHOTO"]??"";
          String bookPrice = reportMap["ITEM_PRICE"]??"";
          String dateMilli = reportMap["DATE_MILLI"]??"";

          if (!orderBookList.containsKey(bookId)) {
            orderBookList[bookId] = [];
          }

          orderBookList[bookId]!.add(SalesReportModel(
              bookId,
              authorName,
              bookName,
              bookImage,
              bookPrice,
              dateMilli,
          ));
        }
        orderBookList.forEach((bookId, orders) {
          // double totalCount = orders.fold(0, (previousValue, e) => previousValue + e.totalCount);
          double totalAmount = orders.fold(0, (previousValue, e) => previousValue + double.parse(e.price));
          String bookId = orders.isNotEmpty ? orders.first.bookId : "";
          String authorName = orders.isNotEmpty ? orders.first.authorName : "";
          String bookName = orders.isNotEmpty ? orders.first.bookName : "";
          String bookImage =  orders.first.bookImage;
          String bookPrice =  orders.first.price;
          String dateMillis =  orders.first.dateMilli;

          int orderCount = orders.length;

          salesReportList.add(SalesReportModel(
            bookId,
            authorName,
            bookName,
            bookImage,
            bookPrice,
              dateMillis,
              totalPrice: totalAmount,
              totalCount: orderCount
          ));
          filterSalesReportList=salesReportList;
          filterSalesReportList.sort((b, a) => a.dateMilli.compareTo(b.dateMilli));

          notifyListeners();
        });
      }else{
        salesReportList.clear();
        filterSalesReportList.clear();
        notifyListeners();
      }
      notifyListeners();


    });

  }

  filterSalesReport(String item){
    filterSalesReportList=salesReportList.where((element) =>
    element.bookId.toLowerCase().contains(item.toLowerCase()) ||
    element.bookName.toLowerCase().contains(item.toLowerCase()) ||
    element.authorName.toLowerCase().contains(item.toLowerCase())).toList();
    notifyListeners();
  }


  logOut(BuildContext context,) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            scrollable: true,
            title:  Text(
              "logout Alert !!!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Do you want to logout?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "AnekMalayalamRegular"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                          // color: clC00000,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xFF285D5B), width: 1)),
                        child: TextButton(
                            child: const Text(
                              'NO',
                              style: TextStyle(color: Color(0xFF285D5B)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                          color: clFFFFFF,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF285D5B),
                              Color(0xFF1B4341).withOpacity(0.65),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                            child: const Text('YES',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences
                                  .getInstance();
                              prefs.clear();
                              callNextReplacement(LoginScreenAdmin(), context);
                              // finish(context);
                            }
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

}
