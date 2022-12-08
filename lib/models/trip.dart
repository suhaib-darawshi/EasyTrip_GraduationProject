import 'dart:convert';

import 'package:flutter/foundation.dart';

class Trip {
  String id;
  String name;
  String location;
  String url;
  String description;
  bool isLiked = false;
  Trip({
    required this.id,
    required this.name,
    required this.location,
    required this.url,
    required this.description,
    required this.isLiked,
  });

  Trip copyWith({
    String? id,
    String? name,
    String? location,
    String? url,
    String? description,
    bool? isLiked,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      url: url ?? this.url,
      description: description ?? this.description,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'url': url,
      'description': description,
      'isLiked': isLiked,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      url: 'http://10.0.2.2:8083/'+map['url'] ,
      description: map['description'] ?? '',
      isLiked: map['isLiked'] ?? false,
    );
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
