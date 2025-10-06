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
        sendToken: false,
      );

      return Right(response.data['data']['access_token']);
    } catch (e) {
      log('login up error: $e');
      if (e is DioException) {
        e.response?.statusMessage;
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
    String? profileImage,
  }) async {
    try {
      final response = await apiService.postDataWithImage(
        endPoint: EndPoints.signUp,
        data: FormData.fromMap({
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword,
          "name": username,
          if (profileImage != null)
            "profile_image": await MultipartFile.fromFile(
              profileImage,
              contentType: DioMediaType.parse('image/png'),
            ),
        }, ListFormat.multiCompatible),
        sendAuthToken: true,
        query: {},
      );

      return Right(response.data['data']['access_token']);
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

      return Right(response.statusCode == 200);
    } catch (e) {
      log('logout error: $e');
      if (e is DioException) {
        log('error response: ${e.response?.data}');

        // If it's a 404 or similar server error, still allow logout locally
        if (e.response?.statusCode == 404 || e.response?.statusCode == 500) {
          log(
            'Server logout endpoint not available, proceeding with local logout',
          );
          return Right(
            true,
          ); // Allow local logout even if server endpoint is missing
        }

        return Left(ServerFailure.fromDioError(e));
      }
      return Left(
        ServerFailure('An unexpected error occurred. Please try again.'),
      );
    }
  }
}
