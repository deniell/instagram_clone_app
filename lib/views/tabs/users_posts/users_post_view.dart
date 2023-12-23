import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/posts/providers/user_posts_provider.dart';
import 'package:instagram_clone_app/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone_app/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_app/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_app/views/components/posts/posts_grid_view.dart';
import 'package:instagram_clone_app/views/constants/strings.dart';

///
/// Widget which show either posts grid or [EmptyContentsWithAnimationView]
///
class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);

    return RefreshIndicator(
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithAnimationView(
              text: Strings.youHaveNoPosts,
            );
          } else {
            return PostsGridView(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
      onRefresh: () {
        ref.refresh(userPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
    );
  }
}
