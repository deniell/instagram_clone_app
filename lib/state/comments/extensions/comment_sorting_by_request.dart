import 'package:instagram_clone_app/enums/date_sorting.dart';
import 'package:instagram_clone_app/state/comments/models/comment.dart';
import 'package:instagram_clone_app/state/comments/models/post_comments_request.dart';

///
/// Extension, which helps sort Comments.
///
extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForPostAndComments request) {
    if (request.sortByCreatedAt) {
      final sortedDocuments = toList()
        ..sort(
          (a, b) {
            switch (request.dateSorting) {
              case DateSorting.newestOnTop:
                return b.createdAt.compareTo(a.createdAt);
              case DateSorting.oldestOnTop:
                return a.createdAt.compareTo(b.createdAt);
            }
          },
        );
      return sortedDocuments;
    } else {
      return this;
    }
  }
}
