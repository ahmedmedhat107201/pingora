import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/custom_loading_indicator.dart';
import 'package:pingora/core/shared/shared_widgets/custom_tab_bar.dart';
import 'package:pingora/core/utils/helper/date_time_format.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/chat_rooms/presentation/view/chat_room_view.dart';
import 'package:pingora/features/chat_rooms/presentation/view/widgets/chat_rooms_tile.dart';
import 'package:pingora/features/profile/presentation/view_model/profile_cubit.dart';

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

    context.read<ProfileCubit>().getMe();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is GetMeLoading) {
          return CustomLoadingIndicator.standard();
        } else if (state is GetMeFailure) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Error: ${state.errorMessage}')),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  context.read<ProfileCubit>().getMe();
                },
                child: const Text('Retry'),
              ),
            ],
          );
        }
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

            SizedBox(height: 8.h),
            // TabBarView
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  // Messages Tab
                  RefreshIndicator(
                    child: _buildMessagesTab(),
                    onRefresh: () async {
                      await context.read<ProfileCubit>().getMe();
                    },
                  ),
                  // Groups Tab
                  RefreshIndicator(
                    child: _buildGroupsTab(),
                    onRefresh: () async {
                      await context.read<ProfileCubit>().getMe();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
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
            name: 'Emma Stone',
            image:
                'https://www.thedailybeast.com/resizer/v2/2SDWTBRDEVLHBKBMUFHETDWIRY.jpg?smart=true&auth=fac58285da0f39cc8d1086baa9e6261a8b74412c9b5e7503be36feaa56414d56&width=1200&height=675',
            lastMessage: 'Hey! How are you?',
            time: DateTimeFormat.fromTimeFormat(
              DateTime.now().subtract(Duration(minutes: 120)).toString(),
            ),
            unreadCount: 3,
            onTap: () {
              final me = context.read<ProfileCubit>().getMeModel!.user!;

              log(me.id!.toString());
              log(me.name!);
              log(me.email!);
              log(me.profileImageUrl!);

              MagicRouter.navigateTo(
                ChatRoomView(
                  userName: 'Emma Stone',
                  userImage:
                      'https://www.thedailybeast.com/resizer/v2/2SDWTBRDEVLHBKBMUFHETDWIRY.jpg?smart=true&auth=fac58285da0f39cc8d1086baa9e6261a8b74412c9b5e7503be36feaa56414d56&width=1200&height=675',
                ),
              );
            },
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
            name: 'Emma Stone',
            image:
                'https://www.thedailybeast.com/resizer/v2/2SDWTBRDEVLHBKBMUFHETDWIRY.jpg?smart=true&auth=fac58285da0f39cc8d1086baa9e6261a8b74412c9b5e7503be36feaa56414d56&width=1200&height=675',
            lastMessage: 'John: Thanks for sharing!',
            time: '1:45 PM',
            onTap: () {
              MagicRouter.navigateTo(
                ChatRoomView(
                  userName: 'Emma Stone',
                  userImage:
                      'https://www.thedailybeast.com/resizer/v2/2SDWTBRDEVLHBKBMUFHETDWIRY.jpg?smart=true&auth=fac58285da0f39cc8d1086baa9e6261a8b74412c9b5e7503be36feaa56414d56&width=1200&height=675',
                ),
              );
            },
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
