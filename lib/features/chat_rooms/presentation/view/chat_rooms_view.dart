import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/toast.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/shared/shared_widgets/custom_pingora_app_bar.dart';
import 'package:pingora/core/shared/shared_widgets/custom_loading_dialog.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:pingora/features/auth/presentation/view/login_view.dart';
import 'package:pingora/features/chat_rooms/presentation/view/widgets/chat_rooms_view_body.dart';
import 'package:pingora/features/users/presentation/view/users_view.dart';

class ChatRoomsView extends StatelessWidget {
  const ChatRoomsView({super.key});

  void _showLogoutDialog(BuildContext context) {
    CustomLoadingDialog.show(
      context: context,
      title: 'logout'.tr(),
      description: 'logout_confirm_message'.tr(),
      okTitle: 'logout'.tr(),
      cancelTitle: 'cancel'.tr(),
      loadingTitle: 'logout_loading'.tr(),
      loadingMessage: 'logging_out_please_wait'.tr(),
      okButtonColor: Colors.red,
      okTextColor: Colors.white,
      showCancelButton: true,
      canPop: true,
      onConfirm: () async {
        // Call the logout function from auth cubit
        await context.read<AuthCubit>().logout();
      },
      onCancel: () {
        MagicRouter.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          // Close any open dialogs first
          toast(text: 'logout successfully', color: context.secondaryColor);

          MagicRouter.navigateAndPopAll(LoginView());
        } else if (state is LogoutError) {
          // Close loading dialog if open
          if (MagicRouter.canPop) {
            MagicRouter.pop();
          }

          // Show error dialog
          toast(text: state.errorMessage, color: Colors.red);
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.backgroundColor,
            appBar: CustomPingoraAppBar(
              onUserTap: state is LogoutLoading
                  ? null
                  : () {
                      _showLogoutDialog(context);
                    },
            ),
            body: ChatRoomsViewBody(),

            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: FloatingActionButton(
                onPressed: () {
                  MagicRouter.navigateTo(UsersView());
                },
                tooltip: 'start_new_chat'.tr(),
                backgroundColor: context.primaryColor,
                child: Icon(Icons.chat, color: Colors.white, size: 24.sp),
              ),
            ),
          );
        },
      ),
    );
  }
}
