import 'package:flutter/material.dart';
import 'package:instagram_clone_app/state/posts/models/post.dart';

///
/// Widget responsible for displaying Post Thumbnail in Grid view
///
class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;

  const PostThumbnailView({
    super.key,
    required this.post,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
