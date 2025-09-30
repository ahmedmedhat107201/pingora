import 'package:flutter/material.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/features/chat_room/presentation/view/widgets/chat_room_view_body.dart';
import 'package:pingora/features/chat_rooms/presentation/view/widgets/chat_room_app_bar.dart';

class ChatRoomView extends StatelessWidget {
  final String userName;
  final String userImage;

  const ChatRoomView({
    Key? key,
    required this.userName,
    required this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: ChatRoomAppBar(
        userName: userName,
        userImageUrl: userImage,
        isOnline: true,
      ),
      body: ChatRoomViewBody(),
    );
  }
}
