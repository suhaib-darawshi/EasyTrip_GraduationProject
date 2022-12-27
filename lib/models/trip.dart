import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import 'package:demo/models/companyModel.dart';

class Trip {
  String id;
  String name;
  String location;
  String url;
  String description;
  Company company;
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
  Trip({
    required this.id,
    required this.name,
    required this.location,
    required this.url,
    required this.description,
    required this.company,
    this.isLiked = false,
    required this.liked_count,
    this.isBooked = false,
    this.available = true,
    this.hotel = 'not provided',
    this.hotelRank='not provided',
    this.flight = 'not provided',
    this.price = 'not available',
    this.carProvided = false,
    this.foodDeserved = false,
    this.begin,
    this.end,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'url': url,
      'description': description,
      'company': company.toMap(),
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
      'begin': begin?.millisecondsSinceEpoch,
      'end': end?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toDBMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'url': url,
      'description': description,
      'company': company.toString(),
      'isLiked': isLiked ? 1 : 0,
      'liked_count': liked_count,
      'isBookedMarked': isBooked ? 1 : 0,
      'available': available
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      url: "http://10.0.2.2:8083/"+map['url'] ,
      description: map['description'] ?? '',
      company: Company.fromMap(map['company']),
      isLiked: map['isLiked'] ?? false,
      liked_count: map['liked_count']?.toInt() ?? 0,
      isBooked: map['isBooked'] ?? false,
      available: map['available'] ?? true,
      hotel: map['hotel'] ?? '',
      hotelRank: map['hotelRank'] ?? '',
      flight: map['flight'] ?? '',
      price: map['price'] ?? '',
      carProvided: map['carProvided'] ?? false,
      foodDeserved: map['foodDeserved'] ?? false,
      begin: map['begin'] != null ? DateTime.fromMillisecondsSinceEpoch(map['begin']) : null,
      end: map['end'] != null ? DateTime.fromMillisecondsSinceEpoch(map['end']) : null,
    );
  }
  factory Trip.fromDBMap(Map<String, dynamic> map) {
    return Trip(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        location: map['location'] ?? '',
        url: "http://localhost:8083/" + map['url'],
        description: map['description'] ?? '',
        company: Company.fromMap(jsonDecode(map['company'])),
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
