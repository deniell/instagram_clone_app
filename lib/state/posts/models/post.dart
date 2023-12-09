import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_app/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_app/state/post_settings/models/post_settings.dart';
import 'package:instagram_clone_app/state/posts/models/post_key.dart';

@immutable
class Post {
  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFileStorageId;
  final Map<PostSetting, bool> postSettings;

  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKeys.userId],
        message = json[PostKeys.message],
        createdAt = (json[PostKeys.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[PostKeys.thumbnailUrl],
        fileUrl = json[PostKeys.fileUrl],
        fileType = FileType.values.firstWhere(
          (fileType) => fileType.name == json[PostKeys.fileType],
          orElse: () => FileType.image,
        ),
        fileName = json[PostKeys.fileName],
        aspectRatio = json[PostKeys.aspectRatio],
        thumbnailStorageId = json[PostKeys.thumbnailStorageId],
        originalFileStorageId = json[PostKeys.originalFileStorageId],
        postSettings = {
          for (final entry in json[PostKeys.postSettings].entries)
            PostSetting.values
                    .firstWhere((element) => element.storageKey == entry.key):
                entry.value,
        };
}
