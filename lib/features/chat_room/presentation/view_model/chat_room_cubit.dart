import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingora/core/shared/shared_cubits/chat_socket_cubit/chat_socket_cubit.dart';
import 'package:pingora/core/shared/shared_models/message_model.dart';
import 'package:pingora/core/utils/services/remote_services/endpoints.dart';
import 'package:pingora/features/chat_room/data/models/get_room_messages_models.dart';
import 'package:pingora/features/chat_room/data/repo/chat_room_repo.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomRepo chatRoomRepo;
  ChatRoomCubit(this.chatRoomRepo) : super(ChatRoomInitial());

  GetRoomMessagesModel? roomMessagesModel;

  Future<void> getChatMessages({required int roomId}) async {
    try {
      emit(GetChatMessagesLoading());
      var result = await chatRoomRepo.getChatMessages(roomId: roomId);
      result.fold(
        (failure) {
          emit(GetChatMessagesError(failure.errMessage));
        },
        (getMessagesModel) {
          this.roomMessagesModel = getMessagesModel;
          emit(GetChatMessagesSuccess(getMessagesModel));
        },
      );
    } catch (e) {
      emit(GetChatMessagesError(e.toString()));
    }
  }

  Future<void> sendMessage({
    required int roomId,
    required String message,
  }) async {
    try {
      emit(SendMessageLoading());
      var result = await chatRoomRepo.sendMessage(
        roomId: roomId,
        message: message,
      );
      result.fold(
        (failure) {
          emit(SendMessageError(failure.errMessage));
        },
        (statusCode) {
          emit(SendMessageSuccess(statusCode));
          // getChatMessages(roomId: roomId);
        },
      );
    } catch (e) {
      emit(SendMessageError(e.toString()));
    }
  }

  //add the message into the messages list returned in the room
  void addMessage(MessageModel message) {
    if (roomMessagesModel != null) {
      roomMessagesModel!.messages!.data!.insert(0, message);
      emit(GetChatMessagesSuccess(roomMessagesModel!));
    }
  }

  void joinChatRoom({required BuildContext context, required int roomId}) {
    context.read<ChatSocketCubit>().emitToSocket(
      data: {
        "event": EndPoints.joinRoom,
        "data": {"room_id": roomId},
      },
    );
  }

  void listenToMessages({
    required BuildContext context,
    required int roomId,
    Function? onMessageReceived,
  }) {
    context.read<ChatSocketCubit>().listenToSocketEvent(
      onSuccess: (data) {
        log('data printed' + data.toString());
        //check if the event is message sent
        if (data['event'] == EndPoints.messageSent) {
          log('New message event received: ${data.toString()}');
          final messageData = data['data'];
          //extra check that this is the current room
          if (messageData != null && messageData['room_id'] == roomId) {
            // Only add message if it belongs to the current room
            final message = MessageModel.fromJson(messageData);

            addMessage(message);

            // callback to call in the ui when message received
            if (onMessageReceived != null) {
              onMessageReceived();
            }
          }
        }
      },
    );
  }
}
