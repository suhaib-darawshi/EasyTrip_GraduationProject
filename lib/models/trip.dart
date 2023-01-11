import 'dart:convert';
import 'dart:developer';

import 'package:demo/date_repo/enum.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:demo/models/companyModel.dart';

class Trip {
  String id;
  String name;
  String location;
  String url;
  String description;
  Company companyid;
  bool isLiked;
  int liked_count;
  bool isBooked;
  bool available;
  String hotel;
  String hotelRank;
  String flight;
  String price;
  bool carProvided;
  bool foodDeserved;
  DateTime? begin;
  DateTime? end;
  int duration;
  num rate;
  List? categories = [];
  bool approved;
  getCategories(List l) {
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
    List<Category> res = [];
    for (var x = 0; x < l.length; x++) {
      if (l[x]) {
        res.add(c[x]);
      }
    }

    return res;
  }

  Trip(
      {required this.id,
      required this.name,
      required this.location,
      required this.url,
      required this.description,
      required this.companyid,
      this.isLiked = false,
      required this.liked_count,
      this.isBooked = false,
      this.available = true,
      this.hotel = 'not provided',
      this.hotelRank = 'not provided',
      this.flight = 'not provided',
      this.price = 'not available',
      this.carProvided = false,
      this.foodDeserved = false,
      this.begin,
      this.end,
      this.duration = 3,
      this.categories,
      this.rate = 0,
      this.approved=true
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'url': url,
      'description': description,
      'companyid': companyid.id,
      'isLiked': isLiked,
      'liked_count': liked_count,
      'isBooked': isBooked,
      'available': available,
      'hotel': hotel,
      'hotelRank': hotelRank,
      'flight': flight,
      'price': price,
      'carProvided': carProvided,
      'foodDeserved': foodDeserved,
      'begin': begin,
      'end': end,
      'duration': duration,
      'categories': categories,
      'rate': rate,
      'approved':approved
    };
  }

  Map<String, dynamic> toDBMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'url': url,
      'description': description,
      'company': companyid.id,
      'isLiked': isLiked ? 1 : 0,
      'liked_count': liked_count,
      'isBookedMarked': isBooked ? 1 : 0,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        location: map['location'] ?? '',
        url: "http://10.0.2.2:8083/" + map['url'],
        description: map['description'] ?? '',
        companyid: Company.fromMap(map['company']),
        isLiked: map['isLiked'] ?? false,
        liked_count: int.parse(map['liked_count'].toString()),
        isBooked: map['isBooked'] ?? false,
        available: map['available'] ?? true,
        hotel: map['hotel'] ?? 'not provided',
        hotelRank:
            map['hotelRank'].toString().isEmpty ? "0" : map['hotelRank'] ?? '0',
        flight: map['flight'] ?? 'not provided',
        price: map['price'] ?? 'not provided',
        carProvided: map['carProvided'] ?? false,
        foodDeserved: map['foodDeserved'] ?? false,
        duration: map['duration'],
        categories: map['categories'],
        begin: map['begin'] != null ? DateTime.parse(map['begin']) : null,
        end: map['end'] != null ? DateTime.parse(map['end']) : null,
        rate: map['rate'] ?? 0,
        approved:map['approved']??true
        );
  }

  factory Trip.fromDBMap(Map<String, dynamic> map) {
    return Trip(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        location: map['location'] ?? '',
        url: "http://10.0.2.2:8083/" + map['url'],
        description: map['description'] ?? '',
        companyid: Company.fromMap(jsonDecode(map['company'])),
        isLiked: map['isLiked'] == 1,
        liked_count: map['liked_count']?.toInt() ?? 0,
        isBooked: map['isBooked'] == 1,
        available: map['available'] ?? true);
  }

  String toJson() => json.encode(toMap());

  factory Trip.fromJson(String source) => Trip.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Trip(id: $id, name: $name, location: $location, url: $url, description: $description, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Trip &&
        other.id == id &&
        other.name == name &&
        other.location == location &&
        other.url == url &&
        other.description == description &&
        other.isLiked == isLiked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        location.hashCode ^
        url.hashCode ^
        description.hashCode ^
        isLiked.hashCode;
  }
}
