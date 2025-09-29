import 'package:flutter/material.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/shared/shared_widgets/user_profile_app_bar.dart';
import 'package:pingora/features/chat_rooms/presentation/view/widgets/chat_rooms_view_body.dart';

class ChatRoomsView extends StatelessWidget {
  const ChatRoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: UserProfileAppBar(
        userName: 'Ahmed Medhat', // You can make this dynamic
        userImageUrl: 'ss', // Add user image URL when available
        onUserTap: () {
          // Handle user profile tap
          print('User profile tapped');
        },
      ),
      body: ChatRoomsViewBody(),
    );
  }
}
