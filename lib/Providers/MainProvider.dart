import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:grace_book_latest/Model/cart_Model.dart';
import 'package:grace_book_latest/Model/save_to_library_model.dart';
import 'package:grace_book_latest/Model/staffModel.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grace_book_latest/Model/store_book_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/E_book_Model.dart';
import '../Model/book_Model.dart';
import '../Model/favorite_model_class.dart';
import '../Model/orderModel.dart';
import '../Model/searchBookModel.dart';
import '../Model/upiModel.dart';
import '../Payment _gateway/paymentSuccess_Screen.dart';
import '../UpdateSCreen/update_Screen.dart';
import '../UserScreens/home_Screen.dart';
import '../constants/myWidgets.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class MainProvider extends ChangeNotifier {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static const platformChanel = MethodChannel('payuGateway');
  final ImagePicker picker = ImagePicker();
  File? fileImage;
  bool numberVerified = false;

  bool paymentScreen = false;
  bool nameColor = false;
  bool deliveryLocationColor = false;
  bool mobileColor = false;
  bool addressColor = false;
  bool stateColor = false;
  bool districtColor = false;
  bool postOfficeColor = false;
  bool pinColor = false;
  bool libraryBool = false;
  bool cartBool = false;

  MainProvider() {
    getAppVersion();
  }

  /// lock app
  String? appVersion;
  String currentVersion = '';
  String buildNumber = "";
  void lockApp() {
    print(' KVJFJVKRGVW');
    mRoot.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        print(event.toString() + ' klmvlrt');
        print(appVersion.toString() + ' UJJJJJJJJJJJ');
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions =
            map[!Platform.isIOS ? 'AppVersion' : 'iOSVersion']
                .toString()
                .split(',');
        print(versions.toString() + ' FNVF');
        if (!versions.contains(appVersion)) {
          String ADDRESS =
              map[!Platform.isIOS ? 'ADDRESS' : 'ADDRESS_iOS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

  /// payment to firestore

  Future<bool> getPinCodeApiToAttempt(String pincode) async {
    final url = Uri.parse('https://api.postalpincode.in/pincode/$pincode');
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        for (var item in jsonData) {
          final List<dynamic> newMap = item['PostOffice'];
          for (var element in newMap) {
            userStateController.text = element['State'].toString();
            userDistrictController.text = element['District'].toString();
          }
          // ... other fields
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void attempt(
    String orderId,
    String customId,
    String bookId,
    String bookName,
    String bookCategory,
    String bookCategoryId,
    String bookPrice,
  ) async {
    DateTime addDate = DateTime.now();
    String newId = addDate.millisecondsSinceEpoch.toString();
    Map<String, Object> map = HashMap();
    Map<String, Object> bookMap = HashMap();
    if (Platform.isIOS) {
      map["PLATFORM"] = "IOS";
    } else if (Platform.isAndroid) {
      map["PLATFORM"] = "ANDROID";
    } else {
      map["PLATFORM"] = "NIL";
    }
    String? strDeviceID = "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    map["ORDER_DATE"] = addDate;
    map["ORDER_DATE_MILLI"] = newId;
    map["CUSTOMER_ID"] = customId;
    map["CUSTOMER_NAME"] = orderNameController.text;
    map["ORDER_ID"] = orderId;
    map["ORDER_STATUS"] = "ATTEMPT";
    map["APP_VERSION"] = appVersion!;
    map["PHONE"] = orderPhoneController.text;
    map["ADDRESS"] = orderAddressController.text;
    map["POST_OFFICE"] = orderPostOfficeController.text;
    map["PIN"] = orderPinCodeController.text;
    map["STATE"] = orderStateController.text;
    map["DISTRICT"] = orderDistrictController.text;
    map["LOCATION"] = orderLocationController.text;
    map["DEVICE_ID"] = strDeviceID!;

    bookMap["ITEM_NAME"] = bookName;
    bookMap["ITEM_ID"] = bookId;
    bookMap["ITEM_PRICE"] = bookPrice;
    bookMap["ITEM_CATEGORY"] = bookCategoryId;
    bookMap["QUANTITY"] = 1;
    bookMap["DATE"] = addDate;
    bookMap["DATE_MILLI"] = newId;

    db.collection("ATTEMPT").doc(orderId).set(map, SetOptions(merge: true));
    db
        .collection("ATTEMPT")
        .doc(orderId)
        .collection("ITEMS")
        .doc(bookId)
        .set(bookMap, SetOptions(merge: true));
    attemptButton = false;

    notifyListeners();
  }

  Future<void> getAppVersion() async {
    PackageInfo.fromPlatform().then((value) {
      currentVersion = value.version;
      buildNumber = value.buildNumber;
      appVersion = buildNumber;
      print(appVersion.toString() + "edfesappversion");
      notifyListeners();
    });
  }


  double gridHeight=0;

  void gridHeightCheck(){
    gridHeight=  filterHomeScreenStoreBookList.length>=filterHomeScreenEbookList.length?
    270+(filterHomeScreenStoreBookList.length*200):
    180+(filterHomeScreenEbookList.length*155) ;
    print(gridHeight);
    print("eygfeirfherlfrehi");

    notifyListeners();
  }


  void toggleCheckbox(int index) {

    allCartList[index].select=allCartList[index].select?false:true;
    selectCardItemList = allCartList.where((element) => element.select).toSet().toList();


    notifyListeners();
  }
  clearCartDetails(){
    selectCardItemList.clear();
    for(var element in allCartList){
      element.select=false;
    }
    notifyListeners();
  }

  void textFieldColorChange(String val) {
    if (val == "Name") {
      nameColor = true;
      deliveryLocationColor = false;
      mobileColor = false;
      addressColor = false;
      stateColor = false;
      districtColor = false;
      postOfficeColor = false;
      pinColor = false;
    } else if (val == "Location Address") {
      nameColor = false;
      deliveryLocationColor = true;
      mobileColor = false;
      addressColor = false;
      stateColor = false;
      districtColor = false;
      postOfficeColor = false;
      pinColor = false;
    } else if (val == "Mobile Number") {
      nameColor = false;
      deliveryLocationColor = false;
      mobileColor = true;
      addressColor = false;
      stateColor = false;
      districtColor = false;
      postOfficeColor = false;
      pinColor = false;
    } else if (val == "Address") {
      nameColor = false;
      deliveryLocationColor = false;
      mobileColor = false;
      addressColor = true;
      stateColor = false;
      districtColor = false;
      postOfficeColor = false;
      pinColor = false;
    } else if (val == "State") {
      nameColor = false;
      deliveryLocationColor = false;
      mobileColor = false;
      addressColor = false;
      stateColor = true;
      districtColor = false;
      postOfficeColor = false;
      pinColor = false;
    } else if (val == "District") {
      nameColor = false;
      deliveryLocationColor = false;
      mobileColor = false;
      addressColor = false;
      stateColor = false;
      districtColor = true;
      postOfficeColor = false;
      pinColor = false;
    } else if (val == "Post office") {
      nameColor = false;
      deliveryLocationColor = false;
      mobileColor = false;
      addressColor = false;
      stateColor = false;
      districtColor = false;
      postOfficeColor = true;
      pinColor = false;
    } else if (val == "Pin") {
      nameColor = false;
      deliveryLocationColor = false;
      mobileColor = false;
      addressColor = false;
      stateColor = false;
      districtColor = false;
      postOfficeColor = false;
      pinColor = true;
    } else {
      nameColor = false;
      deliveryLocationColor = false;
      mobileColor = false;
      addressColor = false;
      stateColor = false;
      districtColor = false;
      postOfficeColor = false;
      pinColor = false;
    }
    notifyListeners();
  }

  void paymentScreenNavigation(bool val) {
    paymentScreen = val;
    notifyListeners();
  }

  List<StoreBookModel> homeScreenStoreBookList = [];
  List<StoreBookModel> filterHomeScreenStoreBookList = [];
  List<StoreBookModel> suggestionBookList = [];
  List<EbookModel> homeScreenEbookList = [];
  List<EbookModel> filterHomeScreenEbookList = [];
  List<String> carouselList = [];
  List<String> advertisementList = [];
  List<SaveToLibraryModel> savedLibraryList = [];
  List<FavoriteModel> allFavoriteList = [];
  List<CartModelClass> allCartList = [];

  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userStateController = TextEditingController();
  TextEditingController userDistrictController = TextEditingController();
  TextEditingController userPostOfficeController = TextEditingController();
  TextEditingController userPinCodeController = TextEditingController();
  TextEditingController orderNameController = TextEditingController();
  TextEditingController orderLocationController = TextEditingController();
  TextEditingController orderPhoneController = TextEditingController();
  TextEditingController orderAddressController = TextEditingController();
  TextEditingController orderStateController = TextEditingController();
  TextEditingController orderDistrictController = TextEditingController();
  TextEditingController orderPostOfficeController = TextEditingController();
  TextEditingController orderPinCodeController = TextEditingController();
  TextEditingController transactionID = TextEditingController();


  int? defaultPage ;
  String? defaultBookName ;
  String? defaultBookImage ;
  String? defaultBookPdfLink ;
  String? defaultBookAuthor  ;
 void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    defaultPage = prefs.getInt('pageIndex');
    defaultBookName = prefs.getString('bookName');
    defaultBookImage = prefs.getString('bookImage');
    defaultBookPdfLink = prefs.getString('pdfUrl');
    defaultBookAuthor = prefs.getString('authorName');
  }

  String userId = "";
  String userName = "";
  String userNumber = "";
  String userProfileImage = "";
  String userAddress = "";
  String userState = "";
  String userDistrict = "";
  String userPostOffice = "";
  String userPin = "";
  bool personalDetailsEdit = false;
  bool deliveryDetailsEdit = false;

  void fetchUserDetails(String id) {
    print("haiefhawiurhfriwh");
    db.collection("CUSTOMERS").doc(id).snapshots().listen((event) {
      Map<dynamic, dynamic> userMap = event.data() as Map;
      userId = id;
      userName = userMap["NAME"] ?? "";
      print(userMap["NAME"] ?? "");
      print("kfkuhdblirefnleirfreilbcij");
      userNameController.text = userMap["NAME"] ?? "";
      orderNameController.text = userMap["NAME"] ?? "";
      userNumber = userMap["PHONE"] ?? "";
      userPhoneController.text = userMap["PHONE"] ?? "";
      orderPhoneController.text = userMap["PHONE"] ?? "";
      userProfileImage = userMap["PROFILE_IMAGE"] ?? "";
      userAddress = userMap["ADDRESS"] ?? "";
      userAddressController.text = userMap["ADDRESS"] ?? "";
      orderAddressController.text = userMap["ADDRESS"] ?? "";
      userState = userMap["STATE"] ?? "";
      userStateController.text = userMap["STATE"] ?? "";
      orderStateController.text = userMap["STATE"] ?? "";
      userDistrict = userMap["DISTRICT"] ?? "";
      userDistrictController.text = userMap["DISTRICT"] ?? "";
      orderDistrictController.text = userMap["DISTRICT"] ?? "";
      userPostOffice = userMap["POST_OFFICE"] ?? "";
      userPostOfficeController.text = userMap["POST_OFFICE"] ?? "";
      orderPostOfficeController.text = userMap["POST_OFFICE"] ?? "";
      userPin = userMap["PIN_CODE"] ?? "";
      userPinCodeController.text = userMap["PIN_CODE"] ?? "";
      orderPinCodeController.text = userMap["PIN_CODE"] ?? "";
      notifyListeners();
    });
  }

  Future<void> addDeliveryAddress(String docId) async {
    HashMap<String, Object> map = HashMap();
    map["ADDRESS"] = userAddressController.text;
    map["STATE"] = userStateController.text;
    map["DISTRICT"] = userDistrictController.text;
    map["POST_OFFICE"] = userPostOfficeController.text;
    map["PIN_CODE"] = userPinCodeController.text;
    db.collection("CUSTOMERS").doc(docId).set(map, SetOptions(merge: true));
    notifyListeners();
  }

  Future<bool> getPinCodeApi(String pincode) async {
    final url = Uri.parse('https://api.postalpincode.in/pincode/$pincode');
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        for (var item in jsonData) {
          final List<dynamic> newMap = item['PostOffice'];
          for (var element in newMap) {
            userStateController.text = element['State'].toString();
            userDistrictController.text = element['District'].toString();
          }
          // ... other fields
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Reference ref3 = FirebaseStorage.instance.ref("PROFILE_IMAGE");

  Future<void> editPersonalDetails(String docId) async {
    HashMap<String, Object> map = HashMap();

    map["NAME"] = userNameController.text;
    map["PHONE"] = userPhoneController.text;
    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref3 = FirebaseStorage.instance.ref().child(time);
      await ref3.putFile(fileImage!).whenComplete(() async {
        await ref3.getDownloadURL().then((value2) {
          map['PROFILE_IMAGE'] = value2;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      map['PROFILE_IMAGE'] = userProfileImage;
    }

    db.collection("CUSTOMERS").doc(docId).set(map, SetOptions(merge: true));
    db.collection("USERS").doc(docId).set(map, SetOptions(merge: true));
  }

  void personalDetailEditClick() {
    numberVerified = false;
    personalDetailsEdit = !personalDetailsEdit;
    notifyListeners();
  }

  void deliveryDetailEditClick() {
    deliveryDetailsEdit = !deliveryDetailsEdit;
    notifyListeners();
  }

  void showBottomSheet(
    BuildContext context,
  ) {
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
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.camera_enhance_sharp,
                      // color: cl172f55,
                    ),
                    title: const Text(
                      'Camera',
                    ),
                    onTap: () => {imageFromCamera(), Navigator.pop(context)}),
                ListTile(
                    leading: const Icon(
                      Icons.photo,
                      //color: cl172f55
                    ),
                    title: const Text(
                      'Gallery',
                    ),
                    onTap: () => {imageFromGallery(), Navigator.pop(context)}),
              ],
            ),
          );
        });
    // ImageSource
  }

  imageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    } else {}
    if (pickedFile!.path.isEmpty) {
      retrieveLostData();
    }

    notifyListeners();
  }

  imageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage(
        pickedFile.path,
      );
    } else {}
    if (pickedFile!.path.isEmpty) {
      retrieveLostData();
    }

    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileImage = File(response.file!.path);

      notifyListeners();
    }
  }

  Future<void> _cropImage(
    String path,
  ) async {
    print("hai$path");
    final croppedFile = await ImageCropper().cropImage(
      cropStyle: CropStyle.circle,
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
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
        )
      ],
    );
    print("hello$path");

    if (croppedFile != null) {
      fileImage = File(croppedFile.path);
    }

    notifyListeners();
  }

  Future<bool> checkNumberExist(String phone) async {
    var D = await db.collection("USERS").where("PHONE", isEqualTo: phone).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void fetchHomeStoreBook(String from,String categoryId) {
    filterHomeScreenStoreBookList.clear();
    homeScreenStoreBookList.clear();
    suggestionBookList.clear();
    List<String> nullList = [];

    db.collection("BOOKS").get().then((value) {
      if (value.docs.isNotEmpty) {
        filterHomeScreenStoreBookList.clear();
        homeScreenStoreBookList.clear();
        suggestionBookList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> bookMap = elements.data();
          List<String>? favoriteList;
          List<String>? addCartList;
          if (bookMap["FAVORITE_LIST"] != null) {
            favoriteList = (bookMap["FAVORITE_LIST"] as List<dynamic>).map((item) => item.toString()).toList();
          } else {
            favoriteList = nullList;
          }
          if (bookMap["CART_LIST"] != null) {
            addCartList = (bookMap["CART_LIST"] as List<dynamic>)
                .map((item) => item.toString())
                .toList();
          } else {
            addCartList = nullList;
          }
          homeScreenStoreBookList.add(StoreBookModel(
              elements.id,
              bookMap["NAME"],
              bookMap["BOOK_PHOTO"],
              bookMap["AUTHOR"],
              bookMap["PRICE"],
              bookMap["TYPE"]??"",
              bookMap["OFFER_PRICE"],
              bookMap["DESCRIPTION"],
              bookMap["CATEGORY"] ?? "",
              bookMap["CATEGORY_ID"] ?? "",
              favoriteList,addCartList,[],""));
        }
        if(from=="SPLASH"){
          filterHomeScreenStoreBookList=homeScreenStoreBookList;
          suggestionBookList=homeScreenStoreBookList.take(8).toSet().toList();
          print("length home screen "+filterHomeScreenStoreBookList.length.toString());
          notifyListeners();
        }else{
          filterHomeScreenStoreBookList=homeScreenStoreBookList.where((element) =>element.bookCategoryId==categoryId).toSet().toList();
        }

        notifyListeners();
      }else{
        filterHomeScreenStoreBookList.clear();
        homeScreenStoreBookList.clear();
        suggestionBookList.clear();
      }
    });
  }
  categoryWiseSortHomeStoreBook(String categoryId){
    filterHomeScreenStoreBookList=homeScreenStoreBookList.where((element) =>element.bookCategoryId==categoryId).toSet().toList();
    print("enteredwwwwwwwwwwwww "+filterHomeScreenStoreBookList.length.toString());
    notifyListeners();
  }

  void fetchHomeEBook(String from,String categoryId) {
    homeScreenEbookList.clear();
    filterHomeScreenStoreBookList.clear();
    List<String> nullList = [];
    db.collection("E-BOOKS").get().then((value) {
      if (value.docs.isNotEmpty) {
        homeScreenEbookList.clear();
        filterHomeScreenStoreBookList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> bookMap = elements.data();
          List<String>? favoriteList;
          List<String>? libraryList;
          if (bookMap["FAVORITE_LIST"] != null) {
            favoriteList = (bookMap["FAVORITE_LIST"] as List<dynamic>)
                .map((item) => item.toString())
                .toList();
          } else {
            favoriteList = nullList;
          }
          if (bookMap["LIBRARY_LIST"] != null) {
            libraryList = (bookMap["LIBRARY_LIST"] as List<dynamic>)
                .map((item) => item.toString())
                .toList();
          } else {
            libraryList = nullList;
          }
          homeScreenEbookList.add(EbookModel(
              elements.id,
              bookMap["NAME"],
              bookMap["E-BOOK_PHOTO"],
              bookMap["AUTHOR"],
              bookMap["DESCRIPTION"],
              bookMap["CATEGORY"],
              bookMap["CATEGORY_ID"],
              favoriteList,
              libraryList));

          print("listsdcvsfdssds");
        }
        if(from=="SPLASH"){
          filterHomeScreenEbookList=homeScreenEbookList;
        }else{
          filterHomeScreenEbookList=homeScreenEbookList.where((element) =>element.categoryId==categoryId).toSet().toList();
        }

        gridHeightCheck();
        notifyListeners();
      }else{
        gridHeightCheck();
        homeScreenEbookList.clear();
        filterHomeScreenStoreBookList.clear();
      }
    });
  }
  String selectedTab="BOOK";
  categoryWiseSortHomeEBook(String categoryId) {
    filterHomeScreenEbookList=homeScreenEbookList.where((element) =>element.categoryId==categoryId).toSet().toList();
    print("filter list length "+filterHomeScreenEbookList.length.toString());
    notifyListeners();
  }

    /// fetch image details
  String ebookAuthor = "";
  String ebookName = "";
  String ebookDescription = "";
  String ebookPage = "";
  String ebookLanguage = "";
  String ebookPublisher = "";
  String ebookPdfUrl = "";
  int ebookPublicationDate = 0;
  List<String> savedList = [];
  List<String> cartList = [];
  List<String> pubFavoriteList = [];
  List<String> libraryFavList = [];
  List<String> nullList = [];

  fetchEbookDetailsByItem(String itemId) {
    ebookAuthor = "";
    ebookName = "";
    ebookDescription = "";
    ebookPage = "";
    ebookLanguage = "";
    ebookPublisher = "";
    ebookPdfUrl = "";
    ebookPublicationDate = 0;
    savedList.clear();
    db.collection("E-BOOKS").doc(itemId).get().then((value4) {
      if (value4.exists) {
        Map<dynamic, dynamic> map = value4.data() as Map;
        ebookAuthor = map["AUTHOR"] ?? "";
        ebookName = map["NAME"] ?? "";
        ebookDescription = map["DESCRIPTION"] ?? "";
        ebookPage = map["PAGES"] ?? "";
        ebookLanguage = map["LANGUAGE"] ?? "";
        ebookPublisher = map["PUBLISHER"] ?? "";
        ebookPublicationDate = map["PUBLISHER_DATE_MILLI"];
        ebookPdfUrl = map["PDF_FILE"];
        if (map["LIBRARY_LIST"] != null) {
          savedList = (map["LIBRARY_LIST"] as List<dynamic>).map((item) => item.toString()).toList();
        } else {
          savedList = nullList;
        } if (map["FAVORITE_LIST"] != null) {
          libraryFavList = (map["FAVORITE_LIST"] as List<dynamic>).map((item) => item.toString()).toList();
        } else {
          libraryFavList = nullList;
        }
      }
      notifyListeners();
    });
  }

  fetchBookDetailsByItem(String itemId) {
    ebookAuthor = "";
    ebookName = "";
    ebookDescription = "";
    ebookPage = "";
    ebookLanguage = "";
    ebookPublisher = "";
    ebookPdfUrl = "";
    ebookPublicationDate = 0;

    db.collection("BOOKS").doc(itemId).get().then((value4) {
      if (value4.exists) {
        Map<dynamic, dynamic> map = value4.data() as Map;
        ebookAuthor = map["AUTHOR"] ?? "";
        ebookName = map["NAME"] ?? "";
        ebookDescription = map["DESCRIPTION"] ?? "";
        ebookPage = map["PAGES"] ?? "";
        ebookLanguage = map["LANGUAGE"] ?? "";
        ebookPublisher = map["PUBLISHER"] ?? "";
        ebookPublicationDate = map["PUBLISHER_DATE_MILLI"];
        if (map["CART_LIST"] != null) {
          cartList = (map["CART_LIST"] as List<dynamic>)
              .map((item) => item.toString())
              .toList();
        } else {
          cartList = nullList;
        }if (map["FAVORITE_LIST"] != null) {
          pubFavoriteList = (map["FAVORITE_LIST"] as List<dynamic>)
              .map((item) => item.toString())
              .toList();
          print(pubFavoriteList);
          print("arihfkuryhfwiuhflwefoixioqwiw");
        } else {
          pubFavoriteList = nullList;
        }
      }
      notifyListeners();
    });
  }

  void fetchHomeCarouselImage() {
    carouselList.clear();
    db.collection("CAROUSELS").get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();

          carouselList.add(map["IMAGE"]);
        }
        print(carouselList.length);
        print("gfeireuoj");
        notifyListeners();
      }
    });
  }

  void fetchAdvertisementImage() {
    advertisementList.clear();
    db.collection("ADVERTISEMENTS").get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();

          advertisementList.add(map["IMAGE"]);
        }
        print(advertisementList.length);
        print("gfeireuoj");
        notifyListeners();
      }
    });
  }

  Future<void> addFavorite(
    String userId,
    String bookId,
    String from,
    String bookName,
    String authorName,
    String bookImage,
    String price,
    String offerPrice,
    String categoryId,

  ) async {
    HashMap<String, Object> map = HashMap();
    DateTime now = DateTime.now();
    String favId = now.millisecondsSinceEpoch.toString();
    String collectionName;

    try {
      if (from == "E-BOOKS") {
        collectionName = "E-BOOKS";
        map["TYPE"] = "E-BOOK";
      } else {
        collectionName = "BOOKS";
        map["OFFER_PRICE"] = offerPrice;
        map["PRICE"] = price;
        map["TYPE"] = "BOOK";
      }
      map["CUSTOMER_ID"] = userId;
      map["BOOK_ID"] = bookId;
      map["BOOK_NAME"] = bookName;
      map["AUTHOR_NAME"] = authorName;
      map["BOOK_IMAGE"] = bookImage;
      map["CATEGORY_ID"] = categoryId;
      map["DATE"] = now;
      db.collection("FAVORITES").doc(favId).set(map, SetOptions(merge: true));
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection(collectionName).doc(bookId);
      await documentReference.update({
        'FAVORITE_LIST': FieldValue.arrayUnion([userId])
      });

      if (from == "E-BOOKS") {
        fetchHomeEBook("FUNCTION",categoryId);
      } else if (from == "FAV-SCREEN") {
        fetchFavorite(userId);
      } else {
        fetchHomeStoreBook("FUNCTION",categoryId);
      }
    } catch (e) {
      print('Error removing value from array field: $e');
    }
  }

  Future<void> unLike(String userId, String bookId, String from,String categoryId) async {
    String collectionName;
    if (from == "E-BOOKS") {
      collectionName = "E-BOOKS";
    } else {
      collectionName = "BOOKS";
    }
    try {
      try {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection("FAVORITES")
                .where("BOOK_ID", isEqualTo: bookId)
                .where("CUSTOMER_ID", isEqualTo: userId)
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs) {
            FirebaseFirestore.instance
                .collection("FAVORITES")
                .doc(doc.id)
                .delete();
          }
        }
      } catch (e) {
        print("Error deleting favorite: $e");
      }
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection(collectionName).doc(bookId);
      await documentReference.update({
        'FAVORITE_LIST': FieldValue.arrayRemove([userId]),
      });

      if (from == "E-BOOKS") {
        fetchHomeEBook("FUNCTION",categoryId);
      } else if (from == "FAV-SCREEN") {
        fetchFavorite(userId);
        fetchHomeStoreBook("FUNCTION",categoryId);
        fetchHomeEBook("FUNCTION",categoryId);
      } else {
        fetchHomeStoreBook("FUNCTION",categoryId);
      }
    } catch (e) {
      print('Error removing value from array field: $e');
    }
  }

  Future<void> saveToLibrary(
    String userID,
    String bookId,
    String bookName,
    String authorName,
    String bookImage,
    String description,
    String category,
    String categoryId,
  ) async {
    DateTime now = DateTime.now();

    String docId = now.millisecondsSinceEpoch.toString();
    HashMap<String, Object> map = HashMap();
    map["CUSTOMER_ID"] = userID;
    map["BOOK_ID"] = bookId;
    map["DATE"] = now;
    map["BOOK_NAME"] = bookName;
    map["AUTHOR_NAME"] = authorName;
    map["BOOK_IMAGE"] = bookImage;
    map["DESCRIPTION"] = description;
    map["CATEGORY"] = category;
    map["CATEGORY_ID"] = categoryId;
    map["STATUS"] = "ADDED";
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("E-BOOKS").doc(bookId);
      await documentReference.update({
        'LIBRARY_LIST': FieldValue.arrayUnion([userId])
      });
      fetchHomeEBook("SPLASH","");
      libraryBool = true;
    } catch (e) {
      print(e);
    }
    db.collection("LIBRARY").doc(docId).set(map, SetOptions(merge: true));

    fetchSavedLibrary(userID);
  }

  void fetchSavedLibrary(String userId) {
    savedLibraryList.clear();
    db
        .collection("LIBRARY")
        .where("CUSTOMER_ID", isEqualTo: userId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          savedLibraryList.add(SaveToLibraryModel(
              element.id,
              map["CUSTOMER_ID"],
              map["BOOK_ID"],
              map["AUTHOR_NAME"],
              map["BOOK_IMAGE"],
              map["STATUS"]??"",
              map["DESCRIPTION"]??"",
              map["BOOK_NAME"]??"",
              map["CATEGORY"]??"",
              map["CATEGORY_ID"]??"",
          ));
        }
        print(savedLibraryList.length);
        notifyListeners();
      } else {
        savedLibraryList.clear();
        notifyListeners();
      }
    });
  }


  Future<void> removeSavedLibrary(
      String userId, String bookId, String saveLibraryDocId) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("E-BOOKS").doc(bookId);
      await documentReference.update({
        'LIBRARY_LIST': FieldValue.arrayRemove([userId]),
      });

      db.collection("LIBRARY").doc(saveLibraryDocId).delete();

      fetchSavedLibrary(userId);
    } catch (e) {
      print(e);
    }
  }

  void fetchFavorite(String userDocId) {
    print(userDocId);
    print("shfwukhilwehilwejedjk");
    allFavoriteList.clear();

    db
        .collection("FAVORITES")
        .where("CUSTOMER_ID", isEqualTo: userDocId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (value.docs.isNotEmpty) {
          print("shfwukhilwehilwejedjk");

          allFavoriteList.clear();
          notifyListeners();
        }

        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          allFavoriteList.add(FavoriteModel(
            element.id,
            map["AUTHOR_NAME"],
            map["BOOK_NAME"],
            map["BOOK_IMAGE"],
            map["BOOK_ID"],
            map["OFFER_PRICE"] ?? "",
            map["PRICE"] ?? "",
            map["TYPE"] ?? "",
            map["CATEGORY_ID"] ?? "",
          ));
        }
        notifyListeners();
      } else {
        allFavoriteList.clear();
        notifyListeners();
      }
    });
  }

  Future<void> addToCart(
    String userDocId,
    String bookId,
    String bookName,
    String authorName,
    String bookImage,
    String description,
    String price,
    String offerPrice,
    String category,
    String categoryId,
  ) async {
    HashMap<String, Object> map = HashMap();
    DateTime now = DateTime.now();
    String cartId = now.millisecondsSinceEpoch.toString();

    try {
      DocumentReference documentReference = FirebaseFirestore.instance.collection("BOOKS").doc(bookId);
      await documentReference.update({'CART_LIST': FieldValue.arrayUnion([userDocId]),});
      map["CUSTOMER_ID"] = userDocId;
      map["BOOK_ID"] = bookId;
      map["DATE"] = now;
      map["DATE_MILLI"] = now.millisecondsSinceEpoch.toString();
      map["BOOK_NAME"] = bookName;
      map["AUTHOR_NAME"] = authorName;
      map["BOOK_IMAGE"] = bookImage;
      map["DESCRIPTION"] = description;
      map["PRICE"] = price;
      map["OFFER_PRICE"] = offerPrice;
      map["CATEGORY"] = category;
      map["CATEGORY_ID"] = categoryId;
      db.collection("CARTS").doc(cartId).set(map, SetOptions(merge: true));
      cartBool = true;


      fetchHomeStoreBook("SPLASH","");
      fetchAddToCart(userDocId);
    } catch (e) {
      print(e);
    }
  }

List<CartModelClass>selectCardItemList=[];
  void fetchAddToCart(String userId) {
    allCartList.clear();
    db
        .collection("CARTS")
        .where("CUSTOMER_ID", isEqualTo: userId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          allCartList.add(CartModelClass(
              element.id,
              map["CUSTOMER_ID"],
              map["BOOK_ID"],
              map["AUTHOR_NAME"],
              map["BOOK_IMAGE"],
              map["DESCRIPTION"],
              map["BOOK_NAME"],
              map["OFFER_PRICE"],
              map["CATEGORY"]??"",
              map["CATEGORY_ID"]??"",
              map["DATE_MILLI"].toString(),
            map["PRICE"],
            false
          ));
          allCartList.sort((b, a) => a.dateMilli.compareTo(b.dateMilli));


        }
        notifyListeners();
      } else {
        allCartList.clear();
        notifyListeners();
      }
    });
  }

  Future<void> removeCart(
      String userId, String bookId, String cartDocId) async {
    try {
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("BOOKS").doc(bookId);
      await documentReference.update({
        'CART_LIST': FieldValue.arrayRemove([userId]),
      });

      db.collection("CARTS").doc(cartDocId).delete();

      fetchAddToCart(userId);
    } catch (e) {
      print(e);
    }
  }


  Future<void> upiIntent(
      BuildContext context1,
      String amount,
      String name,
      String phone,
      String customId,
      String app,
      String appver,
      String orderCount,
      StoreBookModel storeBookList) async {
    showDialog(
        context: context1,
        builder: (contextLength2) {
          return const Align(
              alignment: Alignment.center,
              child: Text("Please wait\nLoading..."));
        });

    String txnID = transactionID.text;
    UpiModel upiModel =
        await getUpiUri(app, amount.replaceAll(',', ''), txnID);
    var arguments = {
      'Uri': upiModel.uri,
    };

    if (Platform.isAndroid) {
      String status = await platformChanel.invokeMethod(app, arguments);
      status = "Success";

      if (status != 'NoApp') {
        if (status != 'FAILED') {
          print("code isss here");
          upDatePayment("SUCCESS", status, context1, txnID, app, upiModel.upiId, appver, name, phone, customId,orderCount, amount,storeBookList);
          // callNextReplacement(PaymentSuccessScreen(userId: customId, storeBookList: storeBookList, userName: name, userPhone: phone, orderCount: orderCount, amount: amount, paymentStatus: 'FAILED',), context1);
          callNextReplacement(PaymentSuccessScreen(userId: customId, storeBookList: storeBookList, userName: name, userPhone: phone, orderCount: orderCount, amount: amount, paymentStatus: 'SUCCESS',), context1);

        } else {
          print("code isss here22222");
          upDatePayment("SUCCESS", status, context1, txnID, app, upiModel.upiId, appver, name, phone, customId,orderCount, amount,storeBookList);
          callNextReplacement(PaymentSuccessScreen(
            userId: customId,
            storeBookList: storeBookList,
            userName: name,
            userPhone: phone, orderCount: orderCount, amount: amount, paymentStatus: 'SUCCESS',
          ), context1);
          // upDatePayment("FAILED", "no response", context1, txnID, app, upiModel.upiId, appver,name,phone,customId,orderCount,amount,storeBookList);
        }

      } else {
        String url = '';
        if (app == 'BHIM') {
          url =
              'https://play.google.com/store/apps/details?id=in.org.npci.upiapp&hl=en_IN&gl=US';
        } else if (app == 'GPay') {
          url =
              'https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user&hl=en_IN&gl=US';
        } else if (app == 'Paytm') {
          url =
              'https://play.google.com/store/apps/details?id=net.one97.paytm&hl=en_IN&gl=US';
        } else if (app == 'PhonePe') {
          url =
              'https://play.google.com/store/apps/details?id=com.phonepe.app&hl=en_IN&gl=US';
        }
        launchURL(url);
      }
    }


  }

  upDatePayment(
      String status,
      String response,
      BuildContext context,
      String orderID,
      String app,
      String upiIdP,
      String appver,
      String customerName,
      String customerPhone,
      String customerId,
      String orderCount,
      String amount,
      StoreBookModel storeBookList) async {
    DateTime now = DateTime.now();
    String key = now.millisecondsSinceEpoch.toString();
    HashMap<String, Object> map = HashMap();
    HashMap<String, Object> itemMap = HashMap();


    /// items
    itemMap["BOOK_ID"] = storeBookList.bookId;
    itemMap["BOOK_PHOTO"] = storeBookList.bookPhoto;
    itemMap["AUTHOR"] = storeBookList.authorName;
    itemMap["ITEM_NAME"] = storeBookList.bookName;
    itemMap["ITEM_PRICE"] = storeBookList.bookOfferPrice;
    itemMap["ITEM_CATEGORY"] = storeBookList.bookCategory;
    itemMap["ITEM_CATEGORY_ID"] = storeBookList.bookCategoryId;
    itemMap["DATE"] = DateTime.now();
    itemMap["DATE_MILLI"] = now.millisecondsSinceEpoch.toString();
    itemMap["QUANTITY"] = 1;

    String? strDeviceID = "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }

    map["RESPONDS"] = response;
    map["CUSTOMER_NAME"] = customerName;
    map["CUSTOMER_ID"] = customerId;
    map["CUSTOMER_PHONE"] = customerPhone;
    map["ORDER_TIME_MILLI"] = now.millisecondsSinceEpoch.toString();
    map["ORDER_TIME"] = DateTime.now();
    map["ORDER_ID"] = orderID;
    map["APP_VERSION"] = appver;
    map["PAYMENT_APP"] = app;
    map["DEVICE_ID"] = strDeviceID!;
    map["STATE"] = orderStateController.text;
    map["DISTRICT"] = orderDistrictController.text;
    map["POST_OFFICE"] = orderPostOfficeController.text;
    map["PIN"] = orderPinCodeController.text;
    map["ADDRESS"] = orderAddressController.text;
    map["LOCATION"] = orderLocationController.text;
    map["ITEM_TOTAL_AMOUNT"]= amount;

    if (status == "SUCCESS") {
      map["PAYMENT_STATUS"] = "SUCCESS";
      map["ORDER_STATUS"] = "PLACED";
    } else {
      map["PAYMENT_STATUS"] = "FAILED";
      map["ORDER_STATUS"] = "FAILED";
    }

    if (Platform.isIOS) {
      map["PLATFORM"] = "IOS";
    }
    else if (Platform.isAndroid) {
      map["PLATFORM"] = "ANDROID";
    }
    else {
      map["PLATFORM"] = "NIL";
    }

    if(orderCount=="Single"){

      HashMap<String, Object> itemArrayMap = HashMap();
      List<HashMap<String, Object>> orderBookList = [];
      orderBookList.add(itemMap);
      itemArrayMap["ORDER_ITEMS"] = orderBookList;
      HashMap<String, Object> mergedArrayMap = HashMap.from(map);
      mergedArrayMap.addAll(itemArrayMap);
      db.collection("MONITOR").doc(orderID).set(mergedArrayMap);
      db.collection("MONITOR").doc(orderID).collection("ITEMS").doc(storeBookList.bookId).set(itemMap);
      if (status == "SUCCESS") {
        HashMap<String, Object> mergedMap = HashMap.from(map);
        mergedMap.addAll(itemMap);

        db.collection('ORDERS').doc(orderID).set(mergedArrayMap);
         db.collection("ORDERS").doc(orderID).collection("ITEMS").doc(key).set(itemMap);
         db.collection('ATTEMPT').doc(orderID).set({"ORDER_STATUS": "SUCCESS"}, SetOptions(merge: true));
        await  db.collection("SALES_REPORT").doc(key).set(mergedMap);
         db.collection('TOTAL').doc("TOTAL").set({"AMOUNT": FieldValue.increment(double.parse(storeBookList.bookOfferPrice)),"BOOK_COUNT": FieldValue.increment(1)}, SetOptions(merge: true));
      }
    }else{
      List<HashMap<String, Object>> orderBookList = [];

      for(var element in selectCardItemList){
        HashMap<String, Object> multiMap = HashMap();
        print("offer price  ${element.offerPrice}");
        /// Multi items
        multiMap["BOOK_ID"] = element.bookId;
        multiMap["ITEM_NAME"] = element.bookName;
        multiMap["BOOK_PHOTO"] = element.bookImage;
        multiMap["AUTHOR"] = element.authorName;
        multiMap["ITEM_PRICE"] = element.offerPrice;
        multiMap["ITEM_CATEGORY"] = element.category;
        multiMap["ITEM_CATEGORY_ID"] =  element.categoryId;
        multiMap["DATE"] = DateTime.now();
        multiMap["DATE_MILLI"] = now.millisecondsSinceEpoch.toString();
        multiMap["QUANTITY"] =1 ;
        orderBookList.add(multiMap);
        HashMap<String, Object> mergedMap = HashMap.from(map);

        mergedMap.addAll(multiMap);

          db.collection("MONITOR").doc(orderID).collection("ITEMS").doc(element.bookId).set(multiMap);

        String key = DateTime.now().millisecondsSinceEpoch.toString();
        if (status == "SUCCESS") {
           db.collection("SALES_REPORT").doc(key).set(mergedMap);
          await db.collection("ORDERS").doc(orderID).collection("ITEMS").doc(key).set(multiMap);
           db.collection('TOTAL').doc("TOTAL").set({"AMOUNT": FieldValue.increment(double.parse(element.offerPrice)),"BOOK_COUNT": FieldValue.increment(1)}, SetOptions(merge: true));
        }

      }
      HashMap<String, Object> itemArrayMap = HashMap();
      itemArrayMap["ORDER_ITEMS"] = orderBookList;
      HashMap<String, Object> mergedArrayMap = HashMap.from(map);
      mergedArrayMap.addAll(itemArrayMap);
      db.collection("MONITOR").doc(orderID).set(mergedArrayMap);
      if (status == "SUCCESS") {
        db.collection('ORDERS').doc(orderID).set(mergedArrayMap);
        db.collection('ATTEMPT').doc(orderID).set({"ORDER_STATUS": "SUCCESS"}, SetOptions(merge: true));
      }




    }


    getDonationDetailsForReceipt(orderID);
    fetchUserOrders();

    notifyListeners();
  }

  DateTime donationTime = DateTime.now();
  String donateTime = '';
  String donorStatus = '';
  String donorName = '';
  String donorNumber = '';
  String donorPlace = '';
  String donorID = '';
  String donorAmount = '';
  String donorApp = '';
  String? onOfButton = '';
  String donorReceiptPrinted = '';

  Uint8List? fileBytes;

  getDonationDetailsForReceipt(String paymentID) {
    print("AAAAAAAAAAAAAAAAAAAAAAA11" + paymentID);
    donationTime = DateTime.now();
    donorName = '';
    donorNumber = '';
    donorPlace = '';
    donorStatus = '';
    donorID = paymentID;
    db.collection("MONITOR").doc(paymentID).get().then((value) {
      if (value.exists) {
        donateTime = value.get("ORDER_TIME_MILLI").toString();
        donorName = value.get("CUSTOMER_NAME").toString();
        donorNumber = value.get("CUSTOMER_PHONE").toString();
        donorID = paymentID;
        donorStatus = value.get("PAYMENT_STATUS").toString();
        donorAmount = double.parse(value.get("ITEM_TOTAL_AMOUNT").toString()).toStringAsFixed(0);
        donorApp = value.get("PAYMENT_APP").toString();
        print("status payment $donationTime");
        notifyListeners();
      }
    });
    notifyListeners();
  }

  Future<UpiModel> getUpiUri(String app, String amount, String txnID) async {
    double amt = 0;
    try {
      amt = double.parse(amount);
    } catch (e) {}

    if (amt < 2000) {
      app = app + '2000';
    }

    var snapshot = await mRoot
        .child("0")
        .child("AccountDetials")
        .child('PaymentGateway')
        .child(app)
        .once();
    Map<dynamic, dynamic> map = snapshot.snapshot.value as Map;
    String upiId = map['UpiId'];
    String upiName = map['UpiName'];
    String upiAdd = map['UpiAdd'];
    // UpiModel upiModel=UpiModel(upiId, 'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&m&purpose=00&tn=kx ${txnID}$upiAdd');
    UpiModel upiModel = UpiModel(upiId,
        'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&tr=$txnID&tn=MR $txnID$upiAdd');
    return upiModel;
  }

  void launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  Future<void> saveImageToGallery(Uint8List imagePath) async {
    try {
      final result = await ImageGallerySaver.saveImage(imagePath,
          quality: 100, name: 'Grace Book');
    } on PlatformException catch (error) {}
  }

  Future<Uint8List?> captureScreenshot(GlobalKey previewContainer) async {
    // Find the widget to capture
    RenderRepaintBoundary boundary = previewContainer.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;
    // Capture the image of the widget
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    // Convert the image to bytes
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List? imageBytes = byteData?.buffer.asUint8List();

    return imageBytes;
  }

  bool attemptButton = false;

  notifyAttemptButton() {
    attemptButton = true;
    notifyListeners();
  }

  List<MyOrderModel> myOrdersList = [];

  fetchUserOrders() async {
    myOrdersList.clear();
    String? strDeviceID = "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }

    print('$strDeviceID CINSOJUCOSC');

    db.collection("ORDERS")
        .where("DEVICE_ID", isEqualTo: strDeviceID)
        .get()
        .then((value) async {
      if(value.docs.isNotEmpty){
        myOrdersList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          List<ItemModel> itemsList = []; // Move it here to avoid data corruption
          db.collection("ORDERS").doc(element.id).collection("ITEMS").get().then((itemValue) async {
            if(itemValue.docs.isNotEmpty){
              for(var element2 in itemValue.docs){
                Map<dynamic, dynamic> itemMap = element2.data();

                itemsList.add(ItemModel(
                  itemMap["BOOK_ID"] ?? "",
                  itemMap["ITEM_NAME"] ?? "",
                  itemMap ["BOOK_PHOTO"] ?? "",
                  itemMap ["AUTHOR"] ?? "",
                  itemMap["ITEM_PRICE"] ?? "",
                  itemMap["ITEM_CATEGORY_ID"] ?? "",
                  itemMap["ITEM_CATEGORY"] ?? "",
                  itemMap["QUANTITY"] ?? "",
                ));

                print("kkkkkkkkkkkkkkkk ${myOrdersList.length}");
                notifyListeners();

              }
            }
          });
          myOrdersList.add(MyOrderModel(
            map["ITEM_NAME"]??"",
            map["BOOK_PHOTO"]??"",
            map["AUTHOR"]??"",
            map["ORDER_STATUS"]??"",
            map["ORDER_TIME_MILLI"]??"",
            map["ORDER_STATUS_DISPATCHED_BY_DATE_MILLI"]??"",
            map["ORDER_STATUS_DELIVERED_BY_DATE_MILLI"]??"",
              itemsList
          ));

        }
        notifyListeners();

      }
      notifyListeners();
    });


  }












  List<SearchModel>searchBookList=[];
  String searchBookName="";

  Future<void> fetchSearchBookDetails() async {
    searchBookList.clear();
    // Fetch books
    var booksQuerySnapshot = await db.collection("BOOKS").get();
    if (booksQuerySnapshot.docs.isNotEmpty) {
      searchBookList.clear();
      for (var element in booksQuerySnapshot.docs) {
        Map<dynamic, dynamic> map1 = element.data();
        searchBookList.add(SearchModel(element.id, map1["NAME"] ?? "",map1["TYPE"] ?? "",));
      }
      notifyListeners();
    }

    // Fetch e-books
    var eBooksQuerySnapshot = await db.collection("E-BOOKS").get();
    if (eBooksQuerySnapshot.docs.isNotEmpty) {
      for (var element2 in eBooksQuerySnapshot.docs) {
        Map<dynamic, dynamic> map2 = element2.data();
        searchBookList.add(SearchModel(element2.id, map2["NAME"] ?? "",map2["TYPE"] ?? "",));
      }
      notifyListeners();
    }


    print("ssssssssssearchList "+searchBookList.length.toString());
  }
  Future<void> searchBookCategoryWise(String categoryId) async {
    userSearchBookList.clear();
    // Fetch books
    var booksQuerySnapshot = await db.collection("BOOKS").where("CATEGORY_ID",isEqualTo: categoryId).get();
    if (booksQuerySnapshot.docs.isNotEmpty) {
      userSearchBookList.clear();
      for (var element in booksQuerySnapshot.docs) {
        Map<dynamic, dynamic> bookMap = element.data();
        List<String>? favoriteList;
        List<String>? libraryList;
        if (bookMap["FAVORITE_LIST"] != null) {
          favoriteList = (bookMap["FAVORITE_LIST"] as List<dynamic>).map((item) => item.toString()).toList();
        }else {
          favoriteList = nullList;
        }
        if (bookMap["LIBRARY_LIST"] != null) {
          libraryList = (bookMap["LIBRARY_LIST"] as List<dynamic>)
              .map((item) => item.toString())
              .toList();
        } else {
          libraryList = nullList;
        }
        if (bookMap["CART_LIST"] != null) {
          cartList = (bookMap["CART_LIST"] as List<dynamic>)
              .map((item) => item.toString())
              .toList();
        } else {
          cartList = nullList;
        }
        userSearchBookList.add(StoreBookModel(
            element.id,
            bookMap["NAME"]??"",
            bookMap["BOOK_PHOTO"]??"",

            bookMap["AUTHOR"]??"",
            bookMap["PRICE"]??"",
            bookMap["TYPE"]??"",
            bookMap["OFFER_PRICE"]??"",
            bookMap["DESCRIPTION"]??"",
            bookMap["CATEGORY"] ?? "",
            bookMap["CATEGORY_ID"] ?? "",
            favoriteList!,
          [],
            libraryList,
          bookMap["E-BOOK_PHOTO"]??"",

        ));
      }
      notifyListeners();
    }

    // Fetch e-books
    var eBooksQuerySnapshot = await db.collection("E-BOOKS").where("CATEGORY_ID",isEqualTo: categoryId).get();
    if (eBooksQuerySnapshot.docs.isNotEmpty) {
      for (var element2 in eBooksQuerySnapshot.docs) {
        Map<dynamic, dynamic> ebookMap = element2.data();
        List<String>? favoriteList;
        List<String>? libraryList;
        List<String>? cartList;
        if (ebookMap["FAVORITE_LIST"] != null) {
          favoriteList = (ebookMap["FAVORITE_LIST"] as List<dynamic>).map((item) => item.toString()).toList();
        }else {
          favoriteList = nullList;
        }
        if (ebookMap["LIBRARY_LIST"] != null) {
          libraryList = (ebookMap["LIBRARY_LIST"] as List<dynamic>)
              .map((item) => item.toString())
              .toList();
        } else {
          libraryList = nullList;
        }
        if (ebookMap["CART_LIST"] != null) {
          cartList = (ebookMap["CART_LIST"] as List<dynamic>)
              .map((item) => item.toString())
              .toList();
        } else {
          cartList = nullList;
        }
        userSearchBookList.add(StoreBookModel(
          element2.id,
          ebookMap["NAME"]??"",
          ebookMap["BOOK_PHOTO"]??"",
          ebookMap["AUTHOR"]??"",
          ebookMap["PRICE"]??"",
          ebookMap["TYPE"]??"",
          ebookMap["OFFER_PRICE"]??"",
          ebookMap["DESCRIPTION"]??"",
          ebookMap["CATEGORY"] ?? "",
          ebookMap["CATEGORY_ID"] ?? "",
          favoriteList!,
          cartList,
          libraryList,
          ebookMap["E-BOOK_PHOTO"]??"",

        ));
      }
      notifyListeners();
    }


    print("ssssssssssearchList "+searchBookList.length.toString());
  }

  List<StoreBookModel> userSearchBookList = [];
  void fetchSearchBooks(String bookType,String itemId){
    userSearchBookList.clear();
    db.collection(bookType).doc(itemId).get().then((value) {
      userSearchBookList.clear();
      if(value.exists){
          Map<dynamic, dynamic> bookMap = value.data() as Map;
          List<String>? favoriteList;
          List<String>? libraryList;
          List<String>? cartList;
          if (bookMap["FAVORITE_LIST"] != null) {
            favoriteList = (bookMap["FAVORITE_LIST"] as List<dynamic>).map((item) => item.toString()).toList();
          }
          if (bookMap["LIBRARY_LIST"] != null) {
            libraryList = (bookMap["LIBRARY_LIST"] as List<dynamic>)
                .map((item) => item.toString())
                .toList();
          } else {
            libraryList = nullList;
          }  if (bookMap["CART_LIST"] != null) {
            cartList = (bookMap["CART_LIST"] as List<dynamic>)
                .map((item) => item.toString())
                .toList();
          } else {
            cartList = nullList;
          }
          userSearchBookList.add(StoreBookModel(
              value.id,
              bookMap["NAME"]??"",
              bookMap["BOOK_PHOTO"]??"",
              bookMap["AUTHOR"]??"",
              bookMap["PRICE"]??"",
              bookMap["TYPE"]??"",
              bookMap["OFFER_PRICE"]??"",
              bookMap["DESCRIPTION"]??"",
              bookMap["CATEGORY"] ?? "",
              bookMap["CATEGORY_ID"] ?? "",
              favoriteList!,
            cartList,
              libraryList,
            bookMap["E-BOOK_PHOTO"]??"",

          ));

          print("hdddddddddddddddddd "+userSearchBookList.length.toString());

          notifyListeners();
      }else{
        userSearchBookList.clear();
      }

notifyListeners();

    });



  }






}
