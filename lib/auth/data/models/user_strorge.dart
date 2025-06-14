import 'package:hive/hive.dart';
import 'package:taht_bety_provider/auth/data/models/provider_curuser.dart';
import 'package:taht_bety_provider/constants.dart';

class UserStorage {
  static Box<ProviderCurUser>? _box;

  static Future<void> init() async {
    if (_box != null) return;

    if (Hive.isBoxOpen(kCurUserBox)) {
      _box = Hive.box<ProviderCurUser>(kCurUserBox);
    } else {
      try {
        _box = await Hive.openBox<ProviderCurUser>(kCurUserBox);
      } catch (e) {
        final dir = Hive.boxExists(kCurUserBox);
        if (await dir) {
          await Hive.deleteBoxFromDisk(kCurUserBox);
        }

        _box = await Hive.openBox<ProviderCurUser>(kCurUserBox);
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
    required bool? isActive,
    required bool? isOnline,
    required String? type,
    required String? providerId,
  }) async {
    final user = ProviderCurUser(
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
      isActive: isActive ?? false,
      isOnline: isOnline ?? false,
      type: type ?? 'unknown',
      providerId: providerId ?? 'unknown',
    );

    await _box?.put(kCurUserBox, user);
  }

  static ProviderCurUser getUserData() {
    return _box?.get(kCurUserBox) ??
        ProviderCurUser(
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
          isActive: false,
          isOnline: false,
          type: 'unknown',
          providerId: 'unknown',
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
    String? idFrontSide,
    String? idBackSide,
    bool? isActive,
    bool? isOnline,
    String? type,
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
    user.idFrontSide = idFrontSide ?? user.idFrontSide;
    user.idBackSide = idBackSide ?? user.idBackSide;
    user.isActive = user.isActive ?? isActive;
    user.isOnline = user.isOnline ?? isOnline;
    user.type = user.type ?? type;

    await _box?.put(kCurUserBox, user);
  }
}
