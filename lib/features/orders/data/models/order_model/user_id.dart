import 'package:taht_bety_provider/auth/data/models/user/location.dart';

class UserId {
  String? id;
  String? name;
  String? email;
  String? photo;
  List<Location>? locations;
  String? phoneNumber;

  UserId(
      {this.id,
      this.name,
      this.email,
      this.photo,
      this.locations,
      this.phoneNumber});

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        photo: json['photo'] as String?,
        locations: (json['locations'] as List<dynamic>?)
            ?.map((e) => Location.fromJson(e))
            .toList(),
        phoneNumber: json['phoneNumber'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'photo': photo,
        'locations': locations?.map((e) => e.toJson()).toList(),
        'phoneNumber': phoneNumber,
      };
}
