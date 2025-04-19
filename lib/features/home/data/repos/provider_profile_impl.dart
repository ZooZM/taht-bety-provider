import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
}
