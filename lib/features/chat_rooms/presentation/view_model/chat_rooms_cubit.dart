import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingora/core/shared/shared_models/room_model.dart';
import 'package:pingora/features/chat_rooms/data/models/chat_rooms_model.dart';
import 'package:pingora/features/chat_rooms/data/repo/chat_rooms_repo.dart';

part 'chat_rooms_state.dart';

class ChatRoomsCubit extends Cubit<ChatRoomsState> {
  ChatRoomsRepo chatRoomsRepo;
  ChatRoomsCubit(this.chatRoomsRepo) : super(ChatRoomsInitial());

  ChatRoomsModel? chatRoomsModel;
  Room? createdRoom;

  Future<void> getChatRooms() async {
    log('tapped');
    emit(GetChatRoomsLoading());
    try {
      final result = await chatRoomsRepo.getChatRooms();
      result.fold(
        (failure) {
          emit(GetChatRoomsError(failure.errMessage));
        },
        (chatRoomsModel) {
          this.chatRoomsModel = chatRoomsModel;
          emit(GetChatRoomsSuccess(chatRoomsModel));
        },
      );
    } catch (e) {
      emit(GetChatRoomsError(e.toString()));
    }
  }

  Future<void> createPrivateRoom({required int userId}) async {
    log('tapped');
    emit(CreatePrivateRoomLoading());
    try {
      final result = await chatRoomsRepo.createPrivateRoom(userId: userId);
      result.fold(
        (failure) {
          emit(CreatePrivateRoomError(failure.errMessage));
        },
        (room) {
          this.createdRoom = room;
          emit(CreatePrivateRoomSuccess(room));
        },
      );
    } catch (e) {
      emit(CreatePrivateRoomError(e.toString()));
    }
  }
}
