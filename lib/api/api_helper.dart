import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo/models/companyModel.dart';
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

  upload(File file) async {}

  addTrip(File file, Map<String, String> map) async {
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    // get file length

    var length = await file.length();
    var uri =
        Uri.parse("http://10.0.2.2:8083/rest/company-controller/createTrip");
    var req = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: 'basename(file.path)');
    req.files.add(multipartFile);
    req.fields.addAll(map);

    var resp = await req.send();
    return resp.stream.bytesToString();
  }
}
