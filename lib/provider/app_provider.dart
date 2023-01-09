import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:demo/api/api_helper.dart';
import 'package:demo/date_repo/database_handler.dart';
import 'package:demo/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';
import '../models/user.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:demo/date_repo/enum.dart';

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
      'chat': []
    });
  }
  String server = "http://10.0.2.2:8083/";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController authKeyController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  List<Trip> defaultTrips = [];
  List<Trip> advancedTrip = [];
  List<Trip> mostPopular = [];
  List<Trip> likedTrips = [];
  List<Trip> history = [];
  List<Trip> filteredByCategory = [];
  List<Trip> bookedTrips = [];
  late Trip currentTrip;
  late User user;
  int rate = 0;
  bool isLogged = false;
  bool isDark = false;
  bool asCompany = false;
  int homeScreenIndex = 0;
  final List<Locale> languages = [const Locale('en'), const Locale('ar')];
  int local = 0;
  GlobalKey<FormState> signinKey = GlobalKey();
  GlobalKey<FormState> signupKey = GlobalKey();
  GlobalKey<FormState> confirmPageKey = GlobalKey();
  int? confirmKey;

  Map<Category, bool> defaultCategories = {
    Category.ancient: false,
    Category.beach: false,
    Category.cheap: false,
    Category.desert: false,
    Category.developedCity: false,
    Category.expensive: false,
    Category.greenLand: false,
    Category.mountant: false,
    Category.religous: false,
    Category.scientific: false,
  };

  List<String> hotelRanks = ['3-Stars', '5-Stars', '7-Stars'];
  List<String> categoriesMenu = [
    'all',
    'ancient',
    'beach',
    'cheap',
    'desert',
    'developedCity',
    'expensive',
    'nature',
    'mountant',
    'religous',
    'scientific'
  ];
  List<Category> c = [
    Category.ancient,
    Category.beach,
    Category.cheap,
    Category.desert,
    Category.developedCity,
    Category.expensive,
    Category.greenLand,
    Category.mountant,
    Category.religous,
    Category.scientific
  ];
  String chosenCategory = 'all';

  changeRate(int value) {
    rate = value;
    notifyListeners();
  }

  ChangeCategory(value) {
    chosenCategory = value;
    filter();
    notifyListeners();
  }

  filter() {
    if (chosenCategory == 'all') {
      filteredByCategory = defaultTrips;
    } else {
      Category ind = c[(categoriesMenu.indexOf(chosenCategory)) - 1];
      filteredByCategory = defaultTrips
          .where((element) => element.categories!.contains(ind))
          .toList();
    }
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
    await SQL.sql.insert(t, user.id!);
    currentTrip = t;
    rate = 0;
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

  String? verifValidation(String? key) {
    if (key == null || key.isEmpty) {
      return 'required field';
    }
    if (!isNumeric(key) || key.length != 6) {
      return 'should be a 6-digit Number';
    }
    if (key != confirmKey.toString()) {
      return 'Invalid key';
    }
  }

  Trip getCurrentTrip() {
    return currentTrip;
  }

  rateTrip() async {
    final res = await API.apiHandler.rateTrip(<String, dynamic>{
      'userid': user.id,
      'tripid': currentTrip.id,
      'rate': rate
    });
    await getTrips();
    log(res);
  }

  bookTrip() async {
    final res;
    if (currentTrip.isBooked) {
      //unbook
      currentTrip.isBooked = false;
      user.booked_trips!.remove(currentTrip.id);
      res = await API.apiHandler.bookTrip(<String, String>{
        "userid": user.id!,
        "tripid": currentTrip.id,
        "method": "unbook"
      });
    } else {
      //book
      currentTrip.isBooked = true;

      user.booked_trips!.add(currentTrip.id);
      res = await API.apiHandler.bookTrip(<String, String>{
        "userid": user.id!,
        "tripid": currentTrip.id,
        "method": "book"
      });
    }
    await getTrips();
    notifyListeners();
    log(res);
    return res;
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

    firstnameController.text = user.first_name!;
    lastnameController.text = user.last_name!;
    emailController.text = user.email!;
    phoneNumberController.text = user.phoneNumber!;
    passwordController.text = user.password!;
    notifyListeners();
  }

  clearTextFields() {
    emailController.clear();
    firstnameController.clear();
    lastnameController.clear();
    passwordController.clear();
    phoneNumberController.clear();
  }

  logIn() async {
    if (signinKey.currentState!.validate()) {
      String em = emailController.text.toLowerCase();
      String pass = passwordController.text;
      final res = await http.post(
          Uri.parse("${server}rest/public-user-controller/login"),
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
  }

  logOut() {
    isLogged = false;
  }

  getHistory() async {
    List l = (await SQL.sql.getAllTrips(user.id!));
    List t = [];
    history = [];
    List<Trip> tem = [];
    for (var element in l) {
      t = defaultTrips.where((e) => e.id == element['id']).toList();
      if (t.length > 0) {
        tem.add(t[0]);
      }
    }
    history = tem.reversed.toList();
    notifyListeners();
    // log(l[0]['company']);
    // history = l.map((e) => Trip.fromDBMap(e)).toList();
  }

  createUser() async {
    if (confirmPageKey.currentState!.validate()) {
      final res = await API.apiHandler.createUser(<String, String>{
        "first_name": firstnameController.text,
        "last_name": lastnameController.text,
        "email": emailController.text.toLowerCase(),
        "password": passwordController.text,
        "phoneNumber": phoneNumberController.text,
        'image': 'not send'
      });
      await getUserInformation();
      await getTrips();
      return true;
    }
    return false;
  }

  signUp() async {
    if (signupKey.currentState!.validate()) {
      final String res = await API.apiHandler.UserSignUp(<String, String>{
        "first_name": firstnameController.text,
        "last_name": lastnameController.text,
        "email": emailController.text.toLowerCase(),
        "password": passwordController.text,
        "phoneNumber": phoneNumberController.text,
        'image': 'not send'
      });
      if (res.toLowerCase() == ("Email already signed up".toLowerCase())) {
        return false;
      }
      confirmKey = int.parse(res);
      return true;

      // final res = await http.post(
      //     Uri.parse("${server}rest/public-user-controller"),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8'
      //     },
      //     body: jsonEncode(<String, String>{
      //       "first_name": firstnameController.text,
      //       "last_name": lastnameController.text,
      //       "email": emailController.text.toLowerCase(),
      //       "password": passwordController.text,
      //       "phoneNumber": phoneNumberController.text,
      //       'image': 'not send'
      //     }));
    }
  }

  getTrips() async {
    final res =
        await http.get(Uri.parse("${server}rest/public-trip-controller"));
    List dummy = jsonDecode(res.body);

    defaultTrips = dummy.map((e) => Trip.fromMap(e)).toList();
    for (var element in defaultTrips) {
      element.isLiked = user.liked_trips!.contains(element.id);
      element.categories = element.getCategories(element.categories ?? []);
      element.isBooked = user.booked_trips!.contains(element.id);
    }
    advancedTrip = defaultTrips;
    mostPopular = defaultTrips.toList();
    mostPopular.sort((a, b) => a.rate > b.rate ? 0 : 1);
    bookedTrips = defaultTrips
        .where(
          (element) => element.isBooked,
        )
        .toList();
    getLikedTrips();
    filteredByCategory = defaultTrips;
    await getHistory();
    notifyListeners();
  }

  File? imageFile;
  pickImageForCategory() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      await API.apiHandler.uploadUserPicture(imageFile!, user.id!);
    }
    await getUserInformation();
    notifyListeners();
  }

  sendMessage() async {
    if (messageController.text.isEmpty) return;

    await API.apiHandler.contactUs(<String, dynamic>{
      'userid': user.id,
      'text': messageController.text,
      'isSender': false
    });
    messageController.clear();
    await getUserInformation();
    notifyListeners();
  }
}
