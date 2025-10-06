import 'package:dartz/dartz.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/features/users/data/models/users_model.dart';

abstract class UsersRepo {
  Future<Either<Failure, GetUsersModel>> getAllUsers();
}
