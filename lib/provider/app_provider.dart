import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo/date_repo/database_handler.dart';
import 'package:demo/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

import '../models/user.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    user = User.fromMap({
      'id': "id",
      'first_name': "first_name",
      'last_name': "last_name",
      'email': "email",
      'password': "password",
      'phoneNumber': "phoneNumber",
      'role': "role",
      'liked_trips': ["liked_trips"],
      'image': "image",
    });
    getTrips();
  }
  String server = "http://10.0.2.2:8083/";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<Trip> defaultTrips = [];
  List<Trip> advancedTrip = [];
  List<Trip> likedTrips = [];
  List<Trip> history = [];
  late Trip currentTrip;
  late User user;
  bool isLogged = false;
  bool isDark = true;
  int homeScreenIndex = 0;
  setCurrentTrip(Trip t) async {
    await SQL.sql.insert(t, user.id!);
    currentTrip = t;
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

  likeTrip(Trip t) async {
    if (user.liked_trips!.contains(t.id)) {
      currentTrip.isLiked = false;
      currentTrip.liked_count--;
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
            "method": "dislike"
          }));
    } else {
      log("dsa");
      user.liked_trips!.add(t.id);
      currentTrip.isLiked = true;
      currentTrip.liked_count++;
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
            "method": "like"
          }));
    }

    setCurrentTrip(t);
    await getTrips();
    notifyListeners();
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
          "email": emailController.text.toLowerCase(),
          "password": passwordController.text,
          "phoneNumber": phoneNumberController.text
        }));
    getUserInformation();
    log(user.toString());
  }

  getLikedTrips() {
    likedTrips = defaultTrips.where((element) => element.isLiked).toList();
  }

  getUserInformation() async {
    final res = await http.post(
        Uri.parse('${server}rest/public-user-controller/get-info'),
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
    String em = emailController.text.toLowerCase();
    String pass = passwordController.text;
    final res =
        await http.post(Uri.parse("${server}rest/public-user-controller/login"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{'email': em, 'password': pass}));

    if (res.body == "ACCESSED") {
      isLogged = true;
      await getUserInformation();
      await getTrips();

      // await getHistory();
    }
    return res.body;
  }

  logOut() {
    isLogged = false;
  }

  getHistory() async {
    List l = (await SQL.sql.getAllTrips(user.id!));

    // log(l[0]['company']);
    // history = l.map((e) => Trip.fromDBMap(e)).toList();
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
          "email": emailController.text.toLowerCase(),
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
    getLikedTrips();
    notifyListeners();
  }

  File? imageFile;
  pickImageForCategory() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      await upload(imageFile!);
    }
    await getUserInformation();
    notifyListeners();
  }

  upload(File file) async {
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    // get file length
    var length = await file.length();
    var uri =
        Uri.parse("http://10.0.2.2:8083/rest/public-user-controller/file");
    var req = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    req.files.add(multipartFile);
    req.fields.addAll({'id': user.id!});
    var resp = await req.send();
  }
}
