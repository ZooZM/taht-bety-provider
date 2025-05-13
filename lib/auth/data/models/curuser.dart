import 'package:hive/hive.dart';
part 'curuser.g.dart';

@HiveType(typeId: 0)
class CurUser extends HiveObject {
  @HiveField(0)
  String token;
  @HiveField(1)
  String userId;
  @HiveField(2)
  String name;
  @HiveField(3)
  String email;
  @HiveField(4)
  String photo;
  @HiveField(5)
  String phoneNumber;
  @HiveField(6)
  String role;
  @HiveField(7)
  String region;
  @HiveField(8)
  int age;
  @HiveField(9)
  String gender;
  @HiveField(10)
  DateTime verificationCodeExpiresAt;
  @HiveField(11)
  String idFrontSide;
  @HiveField(12)
  String idBackSide;
  @HiveField(13)
  String isActive;
  @HiveField(14)
  String isOnline;
  @HiveField(15)
  String type;

  CurUser({
    required this.token,
    required this.userId,
    required this.name,
    required this.email,
    required this.photo,
    required this.phoneNumber,
    required this.role,
    required this.region,
    required this.age,
    required this.gender,
    required this.verificationCodeExpiresAt,
    required this.idFrontSide,
    required this.idBackSide,
    required this.isActive,
    required this.isOnline,
    required this.type,
  });

  factory CurUser.fromJson(Map<String, dynamic> json) {
    return CurUser(
      token: json['token'] ?? '',
      userId: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photo: json['photo'] is String ? json['photo'] : '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      region: json['region'] ?? '',
      age: json['age'] is int
          ? json['age']
          : (json['age'] is String
              ? int.tryParse(json['age']) ?? 0
              : (json['age'] is List && json['age'].isNotEmpty
                  ? int.tryParse(json['age'][0].toString()) ?? 0
                  : 0)),
      gender: json['gender'] ?? '',
      verificationCodeExpiresAt: json['verificationCodeExpiresAt'] is String
          ? DateTime.tryParse(json['verificationCodeExpiresAt']) ??
              DateTime.now()
          : DateTime.now(),
      idFrontSide: json['idFrontSide'] ?? '',
      idBackSide: json['idBackSide'] ?? '',
      isActive: json['isActive'] ?? '',
      isOnline: json['isOnline'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
