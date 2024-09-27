import 'dart:ui';

/// Abstract class to define a drawable object.
abstract class Drawable {
  final String id;

  /// Whether the drawable is hidden or not.
  final bool hidden;

  /// Default constructor.
  const Drawable({required this.id, this.hidden = false});

  /// Draws the drawable on the provided [canvas] of size [size].
  void draw(Canvas canvas, Size size);

  bool get isHidden => hidden;

  bool get isNotHidden => !hidden;

  /// equality between two [Drawable]s.
  @override
  bool operator ==(Object other) {
    return other is Drawable && other.id == id && other.hidden == hidden;
  }

  // @override
  // int get hashCode => Object.hash(id, hidden);
}
