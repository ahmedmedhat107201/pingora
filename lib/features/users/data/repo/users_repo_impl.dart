import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/core/utils/services/remote_services/api_service.dart';
import 'package:pingora/core/utils/services/remote_services/endpoints.dart';
import 'package:pingora/features/users/data/models/users_model.dart';
import 'package:pingora/features/users/data/repo/users_repo.dart';

class UsersRepoImpl implements UsersRepo {
  ApiService apiService;

  UsersRepoImpl(this.apiService);

  @override
  Future<Either<Failure, GetUsersModel>> getAllUsers() async {
    try {
      var response = await apiService.get(endPoint: EndPoints.getUsers);

      return Right(GetUsersModel.fromJson(response.data));
    } catch (e) {
      log('getAllUsers error: $e');
      if (e is DioException) {
        log('error response: ${e.response!.data}');
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(
        ServerFailure('An unexpected error occurred. Please try again.'),
      );
    }
  }
}
