import 'package:dartz/dartz.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/features/chat_room/data/models/get_room_messages_models.dart';

abstract class ChatRoomRepo {
  Future<Either<Failure, GetRoomMessagesModel>> getChatMessages({
    required int roomId,
  });

  Future<Either<Failure, int>> sendMessage({
    required int roomId,
    required String message,
  });
}
