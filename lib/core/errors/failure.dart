import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class Failure {
  final String errMessage;
  final int? statusCode;

  Failure(this.errMessage, {this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage, {super.statusCode});

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("connectionTimeOut");
      case DioExceptionType.sendTimeout:
        return ServerFailure("sendTimeOut");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("receiveTimeOut");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode ?? 404,
          dioException.response?.data ?? {},
        );
      case DioExceptionType.cancel:
        return ServerFailure("requestCanceled");
      case DioExceptionType.unknown:
        if (dioException.error!.toString().contains("SocketException")) {
          return ServerFailure("noInternet".tr());
        } else {
          return ServerFailure("unexpectedError");
        }

      default:
        return ServerFailure("Something went Error Try Again");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 423) {
      return ServerFailure(response["message"].toString(), statusCode: 423);
    } else if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 409 ||
        statusCode == 404 ||
        statusCode == 422) {
      return ServerFailure(response["message"].toString());
    } else if (statusCode == 500) {
      return ServerFailure("internalServerError");
    } else {
      return ServerFailure("Something went Error Try Again");
    }
  }
}

class CustomFailure extends Failure {
  CustomFailure(super.errMessage);
  static Failure getFailure(e) {
    print(e);
    if (e is DioException) {
      print("error=> ${e.response?.data.toString()}");
      return ServerFailure.fromDioError(e);
    } else {
      return CustomFailure(e.toString());
    }
  }
}
