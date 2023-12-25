///
/// Exception, which throw when fail to build thumbnail.
///
class CouldNotBuildThumbnailException implements Exception {
  final message = 'Could not build thumbnail';
  const CouldNotBuildThumbnailException();
}
