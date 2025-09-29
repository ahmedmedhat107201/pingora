import 'package:flutter/material.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/features/auth/presentation/view/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SignUpViewBody(),
    );
  }
}
