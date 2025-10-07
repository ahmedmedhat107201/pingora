import 'package:dartz/dartz.dart';
import 'package:pingora/core/errors/failure.dart';
import 'package:pingora/core/shared/shared_models/room_model.dart';
import 'package:pingora/features/chat_rooms/data/models/chat_rooms_model.dart';

abstract class ChatRoomsRepo {
  Future<Either<Failure, ChatRoomsModel>> getChatRooms();

  Future<Either<Failure, Room>> createPrivateRoom({required int userId});
}
