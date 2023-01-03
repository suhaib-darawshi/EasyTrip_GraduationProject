import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo/models/companyModel.dart';
import 'package:demo/models/trip.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class API {
  API._();
  static API apiHandler = API._();
  String server = "http://10.0.2.2:8083/";
  SignInCompany(String email, String password) async {
    final res = await http.post(
        Uri.parse('${server}rest/company-controller/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({'email': email, 'password': password}));

    return res.body;
  }
  createUser(Map<String,String>map)async{
    final res = await http.post(
        Uri.parse("${server}rest/public-user-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(map));
    log(res.body.toString());
    return res.body;
  }
  signUpCompany(Company company) async {
    Map<String, dynamic> map = company.toMap();
    map.remove('id');
    map.remove('logo');
    map.remove('rank');
    final res = await http.post(Uri.parse("${server}rest/company-controller"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(map));
  }

  getInfoCompany(String email) async {
    final res = await http.post(
        Uri.parse("${server}rest/company-controller/getCompanyInfo"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({'email': email}));

    return res.body;
  }

  getCompanyTrips(String id) async {
    final res = await http.post(
        Uri.parse("${server}rest/company-controller/getSpecific"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({'id': id}));

    return res.body;
  }

  upload(File file) async {
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    // get file length

    var length = await file.length();
    var uri = Uri.parse(
        "http://10.0.2.2:8083/rest/company-controller/uploadTripImage");
    var req = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: 'basename(file.path)');
    req.files.add(multipartFile);

    var resp = await req.send();
    return resp.stream.bytesToString();
  }

  addTrip(File file, Map<String, dynamic> map) async {
    final String url = await upload(file);
    map['url'] = url;
    final res = await http.post(
        Uri.parse("http://10.0.2.2:8083/rest/company-controller/createTrip"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(map));
    log(res.body.toString());
    return res.body;
  }

  lockTrip(Trip t) async {
    final res = await http.post(
        Uri.parse("http://10.0.2.2:8083/rest/company-controller/lockTrip"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
            <String, dynamic>{'id': t.id, 'available': t.available}));
    return res.body;
  }

  UserSignUp(Map<String, String> map) async {
    final res = await http.post(
        Uri.parse("${server}rest/public-user-controller/signupAuth"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(map));
    log(res.body.toString());
    return res.body;
  }
}
