import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_app/state/comments/models/comment.dart';
import 'package:instagram_clone_app/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone_app/views/components/animations/samall_error_animation_view.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;

  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );

    return userInfo.when(
      data: (userInfoModel) {
        final currentUserId = ref.read(userIdProvider);

        return ListTile(
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  onPressed: () async {},
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
}
