import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingora/core/shared/shared_widgets/exit_confirmation_dialog.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/features/auth/presentation/view/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
        child: SignUpViewBody(),
      ),
    );
  }
}
