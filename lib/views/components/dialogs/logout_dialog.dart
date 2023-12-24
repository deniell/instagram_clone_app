import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_app/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_app/views/constants/strings.dart';

///
/// Log out dialog.
///
@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog() : super(
    title: Strings.logOut,
    message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
    buttons: const {
      Strings.logOut: true,
      Strings.cancel: false,
    }
  );
}
