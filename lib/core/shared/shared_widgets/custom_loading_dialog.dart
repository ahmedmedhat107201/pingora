import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/custom_button.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/utils/colors/colors.dart';
import 'package:pingora/core/utils/router/router_helper.dart';

class CustomLoadingDialog extends StatefulWidget {
  final String? title;
  final String? description;
  final Widget? contentWidget;
  final String? okTitle;
  final String? cancelTitle;
  final String? loadingTitle;
  final String? loadingMessage;
  final Future<void> Function()? onConfirm;
  final VoidCallback? onCancel;
  final bool showCancelButton;
  final bool canPop;
  final Color? okButtonColor;
  final Color? cancelButtonColor;
  final Color? okTextColor;
  final Color? cancelTextColor;
  final Widget? loadingWidget;

  const CustomLoadingDialog({
    super.key,
    this.title,
    this.description,
    this.contentWidget,
    this.okTitle = 'Confirm',
    this.cancelTitle = 'Cancel',
    this.loadingTitle = 'Processing',
    this.loadingMessage = 'Please wait...',
    this.onConfirm,
    this.onCancel,
    this.showCancelButton = true,
    this.canPop = true,
    this.okButtonColor,
    this.cancelButtonColor,
    this.okTextColor,
    this.cancelTextColor,
    this.loadingWidget,
  });

  @override
  State<CustomLoadingDialog> createState() => _CustomLoadingDialogState();

  /// Static method to show the loading dialog
  static Future<bool?> show({
    required BuildContext context,
    String? title,
    String? description,
    Widget? contentWidget,
    String? okTitle = 'Confirm',
    String? cancelTitle = 'Cancel',
    String? loadingTitle = 'Processing',
    String? loadingMessage = 'Please wait...',
    Future<void> Function()? onConfirm,
    VoidCallback? onCancel,
    bool showCancelButton = true,
    bool canPop = true,
    Color? okButtonColor,
    Color? cancelButtonColor,
    Color? okTextColor,
    Color? cancelTextColor,
    Widget? loadingWidget,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: canPop,
      builder: (context) => CustomLoadingDialog(
        title: title,
        description: description,
        contentWidget: contentWidget,
        okTitle: okTitle,
        cancelTitle: cancelTitle,
        loadingTitle: loadingTitle,
        loadingMessage: loadingMessage,
        onConfirm: onConfirm,
        onCancel: onCancel,
        showCancelButton: showCancelButton,
        canPop: canPop,
        okButtonColor: okButtonColor,
        cancelButtonColor: cancelButtonColor,
        okTextColor: okTextColor,
        cancelTextColor: cancelTextColor,
        loadingWidget: loadingWidget,
      ),
    );
  }
}

class _CustomLoadingDialogState extends State<CustomLoadingDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop && !_isLoading,
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
              if (widget.title != null) ...[
                MainText(
                  widget.title!,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: context.primaryTextColor,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
              ],

              // Description Section
              if (widget.description != null) ...[
                MainText(
                  widget.description!,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: context.secondaryTextColor,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
              ],

              // Content Widget Section
              if (widget.contentWidget != null) ...[
                widget.contentWidget!,
                SizedBox(height: 20.h),
              ],

              // Loading Section (shown when loading)
              if (_isLoading) ...[
                widget.loadingWidget ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        MainText(
                          widget.loadingMessage ?? 'Please wait...',
                          fontSize: 14.sp,
                          color: context.primaryColor,
                        ),
                      ],
                    ),
                SizedBox(height: 24.h),
              ],

              // Buttons Section
              if (widget.showCancelButton && !_isLoading) ...[
                // Two buttons in a row
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: DefaultButton(
                        onPress: () {
                          if (widget.onCancel != null) {
                            widget.onCancel!();
                          } else {
                            MagicRouter.pop();
                          }
                        },
                        text: widget.cancelTitle,
                        backgroundColor:
                            widget.cancelButtonColor ?? Colors.grey[100],
                        textColor: widget.cancelTextColor ?? Colors.grey[700],
                        borderRadius: 12.r,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        width: 0.w,
                        height: 16.h,
                        hasBorder: true,
                        borderColor: Colors.grey[300],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // OK Button
                    Expanded(
                      child: DefaultButton(
                        onPress: _isLoading ? null : _handleConfirm,
                        text: _isLoading ? widget.loadingTitle : widget.okTitle,
                        backgroundColor:
                            widget.okButtonColor ??
                            AppColors.primarySwatchColor,
                        textColor: widget.okTextColor ?? Colors.white,
                        width: 0.w,
                        borderRadius: 12.r,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 16.h,
                      ),
                    ),
                  ],
                ),
              ] else if (!widget.showCancelButton) ...[
                // Single OK button
                DefaultButton(
                  onPress: _isLoading ? null : _handleConfirm,
                  text: _isLoading ? widget.loadingTitle : widget.okTitle,
                  backgroundColor:
                      widget.okButtonColor ?? AppColors.primarySwatchColor,
                  textColor: widget.okTextColor ?? Colors.white,
                  borderRadius: 12.r,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 16.h,
                ),
              ] else if (_isLoading) ...[
                // Only show loading button when loading
                DefaultButton(
                  onPress: null,
                  text: widget.loadingTitle ?? 'Processing',
                  backgroundColor:
                      widget.okButtonColor ?? AppColors.primarySwatchColor,
                  textColor: widget.okTextColor ?? Colors.white,
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

  Future<void> _handleConfirm() async {
    if (widget.onConfirm == null) {
      MagicRouter.pop();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onConfirm!();

      // Close dialog after successful operation
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      // Reset loading state on error
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      // You can add error handling here or rethrow
      rethrow;
    }
  }
}
