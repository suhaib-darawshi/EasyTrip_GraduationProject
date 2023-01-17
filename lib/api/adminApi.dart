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
        Uri.parse('${server}rest/admin-controller/contact'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        },
        body: jsonEncode(map));
  }

  updateUser(Map<String, dynamic> map) async {
    final res = await http.put(
        Uri.parse("${server}rest/admin-controller/updateUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        },
        body: jsonEncode(map));
    return res.body;
  }

  deleteUser(Map<String, String> map) async {
    final res = await http.delete(
        Uri.parse("${server}rest/admin-controller/deleteUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        },
        body: jsonEncode(map));
  }

  deleteTrip(Map<String, dynamic> map) async {
    final res = await http.delete(
        Uri.parse("${server}rest/admin-controller/deleteTrip"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        },
        body: jsonEncode(map));
    return res.body;
  }

  deleteCompany(Map<String, dynamic> map) async {
    final res = await http.delete(Uri.parse("${server}rest/admin-controller/deleteCompany"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        },
        body: jsonEncode(map));
    return res.body;
  }

  String auth =
      '';
  getAllUsersInfo() async {
    final res = await http.get(
        Uri.parse('${server}rest/admin-controller/getUsers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        });
    log(res.body);
    return res.body;
  }

  getAllCompanies() async {
    final res = await http.get(
        Uri.parse('${server}rest/admin-controller/getAllCompanies'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        });
    return res.body;
  }

  approveTrip(Trip trip) async {
    final res = await http.post(
        Uri.parse("${server}rest/admin-controller/approve"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        },
        body: jsonEncode(
            <String, dynamic>{'id': trip.id, 'approved': trip.approved}));
    
    return res.body;
  }

  lockTrip(Trip t) async {
    final res = await http.post(
        Uri.parse("${server}rest/admin-controller/lockTrip"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
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
        'authorization': auth
      },
    );
    return res.body;
  }

  getUserInfo(Map<String, String> map) async {
    final res = await http.post(
        Uri.parse('${server}rest/admin-controller/get-info'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': auth
        },
        body: jsonEncode(map));
    return res.body;
  }
}
