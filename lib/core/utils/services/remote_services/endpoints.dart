class EndPoints {
  static const baseUrl = 'https://b4a52e0ff466.ngrok-free.app/api/v1/';
  static const socketUrl = 'wss://7137d690fcda.ngrok-free.app';

  // auth endpoints
  static const login = 'auth/login';
  static const signUp = 'auth/register';
  static const logout = 'auth/logout';

  // profile endpoints
  static const getMe = "profile";

  // users
  static const getUsers = "users";

  // chat rooms endpoints
  static const getChatRooms = "chat/rooms";
  static const createPrivateRoom = "chat/rooms/private";
  static const createGroupRoom = "chat/rooms/group";

  // chat room endpoints
  static const sendMessage = "chat/messages";
  static const getRoomMessages = "chat/messages";

  //socket events
  static const joinRoom = "join-room";
  static const leaveRoom = "leave-room";

  static const joinedRoom = "joined-room";
  static const messageSent = "new-message";
}
