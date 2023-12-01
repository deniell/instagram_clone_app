import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  static const users = 'users';
  static const posts = 'posts';
  static const comments = 'comments';
  static const likes = 'likes';
  static const thumbnails = 'thumbnails';

  const FirebaseCollectionName._();
}
