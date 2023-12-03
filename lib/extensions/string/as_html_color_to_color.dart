import 'package:flutter/material.dart' show Color;
import 'package:instagram_clone_app/extensions/string/remove_all.dart';

///
/// convert color representation from 0xFF?????? or #FF?????? to Color
///
extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
    int.parse(
      // remove given symbols from given color string, ensure that it
      // is 8 symbol length by adding f or ff at the beginning, if need
      removeAll(['0x', '#']).padLeft(8, 'ff'),
      radix: 16,
    )
  );
}