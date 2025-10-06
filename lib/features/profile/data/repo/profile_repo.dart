import 'package:dartz/dartz.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/features/profile/data/models/get_me_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, GetMeModel>> getMe();
}
