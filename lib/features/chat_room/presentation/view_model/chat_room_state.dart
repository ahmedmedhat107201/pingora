part of 'chat_room_cubit.dart';

@immutable
sealed class ChatRoomState {}

final class ChatRoomInitial extends ChatRoomState {}

final class GetChatMessagesLoading extends ChatRoomState {}

final class GetChatMessagesSuccess extends ChatRoomState {
  final GetRoomMessagesModel getMessagesModel;
  GetChatMessagesSuccess(this.getMessagesModel);
}

final class GetChatMessagesError extends ChatRoomState {
  final String errorMessage;
  GetChatMessagesError(this.errorMessage);
}
