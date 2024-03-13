import 'dart:io';
import 'dart:ui';

import 'object_drawable.dart';

/// A drawable of an image as an object.
class SoundDrawable extends ObjectDrawable {
  /// The image to be drawn.
  final File sound;

  /// Creates an [SoundDrawable] with the given [sound].
  SoundDrawable({
    required Offset position,
    double rotationAngle = 0,
    double scale = 1,
    Set<ObjectDrawableAssist> assists = const <ObjectDrawableAssist>{},
    Map<ObjectDrawableAssist, Paint> assistPaints =
        const <ObjectDrawableAssist, Paint>{},
    bool locked = false,
    bool hidden = false,
    required this.sound,
  }) : super(
            position: position,
            rotationAngle: rotationAngle,
            scale: scale,
            assists: assists,
            assistPaints: assistPaints,
            hidden: hidden,
            locked: locked);

  /// Creates an [SoundDrawable] with the given [sound], and calculates the scale based on the given [size].
  /// The scale will be calculated such that the size of the drawable fits into the provided size.
  ///
  /// For example, if the image was 512x256 and the provided size was 128x128, the scale would be 0.25,
  /// fitting the width of the image into the size (128x64).
  SoundDrawable.fittedToSize({
    required Offset position,
    required Size size,
    double rotationAngle = 0,
    Set<ObjectDrawableAssist> assists = const <ObjectDrawableAssist>{},
    Map<ObjectDrawableAssist, Paint> assistPaints =
        const <ObjectDrawableAssist, Paint>{},
    bool locked = false,
    bool hidden = false,
    required File sound,
  }) : this(
            position: position,
            rotationAngle: rotationAngle,
            scale: 1,
            assists: assists,
            assistPaints: assistPaints,
            sound: sound,
            hidden: hidden,
            locked: locked);

  /// Creates a copy of this but with the given fields replaced with the new values.
  @override
  SoundDrawable copyWith(
      {bool? hidden,
      Set<ObjectDrawableAssist>? assists,
      Offset? position,
      double? rotation,
      double? scale,
      File? sound,
      bool? locked}) {
    return SoundDrawable(
      hidden: hidden ?? this.hidden,
      assists: assists ?? this.assists,
      position: position ?? this.position,
      rotationAngle: rotation ?? rotationAngle,
      scale: scale ?? this.scale,
      sound: sound ?? this.sound,
      locked: locked ?? this.locked,
    );
  }

  /// Draws the sound icon on the provided [canvas] of size [size].
  @override
  void drawObject(Canvas canvas, Size size) {
    // Draw the image onto the canvas.
    canvas.drawCircle(Offset(400, 400), 20, Paint());
  }

  /// Calculates the size of the rendered object.
  @override
  Size getSize({double minWidth = 0.0, double maxWidth = double.infinity}) {
    return Size(
      40 * scale,
      40 * scale,
    );
  }

  /// Compares two [SoundDrawable]s for equality.
  // @override
  // bool operator ==(Object other) {
  //   return other is SoundDrawable &&
  //       super == other &&
  //       other.image == image;
  // }
  //
  // @override
  // int get hashCode => hashValues(
  //     hidden,
  //     hashList(assists),
  //     hashList(assistPaints.entries),
  //     position,
  //     rotationAngle,
  //     scale,
  //     image);

  // static double _calculateScaleFittedToSize(Image image, Size size) {
  //   if (image.width >= image.height) {
  //     return size.width / image.width;
  //   } else {
  //     return size.height / image.height;
  //   }
  // }
}
