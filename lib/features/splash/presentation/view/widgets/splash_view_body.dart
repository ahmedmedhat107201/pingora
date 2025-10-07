import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/core/utils/services/local_services/cache_keys.dart';
import 'package:pingora/features/auth/presentation/view/login_view.dart';
import 'package:pingora/features/chat_rooms/presentation/view/chat_rooms_view.dart';
import 'package:pingora/features/profile/presentation/view_model/profile_cubit.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setUpSplash();
    });
  }

  setUpSplash() async {
    // Wait for the widget tree to be fully built before navigation
    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted) return;

    if (CacheKeysManger.getAccessToken() != '') {
      final cubit = context.read<ProfileCubit>();

      await cubit.getMe();

      if (!mounted) return;

      if (cubit.state is GetMeSuccess) {
        if (mounted) {
          MagicRouter.navigateAndPopAll(ChatRoomsView());
        }
        return;
      } else if (cubit.state is GetMeError) {
        CacheKeysManger.saveAccessTokenToCache('');
        if (mounted) {
          MagicRouter.navigateAndPopAll(LoginView());
        }
        return;
      }
    } else {
      MagicRouter.navigateAndPopAll(LoginView());
      return;
    }

    if (mounted) {
      MagicRouter.navigateAndPopAll(LoginView());
      return;
    }
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
