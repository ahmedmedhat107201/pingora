import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/custom_loading_indicator.dart';
import 'package:pingora/core/shared/shared_widgets/search_widget.dart';
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
          return CustomLoadingWidgetIndicator.overlay(
            type: LoadingType.wanderingCubes,
            size: 80.h,
            message: 'Loading users...',
          );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchWidget(searchController: searchController),

              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }
}
