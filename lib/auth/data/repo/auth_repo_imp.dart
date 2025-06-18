import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety_provider/auth/data/models/provider_curuser.dart';
import 'package:taht_bety_provider/auth/data/models/user/user.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/auth/data/repo/auth_repo.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/core/utils/api_service.dart';
import 'package:taht_bety_provider/core/utils/app_fun.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';

class AuthRepoImp implements AuthRepo {
  final ApiService apiService;

  AuthRepoImp(this.apiService);
  @override
  Future<void> resetPassword({required String email}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProviderCurUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response['success']) {
        final userData = response['data'];
        ProviderCurUser user = ProviderCurUser.fromJson(userData['user']);
        user.token = userData['token'];

        if (user.role != 'provider') {
          return Left(Serverfailure(
              "You are not allowed to sign in as a non-provider."));
        }
        await UserStorage.saveUserData(
          token: user.token,
          userId: user.userId,
          name: user.name,
          email: user.email,
          photo: user.photo,
          phoneNumber: user.phoneNumber,
          role: user.role,
          region: user.region,
          age: user.age,
          gender: user.gender,
          verificationCodeExpiresAt: user.lastPhotoAt,
          idFrontSide: user.idFrontSide,
          idBackSide: user.idBackSide,
          isActive: user.isActive,
          isOnline: user.isOnline,
          type: user.type,
          providerId: user.providerId,
        );
        try {
          final response =
              await apiService.get(endPoint: 'providers/${user.userId}');
          if (response['success']) {
            final providerData = response['data'];

            user.idFrontSide = providerData['id'][0];
            user.idBackSide = providerData['id'][1] ?? '';
            user.type = providerData['providerType'];
            user.providerId = providerData['_id'];
            user.isActive = providerData['isActive'] ?? false;
            user.isOnline = providerData['isOnline'] ?? false;
            user.lastPhotoAt = DateTime.parse(providerData['lastPhotoAt'] ??
                DateTime.now().toIso8601String());
          } else {
            if (response['message'] != null) {
              String failMes = response['message'];
              if (failMes
                  .toLowerCase()
                  .contains('no provider found with that id')) {
                return Left(Serverfailure(user.email));
              } else {
                return Left(Serverfailure(response['message']));
              }
            } else {
              return Left(Serverfailure('Failed to sign in'));
            }
          }
        } on DioException catch (e) {
          if (e.response != null && e.response!.data is Map<String, dynamic>) {
            String failMes = e.response!.data['message'] ?? '';
            if (failMes
                .toLowerCase()
                .contains('no provider found with that id')) {
              return Left(Serverfailure(user.email));
            }
            if (e.response!.data['error_code'] == "A4000") {
              return Left(Serverfailure("Please verify your email first."));
            } else {
              return Left(Serverfailure(e.response!.data['message'] ??
                  'An error occurred during sign in'));
            }
          }
          return Left(Serverfailure(e.toString()));
        }
        await UserStorage.saveUserData(
          token: user.token,
          userId: user.userId,
          name: user.name,
          email: user.email,
          photo: user.photo,
          phoneNumber: user.phoneNumber,
          role: user.role,
          region: user.region,
          age: user.age,
          gender: user.gender,
          verificationCodeExpiresAt: user.lastPhotoAt,
          idFrontSide: user.idFrontSide,
          idBackSide: user.idBackSide,
          isActive: user.isActive,
          isOnline: user.isOnline,
          type: user.type,
          providerId: user.providerId,
        );
        final now = DateTime.now();
        final difference = now.difference(user.lastPhotoAt!);

        if (difference.inDays > 2 && AppFun.needId(user.type!)) {
          return left(Serverfailure('need verify'));
        }
        return Right(user);
      } else {
        return Left(Serverfailure('Failed to sign in'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        if (e.response!.data['error_code'] == "A4000") {
          return Left(Serverfailure("Please verify your email first."));
        } else {
          return Left(Serverfailure(e.response!.data['message'] ??
              'An error occurred during sign in'));
        }
      }
      return Left(Serverfailure(e.toString()));
    } catch (e) {
      print(e);
      return Left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String region,
    required String gender,
    required String age,
    required String role,
    required String phoneNumber,
    required String type,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'auth/signup',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'passwordConfirm': confirmPassword,
          'region': region,
          'gender': gender,
          'age': age,
          'signUpPlatform': 'mobile',
          'role': role,
          'phoneNumber': phoneNumber,
          'type': type,
        },
      );

      if (response['success']) {
        final userData = response['data'];
        ProviderCurUser user = ProviderCurUser.fromJson(userData['user']);
        user.token = userData['token'];
        await UserStorage.saveUserData(
          token: user.token,
          userId: user.userId,
          name: user.name,
          email: user.email,
          photo: user.photo,
          phoneNumber: user.phoneNumber,
          role: user.role,
          region: user.region,
          age: user.age,
          gender: user.gender,
          verificationCodeExpiresAt: user.lastPhotoAt,
          idFrontSide: user.idFrontSide,
          idBackSide: user.idBackSide,
          isActive: user.isActive,
          isOnline: user.isOnline,
          type: type,
          providerId: user.providerId,
        );
        return Right(response['message']);
      } else {
        return Left(Serverfailure(response['message'] ?? 'Signup failed.'));
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred during sign up';
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      }
      return Left(Serverfailure(errorMessage));
    }
  }

  @override
  Future<void> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProviderCurUser>> fetchuser() async {
    try {
      final user = UserStorage.getUserData();
      final response =
          await apiService.get(endPoint: 'users/me', token: user.token);

      if (response['success']) {
        final userData = response['data'];
        ProviderCurUser user = ProviderCurUser.fromJson(userData['user']);
        user.token = userData['token'];

        if (user.role != 'provider') {
          return Left(Serverfailure(
              "You are not allowed to sign in as a non-provider."));
        }

        try {
          final response =
              await apiService.get(endPoint: 'providers/${user.userId}');
          if (response['success']) {
            final providerData = response['data'];

            user.idFrontSide = providerData['id'][0];
            user.idBackSide = providerData['id'][1] ?? '';
            user.type = providerData['providerType'];
            user.providerId = providerData['_id'];
            user.isActive = providerData['isActive'] ?? false;
            user.isOnline = providerData['isOnline'] ?? false;
            user.lastPhotoAt =
                DateTime.parse(providerData['verificationCodeExpiresAt']);
          } else {
            return Left(Serverfailure(user.email));
          }
        } catch (e) {
          return Left(Serverfailure('Failed to sign in'));
        }
        await UserStorage.saveUserData(
          token: user.token,
          userId: user.userId,
          name: user.name,
          email: user.email,
          photo: user.photo,
          phoneNumber: user.phoneNumber,
          role: user.role,
          region: user.region,
          age: user.age,
          gender: user.gender,
          verificationCodeExpiresAt: user.lastPhotoAt,
          idFrontSide: user.idFrontSide,
          idBackSide: user.idBackSide,
          isActive: user.isActive,
          isOnline: user.isOnline,
          type: user.type,
          providerId: user.providerId,
        );
        return Right(user);
      } else {
        return Left(Serverfailure('Failed to sign in'));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 401) {
          UserStorage.deleteUserData();
          return Left(Serverfailure('Unauthorized'));
        } else if (e.response != null) {
          return Left(Serverfailure(e.response!.data['message']));
        }
      }
      return Left(Serverfailure('Unknown error'));
    }
  }

  @override
  Future<Either<Failure, List<File>>> checkId(
      File frontImage, File backImage) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(frontImage.path),
        // 'backImage': await MultipartFile.fromFile(backImage.path),
      });
      final listFiles = <File>[
        frontImage,
        backImage,
      ];
      String frontImage64 = await AppFun.imageToBase64(frontImage);
      String backImage64 = await AppFun.imageToBase64(backImage);

      UserStorage.updateUserData(
        idFrontSide: frontImage64,
        idBackSide: backImage64,
      );

      return Right(listFiles);

      final response = await Dio().post(
        'https://e754-41-234-5-74.ngrok-free.app/predict',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['status'] == 'real') {
          final listFiles = <File>[
            frontImage,
            backImage,
          ];

          return Right(listFiles);
        } else if (response.data['status'] == 'fake') {
          return Left(Serverfailure(response.data['process_results']
                  ['final_result'] ??
              'Failed to check ID'));
        } else {
          return Left(Serverfailure('Unknown status from server'));
        }
      } else {
        return Left(
            Serverfailure(response.data['message'] ?? 'Failed to check ID'));
      }
    } catch (e) {
      return Left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, File>> createFaceID(
      {required File photo, required bool isSignUp}) async {
    String errorMessage =
        'An error occurred during create face ID, please try again or take clear photo';
    String checkState = isSignUp ? 'signUp' : 'verify';
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(photo.path),
      });

      return Right(photo);
      final response = await Dio().post(
        'https://fe60-41-234-5-74.ngrok-free.app/verify',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(photo);
      } else {
        return Left(Serverfailure(errorMessage));
      }
    } on DioException catch (e) {
      return Left(Serverfailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, ProviderModel>> createProvider(
      {required bool isActive}) async {
    try {
      final saveduser = UserStorage.getUserData();
      final userresponse =
          await apiService.get(endPoint: 'users/me', token: saveduser.token);
      final userData = User.fromJson(userresponse['data']['user']);
      final response = await apiService.post(
        endPoint: 'providers',
        data: {
          "providerType":
              saveduser.type == '' ? 'F-Restaurants' : saveduser.type,
          "subscriptionType": "percentage",
          "subscriptionPercentage": 10,
          "isActive": isActive,
          "isOnline": false,
          "reports": [],
          "locations": [
            {
              "coordinates": {
                "type": "Point",
                "coordinates": [
                  userData.locations?[0].coordinates.coordinates[0] ?? 0.0,
                  userData.locations?[0].coordinates.coordinates[1] ?? 0.0,
                ]
              },
              "address": userData.locations?[0].address ?? '',
            }
          ]
        },
        token: saveduser.token,
      );

      if (response['message'] == 'success') {
        final provider = ProviderModel.fromJson(response['provider']);
        File frontId =
            await AppFun.base64ToFile(saveduser.idFrontSide!, 'idFrontSide');
        File backId =
            await AppFun.base64ToFile(saveduser.idFrontSide!, 'idBackSide');
        final formData = FormData.fromMap({
          'id': [
            await MultipartFile.fromFile(frontId.path),
            await MultipartFile.fromFile(backId.path),
          ],
        });
        final idResonse = await apiService.put(
          endPoint: 'providers/${provider.providerId}/uploadID',
          data: formData,
          token: saveduser.token,
        );

        await UserStorage.updateUserData(
          providerId: provider.providerId,
        );

        return Right(provider);
      } else {
        return Left(Serverfailure(response['message'] ?? 'Signup failed.'));
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred during sign up';
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      }
      return Left(Serverfailure(errorMessage));
    }
  }
}
