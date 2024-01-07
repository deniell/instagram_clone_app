import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/state/image_upload/helpers/image_picker_helper.dart';
import 'package:instagram_clone_app/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_app/state/post_settings/providers/post_settings_provider.dart';
import 'package:instagram_clone_app/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_app/views/components/dialogs/logout_dialog.dart';
import 'package:instagram_clone_app/views/constants/strings.dart';
import 'package:instagram_clone_app/views/create_new_post/create_new_post_view.dart';
import 'package:instagram_clone_app/views/tabs/users_posts/users_post_view.dart';

///
/// Widget which represents Main page view.
///
class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // pick a video
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();

                if (videoFile == null) {
                  return;
                }

                // reset [postSettingsProvider] provider for following post,
                // which we are going to create
                ref.refresh(postSettingsProvider);

                // if this widget is not mounted do nothing
                if (!context.mounted) {
                  return;
                }

                // got to the Crate New Post page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: videoFile,
                      fileType: FileType.video,
                    ),
                  ),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
            ),
            IconButton(
              onPressed: () async {
                // pick a image
                final imageFile =
                await ImagePickerHelper.pickImageFromGallery();

                if (imageFile == null) {
                  return;
                }

                // reset [postSettingsProvider] provider for following post,
                // which we are going to create
                ref.refresh(postSettingsProvider);

                // if this widget is not mounted do nothing
                if (!context.mounted) {
                  return;
                }

                // got to the Crate New Post page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: imageFile,
                      fileType: FileType.image,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            UserPostsView(),
            UserPostsView(),
          ],
        ),
      ),
    );
  }
}
