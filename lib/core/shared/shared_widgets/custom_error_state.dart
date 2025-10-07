import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';

class CustomErrorState extends StatelessWidget {
  final String errorMessage;
  final void Function()? onRetry;
  CustomErrorState({required this.errorMessage, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Error: ${errorMessage}')),
        SizedBox(height: 16.h),
        ElevatedButton(onPressed: onRetry, child: MainText('retry'.tr())),
      ],
    );
  }
}
