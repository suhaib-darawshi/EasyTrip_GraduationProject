import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

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
    return res.body;
  }

  updateUser(Map<String, dynamic> map) async {
    final res =
        await http.put(Uri.parse("${server}rest/public-user-controller"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(map));
    return res.body;
  }

  deleteUser(Map<String, String> map) async {
    final res =
        await http.delete(Uri.parse("${server}rest/public-user-controller"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(map));
  }

  deleteTrip(Map<String, dynamic> map) async {
    final res =
        await http.delete(Uri.parse("${server}rest/public-trip-controller"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(map));
    return res.body;
  }

  deleteCompany(Map<String, dynamic> map) async {
    final res = await http.delete(Uri.parse("${server}rest/company-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(map));
    return res.body;
  }

  getAllUsersInfo() async {
    final res = await http.get(
        Uri.parse('${server}rest/public-user-controller'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    return res.body;
  }

  getAllCompanies() async {
    final res = await http.get(
        Uri.parse('${server}rest/company-controller/getAll'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    return res.body;
  }

  getAllTrips() async {
    final res =
        await http.get(Uri.parse("${server}rest/public-trip-controller"));
    return res.body;
  }

  getUserInfo(Map<String, String> map) async {
    final res = await http.post(
        Uri.parse('${server}rest/public-user-controller/get-info'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(map));
    return res.body;
  }
}
