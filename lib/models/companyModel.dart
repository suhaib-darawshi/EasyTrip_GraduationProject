import 'dart:convert';

class Company {
  String id;
  String name;
  String address;
  double rank;
  String logo;
  String phone;
  String email;
  Company({
    required this.id,
    required this.name,
    required this.address,
    required this.rank,
    required this.logo,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'rank': rank,
      'logo': logo,
      'phone': phone,
      'email': email,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      rank: double.parse(map['rank'] ?? '0'),
      logo: map['logo'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  @override
  String toString(){
    return '{id: $id,name: $name,address: $address,rank:$rank,logo: $logo,phone:$phone,email: $email}';
  }
  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source));
}
