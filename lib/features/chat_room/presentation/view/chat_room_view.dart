import 'package:flutter/material.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/features/chat_room/presentation/view/widgets/chat_room_view_body.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: ChatRoomViewBody(),
    );
  }
}
