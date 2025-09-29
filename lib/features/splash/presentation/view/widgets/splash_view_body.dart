import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/auth/presentation/view/login_view.dart';
import '../../../../../core/shared/theme/app_theme.dart';
import '../../../../../core/utils/assets/assets.dart';
import '../../../../../core/utils/text_styles/styles.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    setUpSplash().then((value) => MagicRouter.navigateTo(LoginView()));
  }

  setUpSplash() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.primaryColor,
            context.primaryColor.withValues(alpha: 0.8),
            context.secondaryColor,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(AssetData.appLogo, fit: BoxFit.contain),

              SizedBox(height: 40.h),

              // Subtitle
              Text(
                'welcome_to'.tr(),
                style: Styles.cairo14500White(context).copyWith(
                  fontSize: 16.sp,
                  color: Colors.white.withValues(alpha: 0.9),
                  letterSpacing: 1.0.w,
                ),
              ),

              SizedBox(height: 10.h),

              // App Name
              Text(
                'app_name'.tr(),
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 2.0.w,
                  fontFamily: 'Cairo',
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      offset: Offset(0, 2.h),
                      blurRadius: 4.r,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Welcome Message
              Text(
                'splash_welcome_message'.tr(),
                textAlign: TextAlign.center,
                style: Styles.cairo12500White(context).copyWith(
                  fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                  letterSpacing: 0.5.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
