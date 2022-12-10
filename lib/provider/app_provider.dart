import 'dart:convert';
import 'dart:developer';

import 'package:demo/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:string_validator/string_validator.dart';

import '../models/user.dart';

class AppProvider extends ChangeNotifier {
  String server = "http://10.0.2.2:8083/";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<Trip> defaultTrips = [];
  List<Trip> advancedTrip = [];
  late Trip currentTrip;
  late User user;

  int homeScreenIndex = 0;
  setCurrentTrip(Trip t) {
    currentTrip = t;
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
  getCurrentTrip() {
    return currentTrip;
  }

  likeTrip(Trip t) async {
    if (user.liked_trips!.contains(t.id)) {
      
      currentTrip.isLiked = false;
      user.liked_trips!.remove(t.id);
      final res = await http.put(
          Uri.parse("${server}rest/public-user-controller"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "id": user.id!,
            "first_name": user.first_name!,
            "last_name": user.last_name!,
            "email": user.email!,
            "password": user.password!,
            "phoneNumber": user.phoneNumber!,
            "liked_trips": user.liked_trips!
          }));
      final res2 = await http.put(
          Uri.parse("${server}rest/public-trip-controller/like-trip"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "userid": user.id!,
            "tripid": t.id,
            "method":"dislike"
          }));
    } else {
      log("dsa");
      user.liked_trips!.add(t.id);
      currentTrip.isLiked = true;
      final res = await http.put(
          Uri.parse("${server}rest/public-user-controller"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "id": user.id!,
            "first_name": user.first_name!,
            "last_name": user.last_name!,
            "email": user.email!,
            "password": user.password!,
            "phoneNumber": user.phoneNumber!,
            "liked_trips": user.liked_trips!
          }));
          final res2 = await http.put(
          Uri.parse("${server}rest/public-trip-controller/like-trip"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "userid": user.id!,
            "tripid": t.id,
            "method":"like"
          }));
    }
    setCurrentTrip(t);
    await getTrips();
    notifyListeners();
  }

  AppProvider() {
    user = User.fromMap({
      'first_name': 'name',
      'email': 'email',
    });
  }
  updateBarIndex(int x) {
    homeScreenIndex = x;
    notifyListeners();
  }

  int getBarIndex() {
    return homeScreenIndex;
  }

  updateInfo() async {
    final res = await http.put(
        Uri.parse("${server}rest/public-user-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": user.id!,
          "first_name": firstnameController.text,
          "last_name": lastnameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "phoneNumber": phoneNumberController.text
        }));
    getUserInformation();
    log(user.toString());
  }

  getUserInformation() async {
    final res = await http.post(Uri.parse('${server}rest/public-user-controller/get-info'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': emailController.text}));

    user = User.fromMap(jsonDecode(res.body));
    log(user.toString());
    firstnameController.text = user.first_name!;
    lastnameController.text = user.last_name!;
    emailController.text = user.email!;
    phoneNumberController.text = user.phoneNumber!;
    passwordController.text = user.password!;
  }

  clearTextFields() {
    emailController.clear();
    firstnameController.clear();
    lastnameController.clear();
    passwordController.clear();
    phoneNumberController.clear();
  }

  logIn() async {
    String em = emailController.text;
    String pass = passwordController.text;
    final res = await http.post(Uri.parse("${server}rest/public-user-controller/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': em, 'password': pass}));
    
    if (res.body == "ACCESSED") {
      await getUserInformation();
      await getTrips();
    }
    return res.body;
  }

  signUp() async {
    final res = await http.post(
        Uri.parse("${server}rest/public-user-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "first_name": firstnameController.text,
          "last_name": lastnameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "phoneNumber": phoneNumberController.text
        }));
    log(res.body);
  }

  getTrips() async {
    final res =
        await http.get(Uri.parse("${server}rest/public-trip-controller"));
    List dummy = jsonDecode(res.body);
    defaultTrips = dummy.map((e) => Trip.fromMap(e)).toList();
    for (var element in defaultTrips) {
      element.isLiked = user.liked_trips!.contains(element.id);
    }
    advancedTrip = defaultTrips;

    notifyListeners();
  }
}
