import 'package:dartz/dartz.dart';
import 'package:taht_bety_provider/auth/data/models/curuser.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, CurUser>> signInWithEmailAndPassword({
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
  });

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<void> verifyEmail();

  Future<Either<Failure, CurUser>> fetchuser();
}
