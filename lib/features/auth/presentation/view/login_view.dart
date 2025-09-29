import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingora/core/shared/shared_widgets/exit_confirmation_dialog.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/features/auth/presentation/view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: PopScope(
        canPop: false, // Prevent default pop behavior
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (!didPop) {
            // Show exit confirmation dialog
            final shouldExit = await showExitConfirmationDialog(context);
            if (shouldExit == true) {
              // Exit the app
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            }
          }
        },
        child: LoginViewBody(),
      ),
    );
  }
}
