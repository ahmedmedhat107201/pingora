import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingora/features/chat_rooms/data/repo/chat_rooms_repo.dart';

part 'chat_rooms_state.dart';

class ChatRoomsCubit extends Cubit<ChatRoomsState> {
  ChatRoomsRepo chatRoomsRepo;
  ChatRoomsCubit(this.chatRoomsRepo) : super(ChatRoomsInitial());
}
