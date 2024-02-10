import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_app/state/comments/models/comment.dart';
import 'package:instagram_clone_app/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_clone_app/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone_app/views/components/animations/samall_error_animation_view.dart';
import 'package:instagram_clone_app/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_app/views/components/dialogs/delete_dialog.dart';
import 'package:instagram_clone_app/views/constants/strings.dart';

///
/// Widget, which represents comment tile in list of comments.
///
class CommentTile extends ConsumerWidget {
  final Comment comment;

  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );

    return userInfoModel.when(
      data: (userInfo) {
        final currentUserId = ref.read(userIdProvider);

        return ListTile(
          title: Text(userInfo.displayName),
          subtitle: Text(comment.comment),
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  onPressed: () async {
                    final shouldDeleteComment = await displayDeleteDialog(
                      context,
                    );
                    if (shouldDeleteComment) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                  icon: const Icon(Icons.delete),
                )
              : null,
        );
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then((value) => value ?? false);
}
