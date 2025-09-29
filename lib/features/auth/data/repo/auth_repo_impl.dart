import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/core/utils/services/remote_services/api_service.dart';
import 'package:pingora/core/utils/services/remote_services/endpoints.dart';
import 'package:pingora/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  ApiService apiService;

  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiService.postData(
        endPoint: EndPoints.login,
        data: {"email": email, "password": password},
        sendToken: true,
      );

      return Right(response.data['data']['accessToken']);
    } catch (e) {
      log('login up error: $e');
      if (e is DioException) {
        log('error response: ${e.response!.data}');
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(
        ServerFailure('An unexpected error occurred. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    required String phone,
  }) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.signUp,
        data: {
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "username": username,
          "phone": phone,
        },
        sendToken: true,
      );

      return Right(response.data['data']['accessToken']);
    } catch (e) {
      log('sign up error: $e');
      if (e is DioException) {
        log('error response: ${e.response!.data}');
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(
        ServerFailure('An unexpected error occurred. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.logout,
        sendToken: true,
      );

      return Right(response.data['success']);
    } catch (e) {
      log('logout error: $e');
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
