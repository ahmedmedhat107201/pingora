import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    } catch (e) {}
  }
}
