import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/comments/models/comment.dart';
import 'package:instagram_clone_app/state/comments/models/post_comments_request.dart';

final postCommentsProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostAndComments>(
  (ref, RequestForPostAndComments request) {
    final controller = StreamController<Iterable<Comment>>();

    ref.onDispose(() {
      controller.close();
    });

    return controller.stream;
  },
);
