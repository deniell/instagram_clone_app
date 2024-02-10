import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_app/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_app/state/post_settings/models/post_settings.dart';
import 'package:instagram_clone_app/state/posts/models/post_key.dart';
import 'package:instagram_clone_app/state/posts/typedefs/user_id.dart';

///
/// Class, which helps us to serialize Post data to Firebase payload.
///
@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<PostSetting, bool> postSettings,
  }) : super(
          {
            PostKeys.userId: userId,
            PostKeys.message: message,
            PostKeys.createdAt: FieldValue.serverTimestamp(),
            PostKeys.thumbnailUrl: thumbnailUrl,
            PostKeys.fileUrl: fileUrl,
            PostKeys.fileType: fileType.name,
            PostKeys.fileName: fileName,
            PostKeys.aspectRatio: aspectRatio,
            PostKeys.thumbnailStorageId: thumbnailStorageId,
            PostKeys.originalFileStorageId: originalFileStorageId,
            PostKeys.postSettings: {
              for (final postSetting in postSettings.entries)
                {
                  postSetting.key.storageKey: postSetting.value,
                }
            },
          },
        );
}
