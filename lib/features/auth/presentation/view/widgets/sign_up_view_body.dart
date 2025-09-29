import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pingora/core/utils/helper/field_formatters.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/auth/presentation/view/login_view.dart';
import '../../../../../core/shared/theme/app_theme.dart';
import '../../../../../core/shared/shared_widgets/default_text_form_field.dart';
import '../../../../../core/shared/shared_widgets/custom_button.dart';
import '../../../../../core/shared/shared_widgets/main_text.dart';
import '../../../../../core/utils/assets/assets.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'confirm_password_required'.tr();
    }
    if (value != _passwordController.text) {
      return 'passwords_not_match'.tr();
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'name_required'.tr();
    }
    if (value.length < 2) {
      return 'name_min_length'.tr();
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'phone_required'.tr();
    }
    if (value.length < 10) {
      return 'phone_invalid'.tr();
    }
    return null;
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate sign up process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        // Handle sign up logic here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created successfully!'),
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
                SizedBox(height: 40.h),

                // App Logo
                Image.asset(
                  AssetData.appLogo,
                  height: 120.h,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 20.h),

                // Welcome Text
                MainText(
                  'create_account'.tr(),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: context.primaryColor,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 8.h),

                MainText(
                  'join_us_message'.tr(),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.secondaryTextColor,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 30.h),

                // Full Name Field
                DefaultTextFormField(
                  controller: _fullNameController,
                  textInputType: TextInputType.name,
                  hintText: 'full_name_placeholder'.tr(),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: context.greyColor,
                    size: 24.sp,
                  ),
                  validation: _validateName,
                  fillColor: context.inputBackgroundColor,
                  borderSideColor: context.borderColor,
                  borderSideEnabledColor: context.borderColor,
                  labelColorActive: context.primaryColor,
                  borderRadius: 12.r,
                  isFilled: true,
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 16.h),

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

                SizedBox(height: 16.h),

                // Phone Field
                DefaultTextFormField(
                  controller: _phoneController,
                  textInputType: TextInputType.phone,
                  hintText: 'enter_phone_placeholder'.tr(),
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: context.greyColor,
                    size: 24.sp,
                  ),
                  validation: _validatePhone,
                  fillColor: context.inputBackgroundColor,
                  borderSideColor: context.borderColor,
                  borderSideEnabledColor: context.borderColor,
                  labelColorActive: context.primaryColor,
                  borderRadius: 12.r,
                  isFilled: true,
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 16.h),

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
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 16.h),

                // Confirm Password Field
                DefaultTextFormField(
                  controller: _confirmPasswordController,
                  textInputType: TextInputType.visiblePassword,
                  maxLines: 1,
                  isPassword: true,
                  passwordActiveIcon: AssetData.viewOff,
                  passwordIcon: AssetData.view,
                  hintText: 'confirm_password_placeholder'.tr(),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: context.greyColor,
                    size: 24.sp,
                  ),
                  validation: _validateConfirmPassword,
                  fillColor: context.inputBackgroundColor,
                  borderSideColor: context.borderColor,
                  borderSideEnabledColor: context.borderColor,
                  labelColorActive: context.primaryColor,
                  borderRadius: 12.r,
                  isFilled: true,
                  textInputAction: TextInputAction.done,
                  onFilledSubmit: (_) => _handleSignUp(),
                ),

                SizedBox(height: 20.h),

                // Terms and Conditions Checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value ?? false;
                        });
                      },
                      activeColor: context.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Builder(
                          builder: (context) {
                            final TextTheme textTheme = Theme.of(
                              context,
                            ).textTheme;
                            return RichText(
                              text: TextSpan(
                                style: textTheme.bodyLarge!.copyWith(
                                  fontSize: 13.sp,
                                  color: context.secondaryTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(text: 'i_agree_to'.tr()),
                                  TextSpan(
                                    text: ' ${('terms_conditions'.tr())}',
                                    style: TextStyle(
                                      color: context.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' ${'and'.tr()} '),
                                  TextSpan(
                                    text: 'privacy_policy'.tr(),
                                    style: TextStyle(
                                      color: context.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                // Sign Up Button
                DefaultButton(
                  onPress: (_isLoading || !_acceptTerms) ? null : _handleSignUp,
                  text: _isLoading ? 'Loading...' : 'create_account'.tr(),
                  backgroundColor: _acceptTerms
                      ? context.primaryColor
                      : context.greyColor,
                  textColor: Colors.white,
                  borderRadius: 12.r,
                  height: 20.h,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),

                SizedBox(height: 30.h),

                // Login Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MainText(
                      'already_have_account'.tr(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: context.secondaryTextColor,
                    ),
                    SizedBox(width: 6.w),
                    TextButton(
                      onPressed: () {
                        // Navigate to login
                        MagicRouter.navigateAndPopAll(LoginView());
                      },
                      child: MainText(
                        'login'.tr(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.primaryColor,
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
