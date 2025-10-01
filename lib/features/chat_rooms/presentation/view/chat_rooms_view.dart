import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pingora/core/shared/shared_widgets/toast.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/shared/shared_widgets/custom_pingora_app_bar.dart';
import 'package:pingora/core/shared/shared_widgets/custom_loading_dialog.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:pingora/features/auth/presentation/view/login_view.dart';
import 'package:pingora/features/chat_rooms/presentation/view/widgets/chat_rooms_view_body.dart';

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
          Navigator.of(context).popUntil((route) => route.isFirst);
          toast(text: 'logout successfully', color: context.secondaryColor);
          MagicRouter.navigateAndPopAll(LoginView());
        } else if (state is LogoutFailure) {
          // Close loading dialog if open
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
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
              userName: 'Ahmed Medhat',
              userImageUrl:
                  'https://scontent.fcai20-2.fna.fbcdn.net/v/t39.30808-6/360096021_2195519360784561_7327906850771618380_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wlBJoKNDzqgQ7kNvwHIjTDo&_nc_oc=AdkJkoX_hCdYcC_09UzDItHH_TO-Mg4cT5RlJVvX-a6FE0yN9nbjtp1t8DDLU6zd_Tw&_nc_zt=23&_nc_ht=scontent.fcai20-2.fna&_nc_gid=_4WotFg7cBJAA1q0chl2tg&oh=00_AfYmxDgKiJF1SZwBBbdMP0_ja8q-h_3sEh2TbpzIMtLHfw&oe=68E16C84',
              onUserTap: state is LogoutLoading
                  ? null
                  : () {
                      _showLogoutDialog(context);
                    },
            ),
            body: ChatRoomsViewBody(),
          );
        },
      ),
    );
  }
}
