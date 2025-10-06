import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pingora/core/shared/shared_widgets/main_text.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';

enum LoadingType {
  circular,
  dots,
  wave,
  pulse,
  ring,
  ripple,
  threeBounce,
  wanderingCubes,
  fadingCircle,
  rotatingCircle,
}

class CustomLoadingWidgetIndicator extends StatelessWidget {
  final LoadingType type;
  final Color? color;
  final double? size;
  final String? message;
  final double? messageSpacing;
  final TextStyle? messageStyle;
  final bool showBackground;
  final Color? backgroundColor;
  final double backgroundOpacity;
  final EdgeInsetsGeometry? padding;

  CustomLoadingWidgetIndicator({
    super.key,
    this.type = LoadingType.circular,
    this.color,
    this.size,
    this.message,
    this.messageSpacing,
    this.messageStyle,
    this.showBackground = false,
    this.backgroundColor,
    this.backgroundOpacity = 0.3,
    this.padding,
  });

  /// Full screen loading overlay
  CustomLoadingWidgetIndicator.overlay({
    super.key,
    this.type = LoadingType.fadingCircle,
    this.color,
    this.size = 50,
    this.message,
    this.messageSpacing = 32,
    this.messageStyle,
    this.showBackground = true,
    this.backgroundColor,
    this.backgroundOpacity = 0.8,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? context.primaryColor;
    final loadingSize = size ?? 30.0;

    Widget loadingWidget = _buildLoadingByType(loadingColor, loadingSize);

    // Wrap with message if provided
    if (message != null) {
      loadingWidget = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loadingWidget,
          SizedBox(height: messageSpacing ?? 12.h),
          MainText(
            message!,
            fontSize: messageStyle?.fontSize ?? 20.sp,
            fontWeight: messageStyle?.fontWeight ?? FontWeight.bold,
            color: messageStyle?.color ?? loadingColor,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    // Add padding if provided
    if (padding != null) {
      loadingWidget = Padding(padding: padding!, child: loadingWidget);
    }

    // Add background container if needed
    if (showBackground) {
      loadingWidget = Container(
        decoration: BoxDecoration(
          color: (backgroundColor ?? Colors.white).withValues(
            alpha: backgroundOpacity,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(20.r),
        child: loadingWidget,
      );
    }

    return Center(child: loadingWidget);
  }

  Widget _buildLoadingByType(Color color, double size) {
    switch (type) {
      case LoadingType.circular:
        return SpinKitCircle(color: color, size: size);
      case LoadingType.dots:
        return SpinKitThreeBounce(
          color: color,
          size: size * 0.5, // Dots look better smaller
        );
      case LoadingType.wave:
        return SpinKitWave(color: color, size: size * 0.8);
      case LoadingType.pulse:
        return SpinKitPulse(color: color, size: size);
      case LoadingType.ring:
        return SpinKitRing(color: color, size: size);
      case LoadingType.ripple:
        return SpinKitRipple(color: color, size: size);
      case LoadingType.threeBounce:
        return SpinKitThreeBounce(color: color, size: size * 0.4);
      case LoadingType.wanderingCubes:
        return SpinKitWanderingCubes(color: color, size: size * 0.8);
      case LoadingType.fadingCircle:
        return SpinKitFadingCircle(color: color, size: size);
      case LoadingType.rotatingCircle:
        return SpinKitRotatingCircle(color: color, size: size);
    }
  }
}
