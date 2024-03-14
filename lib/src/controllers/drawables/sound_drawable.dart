import 'dart:io';
import 'dart:ui';

import 'package:flutter_painter/src/controllers/drawables/shape/shape_drawable.dart';
import 'package:flutter_painter/src/controllers/drawables/sized2ddrawable.dart';

import 'object_drawable.dart';

/// A drawable of an image as an object.
class SoundDrawable extends Sized2DDrawable implements ShapeDrawable {
  @override
  Paint paint;

  /// The image to be drawn.
  final File sound;

  /// Creates an [SoundDrawable] with the given [sound].
  SoundDrawable({
    Paint? paint,
    required Offset position,
    required Size size,
    double rotationAngle = 0,
    double scale = 1,
    Set<ObjectDrawableAssist> assists = const <ObjectDrawableAssist>{},
    Map<ObjectDrawableAssist, Paint> assistPaints =
        const <ObjectDrawableAssist, Paint>{},
    bool locked = false,
    bool hidden = false,
    required this.sound,
  })  : paint = paint ?? ShapeDrawable.defaultPaint,
        super(
            size: size,
            position: position,
            rotationAngle: rotationAngle,
            scale: scale,
            assists: assists,
            assistPaints: assistPaints,
            locked: locked,
            hidden: hidden);

  /// Creates an [SoundDrawable] with the given [sound], and calculates the scale based on the given [size].
  /// The scale will be calculated such that the size of the drawable fits into the provided size.
  ///
  /// For example, if the image was 512x256 and the provided size was 128x128, the scale would be 0.25,
  /// fitting the width of the image into the size (128x64).
  // SoundDrawable.fittedToSize({
  //   required Offset position,
  //   required Size size,
  //   double rotationAngle = 0,
  //   Set<ObjectDrawableAssist> assists = const <ObjectDrawableAssist>{},
  //   Map<ObjectDrawableAssist, Paint> assistPaints =
  //       const <ObjectDrawableAssist, Paint>{},
  //   bool locked = false,
  //   bool hidden = false,
  //   required File sound,
  // }) : this(
  //           position: position,
  //           rotationAngle: rotationAngle,
  //           scale: 1,
  //           assists: assists,
  //           assistPaints: assistPaints,
  //           sound: sound,
  //           hidden: hidden,
  //           locked: locked);

  /// Creates a copy of this but with the given fields replaced with the new values.
  @override
  SoundDrawable copyWith(
      {bool? hidden,
      Set<ObjectDrawableAssist>? assists,
      Offset? position,
      double? rotation,
      double? scale,
      Size? size,
      Paint? paint,
      File? sound,
      bool? locked}) {
    return SoundDrawable(
      hidden: hidden ?? this.hidden,
      assists: assists ?? this.assists,
      position: position ?? this.position,
      rotationAngle: rotation ?? rotationAngle,
      scale: scale ?? this.scale,
      size: size ?? this.size,
      paint: paint ?? this.paint,
      sound: sound ?? this.sound,
      locked: locked ?? this.locked,
    );
  }

  /// Draws the sound icon on the provided [canvas] of size [size].
  @override
  void drawObject(Canvas canvas, Size size) {
    // Draw the image onto the canvas.
    canvas.drawCircle(position, 20, paint);
  }

  /// Calculates the size of the rendered object.
  @override
  Size getSize({double minWidth = 0.0, double maxWidth = double.infinity}) {
    return Size(
      40 * scale,
      40 * scale,
    );
  }
}
