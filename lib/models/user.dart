import 'dart:convert';

import 'package:demo/api/api_helper.dart';
import 'package:demo/models/message.dart';
import 'package:flutter/foundation.dart';

import '../api/adminApi.dart';

class User {
  String? id;
  String? first_name;
  String? last_name;
  String? email;
  String? password;
  String? phoneNumber;
  String? role;
  List? liked_trips;
  List? booked_trips;
  String? image;
  List<Message> chat;
  User(
      {this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.password,
      this.phoneNumber,
      this.role,
      this.liked_trips,
      this.image,
      this.booked_trips,
      this.chat = const []});

  User copyWith({
    String? id,
    String? first_name,
    String? last_name,
    String? email,
    String? password,
    String? phoneNumber,
    String? role,
    List? liked_trips,
  }) {
    return User(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }

  List<Message> getChat(List l) {
    return l.map((e) => Message.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'role': role,
      'liked_trips': liked_trips?.toString(),
      'image': image,
      'booked_trips': booked_trips?.toString(),
      'chat': chat.toString()
    };
  }

  Map<String, dynamic> toDBMap({bool logged = false}) {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'logged': logged ? 1 : 0
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        first_name: map['first_name'],
        last_name: map['last_name'],
        email: map['email'],
        password: map['password'],
        phoneNumber: map['phoneNumber'],
        role: map['role'],
        liked_trips: map['liked_trips'] ?? [],
        image: API.apiHandler.server + map['image'],
        booked_trips: map['booked_trips'] ?? [],
        chat: (map['chat'] as List).map((e) => Message.fromMap(e)).toList());
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id,image:$image first_name: $first_name, last_name: $last_name, email: $email, password: $password, phoneNumber: $phoneNumber, role: $role, liked_trips: $liked_trips)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.email == email &&
        other.password == password &&
        other.phoneNumber == phoneNumber &&
        other.role == role &&
        listEquals(other.liked_trips, liked_trips);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        phoneNumber.hashCode ^
        role.hashCode ^
        liked_trips.hashCode;
  }
}
