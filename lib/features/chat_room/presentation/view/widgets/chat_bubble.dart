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
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width *
              0.75, // Max 75% of screen width
          minWidth: 50.w,
        ),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: widget.isMe ? context.primaryColor : context.secondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft: widget.isMe
                ? Radius.circular(12.r)
                : Radius.circular(0.r),
            bottomRight: widget.isMe
                ? Radius.circular(0.r)
                : Radius.circular(12.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: widget.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: MainText(
                widget.message,
                fontSize: 14.sp,
                color: context.defaultTextColor,
                maxLines: null, // Allow unlimited lines
                overflow: TextOverflow.visible, // Don't clip text
                textAlign: widget.isMe ? TextAlign.right : TextAlign.left,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainText(
                  DateTimeFormat.fromTimeFormat(widget.time),
                  fontSize: 10.sp,
                  color: Colors.white.withValues(alpha: 0.7),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.isMe && widget.isSeen) ...[
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.done_all,
                    size: 16.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
