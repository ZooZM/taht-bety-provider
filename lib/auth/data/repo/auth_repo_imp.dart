import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety_provider/auth/data/models/curuser.dart';
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
  Future<Either<Failure, CurUser>> signInWithEmailAndPassword({
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
        CurUser user = CurUser.fromJson(userData['user']);
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
          verificationCodeExpiresAt: user.verificationCodeExpiresAt,
          idFrontSide: user.idFrontSide,
          idBackSide: user.idBackSide,
          isActive: user.isActive,
          isOnline: user.isOnline,
          type: user.type,
        );
        try {
          final response =
              await apiService.get(endPoint: 'providers/${user.userId}');
          if (response['success']) {
            final providerData = response['data'];
            user.idFrontSide = providerData['id'][0];
            user.idBackSide = providerData['id'][1] ?? '';
            user.isActive = providerData['isActive'];
            user.isOnline = providerData['isOnline'];
            user.type = providerData['providerType'];
          } else {
            return Left(Serverfailure(response['message']));
          }
        } catch (e) {
          return Left(Serverfailure(user.email));
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
        },
      );

      if (response['success']) {
        final userData = response['data'];
        CurUser user = CurUser.fromJson(userData['user']);
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
          type: user.type,
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
  Future<Either<Failure, CurUser>> fetchuser() async {
    try {
      final user = UserStorage.getUserData();
      final response =
          await apiService.get(endPoint: 'users/me', token: user.token);
      if (response['success']) {
        final userData = CurUser.fromJson(response['data']);
        return Right(userData);
      } else {
        return Left(Serverfailure(response['message']));
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
}
