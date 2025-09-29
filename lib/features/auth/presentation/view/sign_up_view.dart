import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingora/core/shared/shared_widgets/exit_confirmation_dialog.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/utils/services/remote_services/service_locator.dart';
import 'package:pingora/features/auth/data/repo/auth_repo.dart';
import 'package:pingora/features/auth/presentation/view/widgets/sign_up_view_body.dart';
import 'package:pingora/features/auth/presentation/view_model/auth_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt<AuthRepo>()),
      child: Scaffold(
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
      ),
    );
  }
}
