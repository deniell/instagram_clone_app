import 'package:flutter/material.dart';
import 'package:instagram_clone_app/state/posts/models/post.dart';
import 'package:instagram_clone_app/views/components/posts/post_thumbnail_view.dart';

///
/// Widget responsible for displaying a grid of posts thumbnails
///
class PostsGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostsGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {
            // TODO: navigate to the post details view
          },
        );
      },
    );
  }
}
