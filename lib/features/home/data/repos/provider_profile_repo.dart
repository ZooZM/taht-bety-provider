import 'package:dartz/dartz.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';

abstract class ProviderProfileRepo {
  Future<Either<Failure, ProviderModel>> fetchProvider();
}
