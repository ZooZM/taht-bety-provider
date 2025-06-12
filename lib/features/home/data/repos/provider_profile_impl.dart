import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety_provider/auth/data/models/user/user.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/core/utils/api_service.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety_provider/features/home/data/repos/provider_profile_repo.dart';

class ProviderProfileImpl implements ProviderProfileRepo {
  final ApiService apiService;

  ProviderProfileImpl(this.apiService);

  @override
  Future<Either<Failure, ProviderModel>> fetchProvider() async {
    try {
      final user = UserStorage.getUserData();
      print("Fetching provider for user: ${user.userId}");
      var providerResponse =
          await apiService.get(endPoint: 'providers/${user.userId}');

      ProviderModel? provider;
      if (!providerResponse['success']) {
        return left(Serverfailure(providerResponse['message']));
      }
      final providerData = providerResponse['data'];

      if (providerData != null) {
        provider = ProviderModel.fromJson(providerData);
      }

      return provider == null
          ? left(Serverfailure("No provider found"))
          : right(provider);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProviderImage(String image) async {
    try {
      var response = await apiService.put(
        endPoint: 'users/update-me',
        data: {
          "photo": image,
        },
        token: UserStorage.getUserData().token,
      );

      if (response['success']) {
        User updatedUser = User.fromJson(response['data']);
        return right(updatedUser);
      } else {
        return left(Serverfailure(response['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProviderName(String name) async {
    try {
      var response = await apiService.put(
        endPoint: 'users/update-me',
        data: {
          "name": name,
        },
        token: UserStorage.getUserData().token,
      );

      if (response['success']) {
        User updatedUser = User.fromJson(response['data']);
        return right(updatedUser);
      } else {
        return left(Serverfailure(response['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProviderModel>> updateProviderState(
      bool isOnline, String providerId) async {
    try {
      var response = await apiService.put(
        endPoint: 'providers/${providerId}',
        data: {
          "isOnline": isOnline,
        },
        token: UserStorage.getUserData().token,
      );

      if (response['success']) {
        ProviderModel updatedProvider =
            ProviderModel.fromJson(response['data']);
        return right(updatedProvider);
      } else {
        return left(Serverfailure(response['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }
}
