import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/core/utils/services/remote_services/api_service.dart';
import 'package:pingora/core/utils/services/remote_services/endpoints.dart';
import 'package:pingora/features/chat_room/data/models/get_room_messages_models.dart';
import 'package:pingora/features/chat_room/data/repo/chat_room_repo.dart';

class ChatRoomRepoImpl implements ChatRoomRepo {
  ApiService apiService;

  ChatRoomRepoImpl(this.apiService);

  @override
  Future<Either<Failure, GetRoomMessagesModel>> getChatMessages({
    required int roomId,
  }) async {
    try {
      var response = await apiService.get(
        endPoint: "${EndPoints.getRoomMessages}/$roomId",
        query: {"per_page": 100},
      );

      return Right(GetRoomMessagesModel.fromJson(response.data));
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
