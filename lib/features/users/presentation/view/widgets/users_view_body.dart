import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/custom_error_state.dart';
import 'package:pingora/core/shared/shared_widgets/custom_loading_indicator.dart';
import 'package:pingora/core/shared/shared_widgets/search_widget.dart';
import 'package:pingora/core/shared/shared_widgets/toast.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/chat_room/presentation/view/chat_room_view.dart';
import 'package:pingora/features/chat_rooms/presentation/view_model/chat_rooms_cubit.dart';
import 'package:pingora/features/users/presentation/view/widgets/user_tile.dart';
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
          return CustomErrorState(
            errorMessage: state.errorMessage,
            onRetry: () async {
              await context.read<UsersCubit>().getAllUsers();
            },
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
                  child: BlocListener<ChatRoomsCubit, ChatRoomsState>(
                    listener: (context, state) {
                      if (state is CreatePrivateRoomLoading) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              CreationLoadingDialog(canPop: true),
                        );
                      } else if (state is CreatePrivateRoomError) {
                        MagicRouter.pop();
                        toast(text: state.errorMessage, color: Colors.red);
                      } else {
                        final room = context
                            .read<ChatRoomsCubit>()
                            .createdRoom!;
                        MagicRouter.pop();
                        MagicRouter.navigateTo(
                          ChatRoomView(
                            roomId: room.id!,
                            userName: room.displayName!,
                            userImage: room.coverImageUrl!,
                          ),
                        );
                      }
                    },
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
                          onTap: () async {
                            await context
                                .read<ChatRoomsCubit>()
                                .createPrivateRoom(userId: user.id!);
                          },
                        );
                      },
                    ),
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

class CreationLoadingDialog extends StatelessWidget {
  final bool canPop;
  CreationLoadingDialog({super.key, this.canPop = true});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: this.canPop,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(30.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: CustomLoadingIndicator.standard(
                  type: LoadingType.wanderingCubes,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
