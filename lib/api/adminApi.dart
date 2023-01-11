import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

import '../models/trip.dart';

class AdminApi {
  String server = "http://localhost:8083/";
  AdminApi._();
  static AdminApi adminApi = AdminApi._();
  signIn(Map<String, String> map) async {
    final res = await http.post(
        Uri.parse("${server}rest/admin-controller/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(map));
    
    auth = res.body;
    return res.body;
  }

  sendMessage(Map<String, dynamic> map) async {
    final res = await http.post(
        Uri.parse('${server}rest/public-user-controller/contact'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        },
        body: jsonEncode(map));
  }

  updateUser(Map<String, dynamic> map) async {
    final res = await http.put(
        Uri.parse("${server}rest/public-user-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        },
        body: jsonEncode(map));
    return res.body;
  }

  deleteUser(Map<String, String> map) async {
    final res = await http.delete(
        Uri.parse("${server}rest/public-user-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        },
        body: jsonEncode(map));
  }

  deleteTrip(Map<String, dynamic> map) async {
    final res = await http.delete(
        Uri.parse("${server}rest/public-trip-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        },
        body: jsonEncode(map));
    return res.body;
  }

  deleteCompany(Map<String, dynamic> map) async {
    final res = await http.delete(Uri.parse("${server}rest/company-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        },
        body: jsonEncode(map));
    return res.body;
  }

  String auth =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzOGYyOTRlZTEzM2I4MWM1YjUyYWJhMiIsImlhdCI6MTY3MzI0NjUyNiwiZXhwIjoxNjczMjUwMTI2fQ.OB9dYF4Z1_hvo2Of3wtiGJ7-mvjRmvSNpFYa9wCxGpo';
  getAllUsersInfo() async {
    final res = await http.get(
        Uri.parse('${server}rest/public-user-controller'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        });
    log(res.body);
    return res.body;
  }

  getAllCompanies() async {
    final res = await http.get(
        Uri.parse('${server}rest/company-controller/getAll'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        });
    return res.body;
  }

  approveTrip(Trip trip) async {
    final res = await http.post(
        Uri.parse("${server}rest/admin-controller/approve"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        },
        body: jsonEncode(
            <String, dynamic>{'id': trip.id, 'approved': trip.approved}));
    
    return res.body;
  }

  lockTrip(Trip t) async {
    final res = await http.post(
        Uri.parse("${server}rest/company-controller/lockTrip"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        },
        body: jsonEncode(
            <String, dynamic>{'id': t.id, 'available': t.available}));
    return res.body;
  }

  getAllTrips() async {
    final res = await http.get(
      Uri.parse("${server}rest/admin-controller/getAllTrips"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth
      },
    );
    return res.body;
  }

  getUserInfo(Map<String, String> map) async {
    final res = await http.post(
        Uri.parse('${server}rest/public-user-controller/get-info'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': auth
        },
        body: jsonEncode(map));
    return res.body;
  }
}
