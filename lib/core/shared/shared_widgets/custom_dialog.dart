import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/custom_button.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/utils/colors/colors.dart';
import 'package:pingora/core/utils/router/router_helper.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? contentWidget;
  final String? okTitle;
  final String? cancelTitle;
  final VoidCallback? onOkPressed;
  final VoidCallback? onCancelPressed;
  final bool showCancelButton;
  final bool canPop;
  final Color? okButtonColor;
  final Color? cancelButtonColor;
  final Color? okTextColor;
  final Color? cancelTextColor;

  const CustomDialog({
    super.key,
    this.title,
    this.description,
    this.contentWidget,
    this.okTitle,
    this.cancelTitle,
    this.onOkPressed,
    this.onCancelPressed,
    this.showCancelButton = true,
    this.canPop = true,
    this.okButtonColor,
    this.cancelButtonColor,
    this.okTextColor,
    this.cancelTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Dialog(
        backgroundColor: context.backgroundColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 400.w, minWidth: 280.w),
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Section
              if (title != null) ...[
                MainText(
                  title!,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: context.primaryTextColor,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
              ],

              // Description Section
              if (description != null) ...[
                MainText(
                  description!,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: context.secondaryTextColor,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
              ],

              // Content Widget Section
              if (contentWidget != null) ...[
                contentWidget!,
                SizedBox(height: 24.h),
              ],

              // Buttons Section
              if (showCancelButton) ...[
                // Two buttons in a row
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: DefaultButton(
                        onPress: onCancelPressed ?? () => MagicRouter.pop(),
                        text: cancelTitle ?? 'cancel'.tr(),
                        backgroundColor: cancelButtonColor ?? Colors.grey[100],
                        textColor: cancelTextColor ?? Colors.grey[700],
                        borderRadius: 12.r,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        height: 16.h,
                        hasBorder: true,
                        borderColor: Colors.grey[300],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // OK Button
                    Expanded(
                      child: DefaultButton(
                        onPress: onOkPressed ?? () => MagicRouter.pop(),
                        text: okTitle ?? 'ok'.tr(),
                        backgroundColor:
                            okButtonColor ?? AppColors.primarySwatchColor,
                        textColor: okTextColor ?? Colors.white,
                        borderRadius: 12.r,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        height: 16.h,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // Single OK button
                DefaultButton(
                  onPress: onOkPressed ?? () => MagicRouter.pop(),
                  text: okTitle ?? 'ok'.tr(),
                  backgroundColor:
                      okButtonColor ?? AppColors.primarySwatchColor,
                  textColor: okTextColor ?? Colors.white,
                  borderRadius: 12.r,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 16.h,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Show the custom dialog and return the result
  static Future<bool?> show({
    required BuildContext context,
    String? title,
    String? description,
    Widget? contentWidget,
    String? okTitle,
    String? cancelTitle,
    VoidCallback? onOkPressed,
    VoidCallback? onCancelPressed,
    bool showCancelButton = true,
    bool canPop = true,
    Color? okButtonColor,
    Color? cancelButtonColor,
    Color? okTextColor,
    Color? cancelTextColor,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: canPop,
      builder: (context) => CustomDialog(
        title: title,
        description: description,
        contentWidget: contentWidget,
        okTitle: okTitle,
        cancelTitle: cancelTitle,
        onOkPressed: onOkPressed,
        onCancelPressed: onCancelPressed,
        showCancelButton: showCancelButton,
        canPop: canPop,
        okButtonColor: okButtonColor,
        cancelButtonColor: cancelButtonColor,
        okTextColor: okTextColor,
        cancelTextColor: cancelTextColor,
      ),
    );
  }
}
