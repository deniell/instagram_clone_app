import 'package:instagram_clone_app/views/constants/strings.dart';

enum PostSetting {
  allowLikes(
    title: Strings.allowLikesTitle,
    description: Strings.allowLikesDescription,
    storageKey: Strings.allowLikesStorageKey,
  ),

  allowComments(
    title: Strings.allowCommentsTitle,
    description: Strings.allowCommentsDescription,
    storageKey: Strings.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;

  const PostSetting({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
