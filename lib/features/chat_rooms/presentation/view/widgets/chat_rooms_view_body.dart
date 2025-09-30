import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/custom_tab_bar.dart';
import 'package:pingora/core/utils/helper/date_time_format.dart';
import 'package:pingora/features/chat_rooms/presentation/view/widgets/chat_rooms_tile.dart';

class ChatRoomsViewBody extends StatefulWidget {
  const ChatRoomsViewBody({super.key});

  @override
  State<ChatRoomsViewBody> createState() => _ChatRoomsViewBodyState();
}

class _ChatRoomsViewBodyState extends State<ChatRoomsViewBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Reusable Custom TabBar
        CustomTabBar(
          tabController: tabController,
          tabTitles: ['Messages', 'Groups'],
          onTap: (index) {
            // Handle tab tap if needed
            print('Tab $index tapped');
          },
        ),

        // TabBarView
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              // Messages Tab
              _buildMessagesTab(),
              // Groups Tab
              _buildGroupsTab(),
            ],
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  // Messages Tab Content
  Widget _buildMessagesTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 8.h);
        },
        itemBuilder: (context, index) {
          return ChatRoomsTile(
            name: 'Ahmed Medhat',
            image:
                'https://scontent.fcai20-2.fna.fbcdn.net/v/t39.30808-6/360096021_2195519360784561_7327906850771618380_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wlBJoKNDzqgQ7kNvwHIjTDo&_nc_oc=AdkJkoX_hCdYcC_09UzDItHH_TO-Mg4cT5RlJVvX-a6FE0yN9nbjtp1t8DDLU6zd_Tw&_nc_zt=23&_nc_ht=scontent.fcai20-2.fna&_nc_gid=_4WotFg7cBJAA1q0chl2tg&oh=00_AfYmxDgKiJF1SZwBBbdMP0_ja8q-h_3sEh2TbpzIMtLHfw&oe=68E16C84',
            lastMessage: 'Hey! How are you?',
            time: DateTimeFormat.fromTimeFormat(
              DateTime.now().subtract(Duration(minutes: 120)).toString(),
            ),
            unreadCount: 3,
          );
        },
        itemCount: 10,
      ),
    );
  }

  // Groups Tab Content
  Widget _buildGroupsTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 8.h);
        },
        itemBuilder: (context, index) {
          return ChatRoomsTile(
            name: 'Flutter Developers',
            image:
                'https://scontent.fcai20-2.fna.fbcdn.net/v/t39.30808-6/360096021_2195519360784561_7327906850771618380_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wlBJoKNDzqgQ7kNvwHIjTDo&_nc_oc=AdkJkoX_hCdYcC_09UzDItHH_TO-Mg4cT5RlJVvX-a6FE0yN9nbjtp1t8DDLU6zd_Tw&_nc_zt=23&_nc_ht=scontent.fcai20-2.fna&_nc_gid=_4WotFg7cBJAA1q0chl2tg&oh=00_AfYmxDgKiJF1SZwBBbdMP0_ja8q-h_3sEh2TbpzIMtLHfw&oe=68E16C84',
            lastMessage: 'John: Thanks for sharing!',
            time: '1:45 PM',
          );
        },
        itemCount: 5,
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
