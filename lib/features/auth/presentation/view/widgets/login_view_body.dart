import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pingora/core/shared/shared_widgets/toast.dart';
import 'package:pingora/core/utils/helper/field_formatters.dart';
import 'package:pingora/core/utils/router/router_helper.dart';
import 'package:pingora/features/auth/presentation/view/sign_up_view.dart';
import 'package:pingora/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:pingora/features/chat_rooms/presentation/view/chat_rooms_view.dart';
import '../../../../../core/shared/theme/app_theme.dart';
import '../../../../../core/shared/shared_widgets/default_text_form_field.dart';
import '../../../../../core/shared/shared_widgets/custom_button.dart';
import '../../../../../core/shared/shared_widgets/main_text.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      await context.read<AuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          toast(text: 'login failed', color: Colors.red);
        }
        if (state is LoginSuccess) {
          toast(text: 'login success', color: context.secondaryColor);
          MagicRouter.navigateAndPopAll(ChatRoomsView());
        }
      },
      child: Container(
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

                  Image.asset(
                    AssetData.appLogo,
                    height: 120.h,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 24.h),

                  // Welcome Text
                  MainText(
                    'login'.tr(),
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: context.secondaryColor,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8.h),

                  MainText(
                    'welcome_back_message'.tr(),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: context.secondaryTextColor,
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

                  SizedBox(height: 30.h),

                  // Login Button
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return DefaultButton(
                        onPress: state is LoginLoading
                            ? null
                            : () {
                                _handleLogin();
                              },
                        text: state is LoginLoading
                            ? 'loading'.tr()
                            : 'login'.tr(),
                        backgroundColor: context.primaryColor,
                        textColor: Colors.white,
                        borderRadius: 12.r,
                        height: 20.h,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        shadowColor: Colors.black45,
                      );
                    },
                  ),

                  SizedBox(height: 30.h),

                  // Sign Up Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MainText(
                        'no_account'.tr(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.secondaryTextColor,
                      ),
                      SizedBox(width: 6.w),
                      TextButton(
                        onPressed: () {
                          // Navigate to sign up
                          MagicRouter.navigateAndPopAll(SignUpView());
                        },
                        child: MainText(
                          'sign_up'.tr(),
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
      ),
    );
  }
}
