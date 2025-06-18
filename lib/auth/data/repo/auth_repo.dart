import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:taht_bety_provider/auth/data/models/provider_curuser.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, ProviderCurUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

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
  });

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<void> verifyEmail();

  Future<Either<Failure, ProviderCurUser>> fetchuser();

  Future<Either<Failure, List<File>>> checkId(File frontImage, File backImage);

  Future<Either<Failure, File>> createFaceID(
      {required File photo, required bool isSignUp});

  Future<Either<Failure, ProviderModel>> createProvider(
      {required bool isActive});
}
