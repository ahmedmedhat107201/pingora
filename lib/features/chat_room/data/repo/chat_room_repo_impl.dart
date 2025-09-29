import 'package:pingora/core/utils/services/remote_services/api_service.dart';
import 'package:pingora/features/chat_room/data/repo/chat_room_repo.dart';

class ChatRoomRepoImpl implements ChatRoomRepo {
  ApiService apiService;

  ChatRoomRepoImpl(this.apiService);
}
