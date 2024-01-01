import 'package:instagram_clone_app/state/image_upload/models/file_type.dart';

///
/// Extension, which return collection name for given [FileType].
///
extension CollectionName on FileType {
  String get collectionName {
    switch(this) {
      case FileType.image:
        return 'images';
      case FileType.video:
        return 'videos';
    }
  }
}
