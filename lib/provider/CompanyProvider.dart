import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo/api/api_helper.dart';
import 'package:demo/models/companyModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

import '../models/trip.dart';

class CompanyProvider extends ChangeNotifier {
  GlobalKey<FormState> signUpKey = GlobalKey();
  GlobalKey<FormState> addTripKey = GlobalKey();
  GlobalKey<FormState> signinKey = GlobalKey();

  TextEditingController CompanyNameController = TextEditingController();
  TextEditingController CompanyAddressController = TextEditingController();
  TextEditingController CompanyEmailController = TextEditingController();
  TextEditingController CompanyPhoneController = TextEditingController();
  TextEditingController CompanyPasswordController = TextEditingController();
  TextEditingController tripNameContrller = TextEditingController();
  TextEditingController tripLocationController = TextEditingController();
  TextEditingController tripDescriptionController = TextEditingController();
  TextEditingController tripPriceController = TextEditingController();

  bool isDark = false;
  final List<Locale> languages = [const Locale('en'), const Locale('ar')];
  int local = 0;
  late Trip currentTrip;
  late Company user;
  List<Trip> companyTrips = [];
  File? imageFile;
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

  lockTrip()  {
    currentTrip.available = !currentTrip.available;
    notifyListeners();
  }

  setDarkMode() {
    isDark = !isDark;
    notifyListeners();
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

  Trip getCurrentTrip() {
    return currentTrip;
  }

  signUp() async {
    if (signUpKey.currentState!.validate()) {
      await API.apiHandler.signUpCompany(Company.fromMap({
        'name': CompanyNameController.text,
        'address': CompanyAddressController.text,
        'rank': '0',
        'logo': '',
        'phone': CompanyPhoneController.text,
        'email': CompanyEmailController.text.toLowerCase(),
        'password': CompanyPasswordController.text,
      }));
    }
  }

  addTrip() async {
    if (addTripKey.currentState!.validate()) {}
  }

  signIn() async {
    log("message");
    final res = await API.apiHandler.SignInCompany(
        CompanyEmailController.text.toLowerCase(),
        CompanyPasswordController.text);
    if (res == 'ACCESSED') {
      await getInfo();
    }
    return res;
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
    notifyListeners();
    log(companyTrips.length.toString());
  }
}
