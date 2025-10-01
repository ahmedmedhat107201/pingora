import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/utils/helper/date_time_format.dart';

class ChatBubble extends StatefulWidget {
  final bool isMe;
  final String message;
  final String time;
  final bool isSeen;
  const ChatBubble({
    super.key,
    required this.isMe,
    required this.message,
    required this.time,
    required this.isSeen,
  });

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
          child: Column(
            crossAxisAlignment: widget.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MainText(
                    widget.message,
                    fontSize: 14.sp,
                    color: context.defaultTextColor,
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  MainText(
                    DateTimeFormat.fromTimeFormat(widget.time),
                    fontSize: 10.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  SizedBox(width: 4.w),
                  if (widget.isMe && widget.isSeen)
                    Icon(
                      Icons.done_all,
                      size: 16.sp,
                      color: Colors.white.withValues(alpha: 0.7),
                    )
                  else
                    SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
