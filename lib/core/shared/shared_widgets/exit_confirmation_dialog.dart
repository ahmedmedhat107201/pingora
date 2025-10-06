import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pingora/core/shared/shared_widgets/custom_dialog.dart';
import 'package:pingora/core/utils/router/router_helper.dart';

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
      MagicRouter.pop(); // Return true to confirm exit
    },
    onCancelPressed: () {
      MagicRouter.pop(); // Return false to cancel exit
    },
  );
}
