import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String? id;
  String? first_name;
  String? last_name;
  String? email;
  String? password;
  String? phoneNumber;
  String? role;
  List? liked_trips;
  User({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.password,
    this.phoneNumber,
    this.role,
    this.liked_trips,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'role': role,
      'liked_trips': liked_trips.toString(),
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
      liked_trips: map['liked_trips']??[],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, first_name: $first_name, last_name: $last_name, email: $email, password: $password, phoneNumber: $phoneNumber, role: $role, liked_trips: $liked_trips)';
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
