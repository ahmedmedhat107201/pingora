import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../utils/colors/colors.dart';

// ignore: must_be_immutable
class DefaultButton extends StatelessWidget {
  void Function()? onPress;
  String text;
  Widget? icon;
  double? borderRadius;
  double? height;
  double? fontSize;
  String? fontFamily;
  Color? backgroundColor;
  Color? textColor;
  Color? surfaceTintColor;
  Color? shadowColor;
  bool hasBorder;
  Color? borderColor;
  double? elevation;
  FontWeight? fontWeight;
  double? width;

  DefaultButton({
    super.key,
    required this.onPress,
    required this.text,
    this.icon,
    this.borderRadius,
    this.height,
    this.fontFamily,
    this.fontSize,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.hasBorder = false,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.fontWeight,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        surfaceTintColor: surfaceTintColor,
        shadowColor: shadowColor,
        elevation: elevation ?? 3,
        padding: EdgeInsets.symmetric(
          vertical: height ?? AppConstants.height20(context),
          horizontal: width ?? AppConstants.width30(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          side: BorderSide(
            color: hasBorder ? borderColor! : AppColors.primaryColor,
          ),
        ),
      ),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon!],
          SizedBox(width: AppConstants.width5(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:
                      fontSize ?? MediaQuery.of(context).size.height * .018,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  color: textColor ?? Colors.white,
                  fontFamily: "cairo",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
