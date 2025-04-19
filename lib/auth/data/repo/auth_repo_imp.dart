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

        if (user.role != 'provider') {
          return Left(Serverfailure(
              "You are not allowed to sign in as a non-provider."));
        }
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
      return Left(Serverfailure('An error occurred during sign in'));
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
  Future<Either<Failure, CurUser>> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
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
