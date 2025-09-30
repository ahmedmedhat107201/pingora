import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/default_cached_network_image.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/chat_rooms/presentation/view/chat_rooms_view.dart';

class ChatRoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userImageUrl;
  final String? lastSeen;
  final bool isOnline;
  final bool showLastSeen;
  final VoidCallback? onBackPressed;
  ChatRoomAppBar({
    Key? key,
    required this.userName,
    required this.userImageUrl,
    this.lastSeen,
    this.isOnline = false,
    this.showLastSeen = true,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.primaryColor,
            context.primaryColor.withValues(alpha: 0.9),
            context.secondaryColor.withValues(alpha: 0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.2),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              // Back Button
              GestureDetector(
                onTap:
                    onBackPressed ??
                    () {
                      if (MagicRouter.canPop) {
                        MagicRouter.pop();
                      } else {
                        MagicRouter.navigateAndPopAll(ChatRoomsView());
                      }
                    },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),

              SizedBox(width: 6.w),

              // User Profile Section
              Expanded(
                child: Row(
                  children: [
                    // User Avatar with Online Status
                    Stack(
                      children: [
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
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.3,
                            ),
                            child: ClipOval(
                              child: DefaultCachedNetworkImage(
                                imageUrl: userImageUrl,
                                imageWidth: 48.w,
                                imageHeight: 48.h,
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
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Online Status Indicator
                        if (isOnline)
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(width: 12.w),

                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // User Name
                          MainText(
                            userName,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          // Online Status or Last Seen
                          if (showLastSeen)
                            MainText(
                              isOnline
                                  ? 'Online'
                                  : (lastSeen ?? 'Last seen recently'),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.8),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}
