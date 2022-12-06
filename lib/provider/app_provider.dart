import 'dart:convert';
import 'dart:developer';

import 'package:demo/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AppProvider extends ChangeNotifier {
  String server = "http://10.0.2.2:8083/";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<Trip> defaultTrips = [];
  List<Trip> advancedTrip = [];
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
    final res = await http.post(Uri.parse("${server}rest/auth-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': em, 'password': pass}));
    await getTrips();
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
    advancedTrip = defaultTrips;
    notifyListeners();
  }
}
