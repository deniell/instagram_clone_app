import 'package:flutter/cupertino.dart';

///
/// Extension, which help hide the keyboard on any widget.
///
extension DismissKeyboard on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
