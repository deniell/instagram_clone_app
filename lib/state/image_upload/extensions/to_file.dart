import 'dart:io';

import 'package:image_picker/image_picker.dart';

///
/// Extension on [Future<XFile?>], which convert Future<XFile?> to Future<File?>
///
extension ToFile on Future<XFile?> {
  Future<File?> toFile() => then((xFile) => xFile?.path).then(
        (filePath) => filePath != null ? File(filePath) : null,
      );
}
