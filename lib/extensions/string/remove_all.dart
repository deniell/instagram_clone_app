///
/// Remove from given string all values provided to this extension as parameters
///
extension RemoveAll on String {
  String removeAll(Iterable<String> values) => values.fold(
        this,
        (result, value) => result.replaceAll(
          value,
          '',
        ),
      );
}
