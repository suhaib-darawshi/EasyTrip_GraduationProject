import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo/api/api_helper.dart';
import 'package:demo/date_repo/enum.dart';
import 'package:demo/models/companyModel.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/trip.dart';

class CompanyProvider extends ChangeNotifier {
  GlobalKey<FormState> signUpKey = GlobalKey();
  GlobalKey<FormState> addTripKey = GlobalKey();
  GlobalKey<FormState> addTripKey2 = GlobalKey();
  GlobalKey<FormState> signinKey = GlobalKey();
  GlobalKey<FormState> confirmPageKey = GlobalKey();

  TextEditingController CompanyNameController = TextEditingController();
  TextEditingController CompanyAddressController = TextEditingController();
  TextEditingController CompanyEmailController = TextEditingController();
  TextEditingController CompanyPhoneController = TextEditingController();
  TextEditingController CompanyPasswordController = TextEditingController();
  TextEditingController tripNameContrller = TextEditingController();
  TextEditingController tripLocationController = TextEditingController();
  TextEditingController tripDescriptionController = TextEditingController();
  TextEditingController tripPriceController = TextEditingController();
  TextEditingController tripHotelController = TextEditingController();
  TextEditingController tripFlightController = TextEditingController();
  TextEditingController tripLimitController = TextEditingController();
  TextEditingController authKeyController = TextEditingController();

  DateRangePickerController dateController = DateRangePickerController();
  List<String> hotelRanks = ['3-Stars', '5-Stars', '7-Stars'];
  String? hotelRank;
  int duration = 0;
  bool isDark = false;
  final List<Locale> languages = [const Locale('en'), const Locale('ar')];
  int local = 0;
  late Trip currentTrip;
  late Company user;
  List<Trip> companyTrips = [];
  File? imageFile;
  DateTime? begin;
  bool foodReserved = false;
  bool carRented = false;
  late int confirmKey;
  CompanyProvider() {
    initCategories = defaultCategories;
    log(initCategories.toString());
  }
  List<Trip> activeTrips = [];
  List<Trip> nonActiveTrips = [];
  updateTrips() {
    activeTrips = companyTrips.where((element) => element.available).toList();
    nonActiveTrips =
        companyTrips.where((element) => !element.available).toList();
    notifyListeners();
  }

  Map<Category, bool> defaultCategories = {
    Category.ancient: false,
    Category.beach: false,
    Category.cheap: false,
    Category.desert: false,
    Category.developedCity: false,
    Category.expensive: false,
    Category.greenLand: false,
    Category.mountant: false,
    Category.religous: false,
    Category.scientific: false,
  };
  late Map<Category, bool> initCategories;
  foodCkeckBox() {
    foodReserved = !foodReserved;

    notifyListeners();
  }

  carCheckBox() {
    carRented = !carRented;
    notifyListeners();
  }

  incDuration() {
    duration++;
    notifyListeners();
  }

  decDuration() {
    if (duration > 0) {
      duration--;
      notifyListeners();
    }
  }

  ChangeHotelRank(value) {
    hotelRank = value;
    notifyListeners();
  }

  pickImageForCategory() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      // await upload(imageFile!);
    }
    // await getUserInformation();
    notifyListeners();
  }

  Locale getLocale() {
    return languages[local];
  }

  setLocale(int x) {
    local = x % languages.length;
    notifyListeners();
  }

  setLocaleFromButton() {
    local = (local + 1) % languages.length;
    notifyListeners();
  }

  setCurrentTrip(Trip t) async {
    currentTrip = t;
    notifyListeners();
  }

  String? verifValidation(String? key) {
    if (key == null || key.isEmpty) {
      return 'required field';
    }
    if (!isNumeric(key) || key.length != 6) {
      return 'should be a 6-digit Number';
    }
    if (key != confirmKey.toString()) {
      log(confirmKey.toString());
      return 'Invalid key';
    }
  }

  logOut() {}
  lockTrip() async {
    currentTrip.available = !currentTrip.available;

    final res = await API.apiHandler.lockTrip(currentTrip);
    log(res.toString());
    updateTrips();
    notifyListeners();
  }

  getSelectedCategories() {
    List<bool> list = [];
    initCategories.forEach((key, value) {
      list.add(value);
    });
    log(list.toString());
    return list;
  }

  setDarkMode() {
    isDark = !isDark;
    notifyListeners();
  }

  bool nextAddPage() {
    if (addTripKey.currentState!.validate() && imageFile != null) {
      return true;
    }
    return false;
  }

  toggleCategory(Category c) {
    initCategories[c] = !initCategories[c]!;
    notifyListeners();
  }

  bool toCategoryPage() {
    if (addTripKey2.currentState!.validate() && duration > 0 && begin != null) {
      initCategories = defaultCategories;
      return true;
    }
    return false;
  }

  String? passwordValidation(String password) {
    if (password == null || password.isEmpty) {
      return "Required field";
    } else if (password.length <= 6) {
      return 'Error, the password must be larger than 6 letters';
    }
  }

  String? requiredValidation(String content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
  }

  String? phoneValidation(String content) {
    if (content == null || content.isEmpty) {
      return "required Field";
    }
    if (!isNumeric(content)) {
      return "InCorrect phone number syntax";
    }
  }

  String? emailValidation(String email) {
    if (email == null || email.isEmpty) {
      return 'RequiredField';
    } else if (!isEmail(email)) {
      return 'Enter A valid Email';
    }
  }

  String? isANumber(String content) {
    if (!isNumeric(content)) {
      return 'should be a number';
    }
  }

  Trip getCurrentTrip() {
    return currentTrip;
  }

  signUp() async {
    if (signUpKey.currentState!.validate()) {
      final res = await API.apiHandler.companySignUp(<String, String>{
        'name': CompanyNameController.text,
        'address': CompanyAddressController.text,
        'rank': '0',
        'logo': '',
        'phone': CompanyPhoneController.text,
        'email': CompanyEmailController.text.toLowerCase(),
        'password': CompanyPasswordController.text,
      });
      if (res.toLowerCase() == ("Email already signed up".toLowerCase())) {
        return false;
      }
      confirmKey = int.parse(res);
      return true;
    }
  }

  createAccount() async {
    if (confirmPageKey.currentState!.validate()) {
      await API.apiHandler.createAccountCompany(<String, String>{
        'name': CompanyNameController.text,
        'address': CompanyAddressController.text,
        'rank': '0',
        'phone': CompanyPhoneController.text,
        'email': CompanyEmailController.text.toLowerCase(),
        'password': CompanyPasswordController.text,
      });
      await getInfo();
      return true;
    }
  }

  addTrip() async {
    // if (addTripKey.currentState!.validate()) {}
    log(user.toString());
    if (addTripKey2.currentState!.validate()) {
      Map<String, dynamic> map = {
        'name': tripNameContrller.text,
        'location': tripLocationController.text,
        'description': tripDescriptionController.text,
        'company': user.toMap(),
        'hotel': tripHotelController.text.isEmpty
            ? 'not provided'
            : tripHotelController.text,
        'hotelRank': tripHotelController.text.isEmpty ? '' : hotelRank ?? '',
        'flight': tripFlightController.text,
        'begin': begin.toString(),
        'BookLimit': tripLimitController.text,
        'duration': duration.toString(),
        'price': tripPriceController.text,
        'categories': getSelectedCategories(),
        'carProvided': carRented.toString(),
        'foodDeserved': foodReserved.toString(),
        'end': begin!.add(Duration(days: duration)).toString(),
        'url': ''
      };
      final res = await API.apiHandler.addTrip(imageFile!, map);
      
    }
  }

  signIn() async {
    if (signinKey.currentState!.validate()) {
      log("message");
      final res = await API.apiHandler.SignInCompany(
          CompanyEmailController.text.toLowerCase(),
          CompanyPasswordController.text);
      if (res == 'ACCESSED') {
        await getInfo();
      }
      return res;
    }
  }

  getInfo() async {
    final String resp = await API.apiHandler
        .getInfoCompany(CompanyEmailController.text.toLowerCase());
    user = Company.fromMap(jsonDecode(resp));
    await getRelatedTrips();
  }

  getRelatedTrips() async {
    final tr = await API.apiHandler.getCompanyTrips(user.id!);

    List maps = jsonDecode(tr);

    companyTrips = maps.map((e) => Trip.fromMap(e)).toList();
    updateTrips();
    notifyListeners();
  }

  fillControllers() {
    CompanyNameController.text = user.name;
    CompanyAddressController.text = user.address;
    CompanyPasswordController.text = user.password!;
    CompanyPhoneController.text = user.phone;
    CompanyEmailController.text = user.email;
  }

  updateInfo() async {
    String res = await API.apiHandler.companyUpdateInfo(<String, String>{
      "id": user.id!,
      "address": CompanyAddressController.text,
      "name": CompanyNameController.text,
      'password': CompanyPasswordController.text,
      'phone': CompanyPhoneController.text,
      'email': CompanyEmailController.text
    });
    await getInfo();
    return res;
  }

  File? logoFile;
  pickLogo() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      logoFile = File(pickedFile.path);
      await uploadLogo();
      await getInfo();
    }
  }

  uploadLogo() async {
    await API.apiHandler.uploadLogo(logoFile!, user.id!);
  }
}
