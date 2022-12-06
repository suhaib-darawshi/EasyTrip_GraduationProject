import 'dart:convert';

import 'package:flutter/foundation.dart';

class Trip {
  String id;
  String name;
  String location;
  String url;
  String description;
  List<String> liked_users;
  Trip({
    required this.id,
    required this.name,
    required this.location,
    required this.url,
    required this.description,
    required this.liked_users,
  });
  

  Trip copyWith({
    String? id,
    String? name,
    String? location,
    String? url,
    String? description,
    List<String>? liked_users,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      url: url ?? this.url,
      description: description ?? this.description,
      liked_users: liked_users ?? this.liked_users,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'url': url,
      'description': description,
      'liked_users': liked_users,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      url: map['url'] ?? '',
      description: map['description'] ?? '',
      liked_users: List<String>.from(map['liked_users']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Trip.fromJson(String source) => Trip.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Trip(id: $id, name: $name, location: $location, url: $url, description: $description, liked_users: $liked_users)';
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
      listEquals(other.liked_users, liked_users);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      location.hashCode ^
      url.hashCode ^
      description.hashCode ^
      liked_users.hashCode;
  }
}
