// lib/media_query_extension.dart

import 'package:flutter/material.dart';

/// Extension to add media query utilities to the BuildContext.
extension MediaQueryExtension on BuildContext {
  /// Returns the size of the current media query.
  Size sizeOf() {
    return MediaQuery.of(this).size;
  }

  /// Returns the width of the current media query.
  double width() {
    return sizeOf().width;
  }

  /// Returns the height of the current media query.
  double height() {
    return sizeOf().height;
  }

  /// Returns the current orientation of the device.
  Orientation orientation() {
    return MediaQuery.of(this).orientation;
  }

  /// Returns the padding of the current media query.
  EdgeInsets padding() {
    return MediaQuery.of(this).padding;
  }
}
