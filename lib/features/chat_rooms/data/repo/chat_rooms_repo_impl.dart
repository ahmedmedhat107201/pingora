import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/core/shared/shared_models/room_model.dart';
import 'package:pingora/core/utils/services/remote_services/api_service.dart';
import 'package:pingora/core/utils/services/remote_services/endpoints.dart';
import 'package:pingora/features/chat_rooms/data/models/chat_rooms_model.dart';
import 'package:pingora/features/chat_rooms/data/repo/chat_rooms_repo.dart';

class ChatRoomsRepoImpl implements ChatRoomsRepo {
  ApiService apiService;

  ChatRoomsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ChatRoomsModel>> getChatRooms() async {
    try {
      var response = await apiService.get(endPoint: EndPoints.getChatRooms);

      return Right(ChatRoomsModel.fromJson(response.data));
    } catch (e) {
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
  Future<Either<Failure, Room>> createPrivateRoom({required int userId}) async {
    try {
      var response = await apiService.postData(
        endPoint: EndPoints.createPrivateRoom,
        data: {"user_id": userId},
      );

      return Right(Room.fromJson(response.data['room']));
    } catch (e) {
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
