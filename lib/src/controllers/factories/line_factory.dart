import 'dart:ui';

import 'package:uuid/uuid.dart';

import '../drawables/shape/line_drawable.dart';
import 'shape_factory.dart';

/// A [LineDrawable] factory.
class LineFactory extends ShapeFactory<LineDrawable> {
  /// Creates an instance of [LineFactory].
  LineFactory() : super();

  /// Creates and returns a [LineDrawable] with length of 0 and the passed [position] and [paint].
  @override
  LineDrawable create(Offset position, [Paint? paint]) {
    return LineDrawable(
        id: const Uuid().v4(), length: 0, position: position, paint: paint);
  }
}
