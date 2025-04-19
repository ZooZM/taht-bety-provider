import 'package:dartz/dartz.dart';
import 'package:taht_bety_provider/auth/data/models/curuser.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, CurUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, CurUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<void> verifyEmail();

  Future<Either<Failure, CurUser>> fetchuser();
}
