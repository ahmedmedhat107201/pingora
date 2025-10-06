import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/core/utils/services/remote_services/api_service.dart';
import 'package:pingora/core/utils/services/remote_services/endpoints.dart';
import 'package:pingora/features/profile/data/models/get_me_model.dart';
import 'package:pingora/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  ApiService apiService;

  ProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, GetMeModel>> getMe() async {
    try {
      var response = await apiService.get(
        endPoint: EndPoints.getMe,
        sendToken: true,
      );

      return Right(GetMeModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        log(e.response!.data.toString());
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(
        ServerFailure('An unexpected error occurred. Please try again.'),
      );
    }
  }
}
