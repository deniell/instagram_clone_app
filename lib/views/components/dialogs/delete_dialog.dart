import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_app/views/constants/strings.dart';

///
/// Dialog, which app show to confirm deletion of some object.
///
@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({required String titleOfObjectToDelete})
      : super(
          title: '${Strings.delete} $titleOfObjectToDelete?',
          message:
              '${Strings.areYouSureYouWantToDeleteThis} $titleOfObjectToDelete?',
          buttons: const {
            Strings.cancel: false,
            Strings.delete: true,
          },
        );
}
