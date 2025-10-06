import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingora/features/chat_room/data/repo/chat_room_repo.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomRepo chatRoomRepo;
  ChatRoomCubit(this.chatRoomRepo) : super(ChatRoomInitial());
}
