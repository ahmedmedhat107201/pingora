import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pingora/core/shared/shared_widgets/custom_dialog.dart';

Future<bool?> showExitConfirmationDialog(BuildContext context) async {
  return await CustomDialog.show(
    context: context,
    title: 'exit_app_title'.tr(),
    description: 'exit_app_message'.tr(),
    okTitle: 'ok'.tr(),
    cancelTitle: 'cancel'.tr(),
    showCancelButton: true,
    canPop: true,
    onOkPressed: () {
      Navigator.of(context).pop(true); // Return true to confirm exit
    },
    onCancelPressed: () {
      Navigator.of(context).pop(false); // Return false to cancel exit
    },
  );
}
