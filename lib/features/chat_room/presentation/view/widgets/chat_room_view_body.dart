import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';

class ChatRoomViewBody extends StatefulWidget {
  const ChatRoomViewBody({super.key});

  @override
  State<ChatRoomViewBody> createState() => _ChatRoomViewBodyState();
}

class _ChatRoomViewBodyState extends State<ChatRoomViewBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 12.h);
        },
        itemBuilder: (context, index) {
          return ChatBubble();
        },
        itemCount: 16,
      ),
    );
  }
}

class ChatBubble extends StatefulWidget {
  final bool isMe;
  const ChatBubble({super.key, this.isMe = true});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: widget.isMe
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: widget.isMe ? context.primaryColor : context.secondaryColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: context.secondaryColor.withValues(alpha: 0.1),
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Row(
            children: [
              MainText(
                'message number 1',
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
