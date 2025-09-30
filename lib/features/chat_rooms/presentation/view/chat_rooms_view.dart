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
        userImageUrl:
            'https://scontent.fcai20-2.fna.fbcdn.net/v/t39.30808-6/360096021_2195519360784561_7327906850771618380_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wlBJoKNDzqgQ7kNvwHIjTDo&_nc_oc=AdkJkoX_hCdYcC_09UzDItHH_TO-Mg4cT5RlJVvX-a6FE0yN9nbjtp1t8DDLU6zd_Tw&_nc_zt=23&_nc_ht=scontent.fcai20-2.fna&_nc_gid=_4WotFg7cBJAA1q0chl2tg&oh=00_AfYmxDgKiJF1SZwBBbdMP0_ja8q-h_3sEh2TbpzIMtLHfw&oe=68E16C84',
        onUserTap: () {
          print('User profile tapped');
        },
      ),
      body: ChatRoomsViewBody(),
    );
  }
}
