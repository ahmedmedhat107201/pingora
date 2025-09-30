import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/default_cached_network_image.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';

class ChatRoomsTile extends StatelessWidget {
  final String image;
  final String name;
  final String lastMessage;
  final String time;
  final int? unreadCount;
  final VoidCallback? onTap;

  ChatRoomsTile({
    required this.image,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: context.secondaryColor.withValues(alpha: 0.1),
              blurRadius: 6.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Avatar with Secondary Color Ring
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    context.secondaryColor.withValues(alpha: 0.3),
                    context.primaryColor.withValues(alpha: 0.2),
                  ],
                ),
              ),
              child: CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: DefaultCachedNetworkImage(
                    imageUrl: image,
                    imageHeight: 48.h,
                    imageWidth: 48.w,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Chat Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    name,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: context.primaryTextColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  MainText(
                    lastMessage,
                    fontSize: 14.sp,
                    color: context.secondaryTextColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Timestamp with Secondary Color - Constrained width
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 50.w, maxWidth: 100.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MainText(
                    time,
                    fontSize: 12.sp,
                    color: context.secondaryColor,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(height: 4.h),
                  // Unread message indicator
                  if (unreadCount != null && unreadCount! > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.secondaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: MainText(
                        unreadCount.toString(),
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
