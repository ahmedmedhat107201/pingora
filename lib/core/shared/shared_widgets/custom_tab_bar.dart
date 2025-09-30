import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabTitles;
  final EdgeInsets? margin;
  final double? height;
  final double? borderRadius;
  final Function(int)? onTap;

  const CustomTabBar({
    Key? key,
    required this.tabController,
    required this.tabTitles,
    this.margin,
    this.height,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.surfaceColor,
            context.secondaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
        border: Border.all(
          color: context.secondaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: context.secondaryColor.withValues(alpha: 0.1),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        onTap: onTap,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
          gradient: LinearGradient(
            colors: [
              context.primaryColor,
              context.secondaryColor.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withValues(alpha: 0.3),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: context.secondaryColor,
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        tabs: tabTitles
            .map((title) => Tab(text: title, height: height ?? 40.h))
            .toList(),
      ),
    );
  }
}
