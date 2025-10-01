import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/default_text_form_field.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/features/chat_room/data/models/message_model.dart';
import 'package:pingora/features/chat_room/presentation/view/widgets/chat_bubble.dart';

class ChatRoomViewBody extends StatefulWidget {
  const ChatRoomViewBody({super.key});

  @override
  State<ChatRoomViewBody> createState() => _ChatRoomViewBodyState();
}

class _ChatRoomViewBodyState extends State<ChatRoomViewBody> {
  late TextEditingController _messageController;
  late ScrollController _scrollController;
  List<MessageModel> messages = [
    MessageModel(
      message: 'Hello!',
      isMe: false,
      time: DateTime.now().subtract(Duration(minutes: 5)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'Hi there!',
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 10)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'How are you?',
      isMe: false,
      time: DateTime.now().subtract(Duration(minutes: 15)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'I am good, thanks!',
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 20)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'What about you?',
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 25)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'Doing well, thank you!',
      isMe: false,
      time: DateTime.now().subtract(Duration(minutes: 30)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'Great to hear!',
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 35)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'What are you up to?',
      isMe: false,
      time: DateTime.now().subtract(Duration(minutes: 40)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'Just working on a project.',
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 45)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'Sounds interesting!',
      isMe: false,
      time: DateTime.now().subtract(Duration(minutes: 50)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'Yes, it is quite fun.',
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 55)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'Good luck with it!',
      isMe: false,
      time: DateTime.now().subtract(Duration(minutes: 60)).toString(),
      isSeen: true,
    ),
    MessageModel(
      message: 'Thank you!',
      isMe: true,
      time: DateTime.now().subtract(Duration(minutes: 65)).toString(),
      isSeen: false,
    ),
  ];

  void addMessage(String message, bool isMe) {
    setState(() {
      messages.insert(
        0,
        MessageModel(
          message: message,
          isMe: isMe,
          time: DateTime.now().toString(),
          isSeen: false,
        ),
      );
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      addMessage(_messageController.text.trim(), true);
      _messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              reverse: true, // Show latest messages at bottom
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.h);
              },
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(
                  message: message.message,
                  isMe: message.isMe,
                  time: message.time,
                  isSeen: message.isSeen,
                );
              },
              itemCount: messages.length,
            ),
          ),

          SizedBox(height: 16.h),

          // Input Area
          DefaultTextFormField(
            controller: _messageController,
            textInputType: TextInputType.text,
            hintText: 'type_message'.tr(),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: context.primaryColor,
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white, size: 20.sp),
                  onPressed: _sendMessage,
                ),
              ),
            ),
            fillColor: context.inputBackgroundColor,
            borderSideColor: context.borderColor,
            borderSideEnabledColor: context.borderColor,
            labelColorActive: context.primaryColor,
            borderRadius: 20.r,
            isFilled: true,
            textInputAction: TextInputAction.send,
            contentPaddingVertical: 24.h,
            contentPaddingHorizontal: 16.w,
            onFilledSubmit: (_) => _sendMessage(),
          ),
        ],
      ),
    );
  }
}
