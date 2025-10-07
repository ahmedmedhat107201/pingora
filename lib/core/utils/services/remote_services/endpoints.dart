class EndPoints {
  static const baseUrl = 'https://fe76859f44e6.ngrok-free.app/api/v1/';

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
}
