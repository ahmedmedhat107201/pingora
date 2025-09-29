import 'package:flutter/material.dart';
import '../../../../core/shared/theme/app_theme.dart';
import 'widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: PopScope(canPop: false, child: SplashViewBody()),
    );
  }
}
