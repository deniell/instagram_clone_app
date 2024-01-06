import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_app/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_app/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_clone_app/state/image_upload/providers/image_uploader_provider.dart';
import 'package:instagram_clone_app/state/post_settings/providers/post_settings_provider.dart';
import 'package:instagram_clone_app/views/constants/strings.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;

  const CreateNewPostView({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    // thumbnail request for post image/video thumbnail
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );
    // post settings provider
    final postSettings = ref.watch(postSettingsProvider);
    // post text field editing controller
    final postController = useTextEditingController();
    // post button state
    final isPostButtonEnabled = useState(false);
    // disable or enable post button depends on if there some text in post text
    // editing field
    useEffect(
      () {
        // listener function
        void listener() {
          isPostButtonEnabled.value = postController.text.isNotEmpty;
        }

        // listen to [postController] changes
        postController.addListener(listener);
        // effect return
        return () {
          postController.removeListener(listener);
        };
      },
      [postController],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.createNewPost,
        ),
        actions: [
          IconButton(
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text;
                    final isUploaded =
                        await ref.read(imageUploaderProvider.notifier).upload(
                              file: widget.fileToPost,
                              fileType: widget.fileType,
                              message: message,
                              postSettings: postSettings,
                              userId: userId,
                            );
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
