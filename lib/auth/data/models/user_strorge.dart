import 'package:hive/hive.dart';
import 'package:taht_bety_provider/auth/data/models/curuser.dart';
import 'package:taht_bety_provider/constants.dart';

class UserStorage {
  static Box<CurUser>? _box;

  static Future<void> init() async {
    if (_box != null) return;

    if (Hive.isBoxOpen(kCurUserBox)) {
      _box = Hive.box<CurUser>(kCurUserBox);
    } else {
      try {
        _box = await Hive.openBox<CurUser>(kCurUserBox);
      } catch (e) {
        await Hive.deleteBoxFromDisk(kCurUserBox);
        _box = await Hive.openBox<CurUser>(kCurUserBox);
      }
    }
  }

  static Future<void> saveUserData({
    required String? token,
    required String? userId,
    required String? name,
    required String? email,
    required String? photo,
    required String? phoneNumber,
    required String? role,
    required String? region,
    required int? age,
    required String? gender,
    required DateTime? verificationCodeExpiresAt,
    required String? idFrontSide,
    required String? idBackSide,
    required String? isActive,
    required String? isOnline,
    required String? type,
  }) async {
    final user = CurUser(
      token: token ?? "unknown",
      userId: userId ?? "unknown",
      name: name ?? "unknown",
      email: email ?? "unknown@example.com",
      photo: photo ?? "default_photo_url",
      phoneNumber: phoneNumber ?? "unknown",
      role: role ?? "unknown",
      region: region ?? "unknown",
      age: age ?? 0,
      gender: gender ?? "unknown",
      verificationCodeExpiresAt: verificationCodeExpiresAt ?? DateTime.now(),
      idFrontSide: idFrontSide ?? '',
      idBackSide: idBackSide ?? '',
      isActive: isActive ?? 'unknown',
      isOnline: isOnline ?? 'unknown',
      type: type ?? 'unknown',
    );

    await _box?.put(kCurUserBox, user);
  }

  static CurUser getUserData() {
    return _box?.get(kCurUserBox) ??
        CurUser(
          token: 'unknown',
          userId: 'unknown',
          name: 'unknown',
          email: 'unknown@example.com',
          photo: 'default_photo_url',
          phoneNumber: 'unknown',
          role: 'unknown',
          region: 'unknown',
          age: 0,
          gender: 'unknown',
          verificationCodeExpiresAt: DateTime.now(),
          idFrontSide: 'unknown',
          idBackSide: 'unknown',
          isActive: 'unknown',
          isOnline: 'unknown',
          type: 'unknown',
        );
  }

  static Future<void> deleteUserData() async {
    await _box?.delete(kCurUserBox);
  }

  static Future<void> updateUserData({
    String? token,
    String? userId,
    String? name,
    String? email,
    String? photo,
    String? phoneNumber,
    String? role,
    String? region,
    int? age,
    String? gender,
    DateTime? verificationCodeExpiresAt,
    List<String>? locations,
  }) async {
    final user = getUserData();
    user.token = token ?? user.token;
    user.userId = userId ?? user.userId;
    user.name = name ?? user.name;
    user.email = email ?? user.email;
    user.photo = photo ?? user.photo;
    user.phoneNumber = phoneNumber ?? user.phoneNumber;
    user.role = role ?? user.role;
    user.region = region ?? user.region;
    user.age = age ?? user.age;
    user.gender = gender ?? user.gender;
    user.verificationCodeExpiresAt =
        verificationCodeExpiresAt ?? user.verificationCodeExpiresAt;

    await _box?.put(kCurUserBox, user);
  }
}
