import 'package:easy_localization/easy_localization.dart';

class FieldFormatters {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_required'.tr();
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'email_invalid'.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_required'.tr();
    }
    if (value.length < 8) {
      return 'password_min_length'.tr();
    }
    return null;
  }
}
