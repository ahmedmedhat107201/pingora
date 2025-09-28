import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/colors/colors.dart';
import '../../utils/text_styles/styles.dart';

// ignore: must_be_immutable
class DefaultTextFormField extends StatefulWidget {
  int? maxLength;
  int? maxLines;
  bool isEnabled;
  bool required;
  bool isPassword;
  bool centerHint;
  bool isFilled;
  bool hasBorder;
  bool autoFocus;
  bool readOnly;
  bool underLine;
  double contentPaddingVertical;
  double contentPaddingHorizontal;
  double borderRadius;
  double borderSideWidth;
  Color enabledBorderRadiusColor;
  Color? borderSideColor;
  Color? borderSideEnabledColor;
  Color? labelColorActive;
  String? validationMsg;
  String? passwordIcon;
  String? passwordActiveIcon;
  TextInputType textInputType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Function? onPressSuffixIcon;
  Function(String)? onFilledSubmit;
  Function(String)? onChange;
  Function? validation;
  Function? onTap;
  String? labelText;
  String? hintText;
  TextEditingController controller;
  Color? fillColor;
  TextStyle? style;
  TextStyle? hintStyle;
  TextInputAction? textInputAction;
  final List<TextInputFormatter>? formatter;

  DefaultTextFormField({
    Key? key,
    this.isPassword = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.isFilled = false,
    this.underLine = false,
    this.centerHint = false,
    this.hasBorder = true,
    this.labelColorActive,
    this.required = true,
    this.isEnabled = true,
    this.passwordIcon,
    this.passwordActiveIcon,
    this.borderSideWidth = 1.0,
    this.contentPaddingHorizontal = 10.0,
    this.borderSideColor,
    this.contentPaddingVertical = 0.0,
    this.borderRadius = 10,
    this.enabledBorderRadiusColor = Colors.grey,
    this.maxLength,
    this.maxLines,
    this.labelText,
    this.hintText,
    this.hintStyle,
    required this.textInputType,
    required this.controller,
    this.onFilledSubmit,
    this.onChange,
    this.borderSideEnabledColor,
    this.onTap,
    this.onPressSuffixIcon,
    this.validation,
    this.suffixIcon,
    this.prefixIcon,
    this.validationMsg,
    this.style,
    this.fillColor,
    this.formatter,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late FocusNode myFocusNode;
  bool hidePassword = true;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.formatter,
      style: widget.style ?? Styles.cairo14500Black(context),
      readOnly: widget.readOnly,
      textAlign: widget.centerHint ? TextAlign.center : TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      obscureText: widget.isPassword && hidePassword,
      focusNode: myFocusNode,
      autofocus: widget.autoFocus,
      enabled: widget.isEnabled,
      obscuringCharacter: '●',
      controller: widget.controller,
      keyboardType: widget.textInputType,
      onFieldSubmitted: (value) {
        if (widget.onFilledSubmit != null) {
          widget.onFilledSubmit!(value);
        }
      },
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      validator: (String? value) {
        if (widget.validation != null) {
          return widget.validation!(value);
        } else if (value!.isEmpty && widget.required) {
          return widget.validationMsg ?? "validationText".tr();
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counterText: '',
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.contentPaddingVertical,
          horizontal: widget.contentPaddingHorizontal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          borderSide: (!widget.hasBorder)
              ? BorderSide.none
              : BorderSide(
                  color: widget.borderSideColor ?? AppColors.primaryColor,
                  width: widget.borderSideWidth,
                ),
        ),
        focusedBorder: widget.underLine
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffD6D6D6)),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius),
                ),
                borderSide: (!widget.hasBorder)
                    ? BorderSide.none
                    : BorderSide(
                        color: widget.borderSideColor ?? AppColors.primaryColor,
                        width: widget.borderSideWidth,
                      ),
              ),
        enabledBorder: widget.underLine
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffD6D6D6)),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius),
                ),
                borderSide: (!widget.hasBorder)
                    ? BorderSide.none
                    : BorderSide(
                        color:
                            widget.borderSideEnabledColor ??
                            Colors.grey.shade300,
                        width: widget.borderSideWidth,
                      ),
              ),
        filled: true,
        fillColor: widget.fillColor ?? Colors.white,
        prefixIcon: widget.prefixIcon,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? Styles.cairo14400HeavyGray(context),
        errorMaxLines: 2,
        labelStyle: TextStyle(
          color: myFocusNode.hasFocus
              ? widget.labelColorActive ?? AppColors.primaryColor
              : widget.labelColorActive ?? Colors.grey,
          fontSize: MediaQuery.of(context).size.height * .02,
        ),
        suffixIcon:
            widget.suffixIcon ??
            (widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: SvgPicture.asset(
                      hidePassword
                          ? widget.passwordIcon!
                          : widget.passwordActiveIcon!,
                      // ignore: deprecated_member_use
                      color: myFocusNode.hasFocus
                          ? AppColors.primaryColor
                          : const Color(0xffD6D6D6),
                    ),
                  )
                : null),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }
}
