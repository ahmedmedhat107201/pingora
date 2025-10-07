import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/custom_error_state.dart';
import 'package:pingora/core/shared/shared_widgets/custom_loading_indicator.dart';
import 'package:pingora/core/shared/shared_widgets/custom_tab_bar.dart';
import 'package:pingora/core/shared/shared_widgets/empty_widget.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';
import 'package:pingora/core/utils/helper/date_time_format.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/chat_room/presentation/view/chat_room_view.dart';
import 'package:pingora/features/chat_rooms/presentation/view/widgets/chat_rooms_tile.dart';
import 'package:pingora/features/chat_rooms/presentation/view_model/chat_rooms_cubit.dart';
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
    context.read<ChatRoomsCubit>().getChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is GetMeLoading) {
          return CustomLoadingIndicator.standard();
        } else if (state is GetMeError) {
          return CustomErrorState(errorMessage: state.errorMessage);
        }
        return Column(
          children: [
            // Reusable Custom TabBar
            CustomTabBar(
              tabController: tabController,
              tabTitles: ['Messages', 'Groups'],
              onTap: (index) async {
                if (index == 0) {
                  await context.read<ChatRoomsCubit>().getChatRooms();
                } else if (index == 1) {
                  log('group tabbed');
                }
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
                      await context.read<ChatRoomsCubit>().getChatRooms();
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
    return BlocBuilder<ChatRoomsCubit, ChatRoomsState>(
      builder: (context, state) {
        if (state is GetChatRoomsLoading) {
          return CustomLoadingIndicator.standard();
        } else if (state is GetChatRoomsError) {
          return CustomErrorState(
            errorMessage: state.errorMessage,
            onRetry: () async {
              await context.read<ChatRoomsCubit>().getChatRooms();
            },
          );
        } else {
          final rooms = context
              .read<ChatRoomsCubit>()
              .chatRoomsModel!
              .rooms!
              .data!;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView.separated(
              itemCount: rooms.length,

              separatorBuilder: (context, index) {
                return SizedBox(height: 8.h);
              },
              itemBuilder: (context, index) {
                if (rooms.isEmpty) {
                  return EmptyWidget(
                    title: 'no rooms now',
                    description: 'you need to start a chat',
                  );
                }

                final room = rooms[index];

                return ChatRoomsTile(
                  name: room.displayName!,
                  image: room.coverImageUrl!,
                  lastMessage: room.lastMessage == null
                      ? 'start_new_chat'.tr()
                      : room.lastMessage!.content!,
                  time: room.lastMessage == null
                      ? null
                      : DateTimeFormat.fromTimeFormat(
                          room.lastMessage!.createdAt!,
                        ),
                  onTap: () {
                    MagicRouter.navigateTo(
                      ChatRoomView(
                        roomId: room.id!,
                        userName: room.displayName!,
                        userImage: room.coverImageUrl!,
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
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
          return Center(
            child: MainText(
              'Groups feature coming soon!',
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          );
        },
        itemCount: 1,
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
