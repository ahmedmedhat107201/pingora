import 'package:flutter/material.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/shared/shared_widgets/custom_pingora_app_bar.dart';
import 'package:pingora/features/chat_rooms/presentation/view/widgets/chat_rooms_view_body.dart';

class ChatRoomsView extends StatelessWidget {
  const ChatRoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: CustomPingoraAppBar(
        userName: 'Ahmed Medhat',
        userImageUrl: 'ss',
        onUserTap: () {
          print('User profile tapped');
        },
      ),
      body: ChatRoomsViewBody(),
    );
  }
}
