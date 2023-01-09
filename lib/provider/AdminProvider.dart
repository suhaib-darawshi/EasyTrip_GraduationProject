import 'dart:convert';
import 'dart:developer';

import 'package:demo/api/adminApi.dart';
import 'package:demo/api/api_helper.dart';
import 'package:demo/models/companyModel.dart';
import 'package:demo/models/trip.dart';
import 'package:demo/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:string_validator/string_validator.dart';

class AdminProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signinKey = GlobalKey();
  int rate = 0;
  List<User> users = [];
  bool isLogged = false;
  bool isDark = false;
  int homePageIndex = 0;
  late User user;
  final List<Locale> languages = [const Locale('en'), const Locale('ar')];
  int local = 0;
  List<String> homePages = ['Trips', 'Users', 'Companies', 'Statistics'];
  List<Trip> trips = [];
  List<Company> companies = [];
  getAllUsers() async {
    final res = await AdminApi.adminApi.getAllUsersInfo();
    List list = jsonDecode(res);
    users = list.map((e) => User.fromMap(e)).toList();
    log(users.length.toString());
    notifyListeners();
  }

  getAllCompanies() async {
    final res = await AdminApi.adminApi.getAllCompanies();
    log(res);
    List list = jsonDecode(res);

    companies = list.map((e) => Company.fromMap(e)).toList();
    notifyListeners();
  }

  not() {
    notifyListeners();
  }

  updateUser(User user) async {
    Map<String, dynamic> map = user.toMap();
    map.remove('liked_trips');
    map.remove('booked_trips');
    map.remove('chat');
    final res = await AdminApi.adminApi.updateUser(map);
    await getAllUsers();
    notifyListeners();
  }

  deleteUser(User user) async {
    final res =
        await AdminApi.adminApi.deleteUser(<String, String>{"id": user.id!});
    await getAllUsers();
  }

  deleteTrip(Trip trip) async {
    final res =
        await AdminApi.adminApi.deleteTrip(<String, String>{'id': trip.id});
    await getAllTrips();

  }
  deleteCompany(Company company)async{
    final res =
        await AdminApi.adminApi.deleteCompany(<String, String>{'id': company.id!});
    await getAllCompanies();
  }
  getAllTrips() async {
    final res = await AdminApi.adminApi.getAllTrips();
    List list = jsonDecode(res);
    trips = list.map((e) => Trip.fromMap(e)).toList();
    notifyListeners();
  }

  setHomePageIndex(int ind) {
    homePageIndex = ind;
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

  String? phoneValidation(String? content) {
    if (content == null || content.isEmpty) {
      return 'required';
    }
    if (!isNumeric(content)) {
      return "InCorrect phone number syntax";
    }
  }

  String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return 'RequiredField';
    } else if (!isEmail(email)) {
      return 'Enter A valid Email';
    }
  }

  Future<String> login() async {
    if (signinKey.currentState!.validate()) {
      String res = await AdminApi.adminApi.signIn(<String, String>{
        'email': emailController.text,
        'password': passwordController.text
      });
      if (res.toUpperCase() == "ACCESSED".toUpperCase()) {
        await getUserInformation();
        await getAllUsers();
        await getAllTrips();
        await getAllCompanies();
      }
      return res;
    }
    return '';
  }

  getUserInformation() async {
    final res = await AdminApi.adminApi
        .getUserInfo(<String, String>{'email': emailController.text});
    user = User.fromMap(jsonDecode(res));
  }
  // String? verifValidation(String? key) {
  //   if (key == null || key.isEmpty) {
  //     return 'required field';
  //   }
  //   if (!isNumeric(key) || key.length != 6) {
  //     return 'should be a 6-digit Number';
  //   }
  //   if (key != confirmKey.toString()) {
  //     return 'Invalid key';
  //   }
  // }

}
