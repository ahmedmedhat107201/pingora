import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/default_cached_network_image.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';

class CustomPingoraAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String userName;
  final String? userImageUrl;
  final VoidCallback? onUserTap;
  final double? height;
  final bool showShadow;
  final List<Widget>? actions;
  final bool hasBackButton;

  const CustomPingoraAppBar({
    Key? key,
    required this.userName,
    this.userImageUrl,
    this.onUserTap,
    this.height,
    this.showShadow = true,
    this.actions,
    this.hasBackButton = false,
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
            context.primaryColor.withValues(alpha: 0.8),
            context.secondaryColor.withValues(alpha: 0.6),
          ],
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: context.primaryColor.withValues(alpha: 0.3),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Row(
            children: [
              // User Profile Section
              Expanded(
                child: GestureDetector(
                  onTap: onUserTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (hasBackButton)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(width: 12.w),
                          ],
                        ),

                      // User Avatar with Glow Effect
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.3),
                              Colors.white.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                        child: DefaultCachedNetworkImage(
                          imageUrl: userImageUrl!,
                          imageHeight: 24.h,
                          imageWidth: 24.w,
                          errorWidget: Icon(
                            Icons.person,
                            size: 24.sp,
                            color: context.primaryColor,
                          ),
                        ),
                      ),

                      SizedBox(width: 16.w),

                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Greeting Text
                            MainText(
                              'hello'.tr(),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                            SizedBox(height: 2.h),
                            // User Name
                            MainText(
                              userName,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Actions
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 100.h);
}
