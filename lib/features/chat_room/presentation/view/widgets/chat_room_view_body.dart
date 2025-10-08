import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_cubits/chat_socket_cubit/chat_socket_cubit.dart';
import 'package:pingora/core/shared/shared_models/message_model.dart';
import 'package:pingora/core/shared/shared_widgets/custom_error_state.dart';
import 'package:pingora/core/shared/shared_widgets/custom_loading_indicator.dart';
import 'package:pingora/core/shared/shared_widgets/default_text_form_field.dart';
import 'package:pingora/core/shared/shared_widgets/empty_widget.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/utils/services/remote_services/endpoints.dart';
import 'package:pingora/features/chat_room/presentation/view/widgets/chat_bubble.dart';
import 'package:pingora/features/chat_room/presentation/view_model/chat_room_cubit.dart';

class ChatRoomViewBody extends StatefulWidget {
  final int roomId;
  ChatRoomViewBody({super.key, required this.roomId});

  @override
  State<ChatRoomViewBody> createState() => _ChatRoomViewBodyState();
}

class _ChatRoomViewBodyState extends State<ChatRoomViewBody> {
  late TextEditingController _messageController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();

    context.read<ChatRoomCubit>().getChatMessages(roomId: widget.roomId);

    //socket setup

    //join the room in the beginning
    context.read<ChatSocketCubit>().emitToSocket(
      data: {
        "event": EndPoints.joinRoom,
        "data": {"room_id": widget.roomId},
      },
    );

    //listen to new messages
    context.read<ChatSocketCubit>().listenToSocketEvent(
      onSuccess: (data) {
        data = jsonDecode(data.toString());

        log('data printed' + data.toString());
        //check if the event is message sent
        if (data['event'] == EndPoints.messageSent) {
          log('New message event received: ${data.toString()}');
          final messageData = data['data'];
          //extra check that this is the current room
          if (messageData != null && messageData['room_id'] == widget.roomId) {
            // Only add message if it belongs to the current room
            final message = MessageModel.fromJson(messageData);

            context.read<ChatRoomCubit>().addMessage(message);
            // Scroll to bottom when a new message is added
            _scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();

    //leave the room when disposing
    context.read<ChatSocketCubit>().emitToSocket(
      data: {
        "event": EndPoints.leaveRoom,
        "data": {"room_id": widget.roomId},
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomCubit, ChatRoomState>(
      builder: (context, state) {
        if (state is GetChatMessagesLoading) {
          return CustomLoadingIndicator.standard();
        } else if (state is GetChatMessagesError) {
          return CustomErrorState(errorMessage: state.errorMessage);
        } else {
          List<MessageModel> messages = [];
          messages = context
              .read<ChatRoomCubit>()
              .roomMessagesModel!
              .messages!
              .data!;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                messages.isEmpty
                    ? Expanded(
                        child: EmptyWidget(
                          title: 'No chat messages yet',
                          description: 'Start a conversation now',
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          reverse: true, // Show latest messages at bottom
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 12.h);
                          },
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return ChatBubble(
                              message: message.content!,
                              isMe: message.isMine!,
                              time: message.createdAt!,
                              isSeen: false,
                            );
                          },
                          itemCount: messages.length,
                        ),
                      ),

                SizedBox(height: 16.h),

                // Input Area
                DefaultTextFormField(
                  controller: _messageController,
                  maxLines: 1,
                  textInputAction: TextInputAction.send,
                  textInputType: TextInputType.text,
                  hintText: 'type_message'.tr(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: state is SendMessageLoading
                          ? context.greyColor
                          : context.primaryColor,
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        onPressed: state is SendMessageLoading
                            ? null
                            : () async {
                                if (_messageController.text.trim().isNotEmpty) {
                                  await context
                                      .read<ChatRoomCubit>()
                                      .sendMessage(
                                        roomId: widget.roomId,
                                        message: _messageController.text.trim(),
                                      );
                                  _messageController.clear();
                                  // Scroll to bottom after sending message
                                  _scrollController.animateTo(
                                    0.0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                }
                              },
                      ),
                    ),
                  ),
                  fillColor: context.inputBackgroundColor,
                  borderSideColor: context.borderColor,
                  borderSideEnabledColor: context.borderColor,
                  labelColorActive: context.primaryColor,
                  borderRadius: 20.r,
                  isFilled: true,
                  contentPaddingVertical: 24.h,
                  contentPaddingHorizontal: 16.w,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
