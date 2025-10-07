import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/custom_loading_indicator.dart';
import 'package:pingora/core/shared/shared_widgets/default_cached_network_image.dart';
import 'package:pingora/core/shared/shared_widgets/search_widget.dart';
import 'package:pingora/core/utils/colors/colors.dart';
import 'package:pingora/features/users/presentation/view_model/users_cubit.dart';

class UsersViewBody extends StatefulWidget {
  const UsersViewBody({super.key});

  @override
  State<UsersViewBody> createState() => _UsersViewBodyState();
}

class _UsersViewBodyState extends State<UsersViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().getAllUsers();
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is GetAllUsersLoading) {
          return CustomLoadingIndicator.standard();
        } else if (state is GetAllUsersError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Error: ${state.errorMessage}')),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  context.read<UsersCubit>().getAllUsers();
                },
                child: const Text('Retry'),
              ),
            ],
          );
        }
        return Container(
          padding: EdgeInsets.all(16.sp),
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<UsersCubit>().getAllUsers();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchWidget(searchController: searchController),

                SizedBox(height: 16.h),

                //users list
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12.h);
                    },
                    itemCount: context
                        .read<UsersCubit>()
                        .getUsersModel!
                        .users!
                        .data!
                        .length,
                    itemBuilder: (context, index) {
                      final user = context
                          .read<UsersCubit>()
                          .getUsersModel!
                          .users!
                          .data![index];

                      return UserTile(
                        userName: user.name,
                        email: user.email,
                        userImageUrl: user.profileImageUrl,
                        onTap: () {
                          log('Tapped on ${user.id}');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserTile extends StatelessWidget {
  final String? userName;
  final String? email;
  final String? userImageUrl;
  final VoidCallback? onTap;

  const UserTile({
    super.key,
    this.userName,
    this.email,
    this.userImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.1),
          width: 1.w,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 24.r,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              child: ClipOval(
                child: DefaultCachedNetworkImage(
                  imageUrl: userImageUrl! + 'sss',
                  imageWidth: 48.w,
                  imageHeight: 48.h,
                  fit: BoxFit.cover,
                  errorWidget: Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor.withValues(alpha: 0.7),
                    ),
                    child: Icon(Icons.person, size: 20.sp, color: Colors.white),
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // User Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName ?? 'Unknown User',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    email ?? 'user@email.com',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Chat Icon
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat,
                size: 18.sp,
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
