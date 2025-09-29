import 'package:dartz/dartz.dart';
import 'package:pingora/core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    required String phone,
  });

  Future<Either<Failure, bool>> logout();
}
