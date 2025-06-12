import 'package:dartz/dartz.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';

abstract class ProviderProfileRepo {
  Future<Either<Failure, ProviderModel>> fetchProvider();
  Future<Either<Failure, void>> updateProviderImage(String image);
  Future<Either<Failure, void>> updateProviderName(String name);
  Future<Either<Failure, void>> updateProviderState(
      bool isOnline, String providerId);
}
