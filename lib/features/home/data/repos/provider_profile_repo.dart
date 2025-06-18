import 'package:dartz/dartz.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';

import '../models/provider_model/post.dart';

abstract class ProviderProfileRepo {
  Future<Either<Failure, ProviderModel>> fetchProvider();
  Future<Either<Failure, Post>> addProduct({
    required String title,
    required String content,
    required double price,
    required List<String> images,
    required bool isMainService,
  });
  Future<Either<Failure, Post>> updateProduct({
    required String postId,
    required String title,
    required String content,
    required double price,
    required List<String> images,
    required bool isMainService,
  });
  Future<Either<Failure, void>> deleteProduct({
    required String postId,
  });
  Future<Either<Failure, void>> updateProviderImage(String image);
  Future<Either<Failure, void>> updateProviderName(String name);
  Future<Either<Failure, ProviderModel>> updateProviderState(
      bool isOnline, String providerId);
  Future<Either<Failure, void>> updateProviderLast(String name);
}
