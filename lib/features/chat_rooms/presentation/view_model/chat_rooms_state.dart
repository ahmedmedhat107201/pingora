part of 'chat_rooms_cubit.dart';

@immutable
sealed class ChatRoomsState {}

final class ChatRoomsInitial extends ChatRoomsState {}

final class GetChatRoomsLoading extends ChatRoomsState {}

final class GetChatRoomsSuccess extends ChatRoomsState {
  final ChatRoomsModel chatRoomsModel;

  GetChatRoomsSuccess(this.chatRoomsModel);
}

final class GetChatRoomsError extends ChatRoomsState {
  final String errorMessage;

  GetChatRoomsError(this.errorMessage);
}

final class CreatePrivateRoomLoading extends ChatRoomsState {}

final class CreatePrivateRoomSuccess extends ChatRoomsState {
  final Room room;

  CreatePrivateRoomSuccess(this.room);
}

final class CreatePrivateRoomError extends ChatRoomsState {
  final String errorMessage;

  CreatePrivateRoomError(this.errorMessage);
}
