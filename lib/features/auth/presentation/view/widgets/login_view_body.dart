import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pingora/core/utils/helper/field_formatters.dart';
import '../../../../../core/shared/theme/app_theme.dart';
import '../../../../../core/shared/shared_widgets/default_text_form_field.dart';
import '../../../../../core/shared/shared_widgets/custom_button.dart';
import '../../../../../core/utils/text_styles/styles.dart';
import '../../../../../core/utils/assets/assets.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        // Handle login logic here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful!'),
            backgroundColor: context.activeGreen,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [context.backgroundColor, context.surfaceColor],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60.h),

                Image.asset(AssetData.appLogo, fit: BoxFit.contain),

                SizedBox(height: 24.h),

                // Welcome Text
                Text(
                  'login'.tr(),
                  style: Styles.cairo36700Secondary(
                    context,
                  ).copyWith(fontSize: 32.sp, color: context.primaryColor),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 8.h),

                Text(
                  'welcome_back_message'.tr(),
                  style: Styles.cairo14400Subtitle(context).copyWith(
                    fontSize: 16.sp,
                    color: context.secondaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40.h),

                // Email Field
                DefaultTextFormField(
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: 'enter_email_placeholder'.tr(),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: context.greyColor,
                    size: 24.sp,
                  ),
                  validation: FieldFormatters.validateEmail,
                  fillColor: context.inputBackgroundColor,
                  borderSideColor: context.borderColor,
                  borderSideEnabledColor: context.borderColor,
                  labelColorActive: context.primaryColor,
                  borderRadius: 12.r,
                  isFilled: true,
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 20.h),

                // Password Field
                DefaultTextFormField(
                  controller: _passwordController,
                  textInputType: TextInputType.visiblePassword,
                  maxLines: 1,
                  isPassword: true,
                  passwordActiveIcon: AssetData.viewOff,
                  passwordIcon: AssetData.view,
                  hintText: 'enter_password_placeholder'.tr(),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: context.greyColor,
                    size: 24.sp,
                  ),
                  validation: FieldFormatters.validatePassword,
                  fillColor: context.inputBackgroundColor,
                  borderSideColor: context.borderColor,
                  borderSideEnabledColor: context.borderColor,
                  labelColorActive: context.primaryColor,
                  borderRadius: 12.r,
                  isFilled: true,
                  textInputAction: TextInputAction.done,
                  onFilledSubmit: (_) => _handleLogin(),
                ),

                SizedBox(height: 16.h),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Forgot password clicked'),
                          backgroundColor: context.greyColor,
                        ),
                      );
                    },
                    child: Text(
                      'forgot_password'.tr(),
                      style: Styles.cairo14500C28(
                        context,
                      ).copyWith(fontSize: 14.sp, color: context.primaryColor),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // Login Button
                DefaultButton(
                  onPress: _isLoading ? null : _handleLogin,
                  text: _isLoading ? 'Loading...' : 'login'.tr(),
                  backgroundColor: context.primaryColor,
                  textColor: Colors.white,
                  borderRadius: 12.r,
                  height: 20.h,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),

                SizedBox(height: 30.h),

                // Sign Up Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'no_account'.tr(),
                      style: Styles.cairo14400Subtitle(context).copyWith(
                        fontSize: 14.sp,
                        color: context.secondaryTextColor,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign up
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Navigate to sign up'),
                            backgroundColor: context.primaryColor,
                          ),
                        );
                      },
                      child: Text(
                        'sign_up'.tr(),
                        style: Styles.cairo14500C28(context).copyWith(
                          fontSize: 14.sp,
                          color: context.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
