import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety_provider/auth/data/models/provider_curuser.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/auth/data/repo/auth_repo.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/core/utils/api_service.dart';

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
            user.verificationCodeExpiresAt = DateTime.parse(
                providerData['verificationCodeExpiresAt'] ??
                    DateTime.now().toIso8601String());
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
          verificationCodeExpiresAt: user.verificationCodeExpiresAt,
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
          verificationCodeExpiresAt: user.verificationCodeExpiresAt,
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
            user.verificationCodeExpiresAt =
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
          verificationCodeExpiresAt: user.verificationCodeExpiresAt,
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
  Future<Either<Failure, File>> createFaceID(File photo) async {
    String errorMessage =
        'An error occurred during create face ID, please try again or take clear photo';

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(photo.path),
      });

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
}
