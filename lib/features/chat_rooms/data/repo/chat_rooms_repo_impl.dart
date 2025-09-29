import 'package:pingora/core/utils/services/remote_services/api_service.dart';
import 'package:pingora/features/chat_rooms/data/repo/chat_rooms_repo.dart';

class ChatRoomsRepoImpl implements ChatRoomsRepo {
  ApiService apiService;

  ChatRoomsRepoImpl(this.apiService);
}
