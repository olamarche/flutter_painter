import 'package:flutter/material.dart';
import 'package:flutter_painter/src/controllers/settings/text_settings.dart';

import 'object_drawable.dart';

/// Text Drawable
class TextDrawable extends ObjectDrawable {
  final String text;
  final TextSettings textSettings;
  final TextDirection direction;

  // A text painter which will paint the text on the canvas.
  late final TextPainter textPainter;

  TextDrawable({
    required String id,
    required this.text,
    required Offset position,
    required this.textSettings,
    this.direction = TextDirection.ltr,
    double rotation = 0,
    double scale = 1,
    bool locked = false,
    bool hidden = false,
    Set<ObjectDrawableAssist> assists = const <ObjectDrawableAssist>{},
  }) : super(
          id: id,
          position: position,
          rotationAngle: rotation,
          scale: scale,
          assists: assists,
          locked: locked,
          hidden: hidden,
        ) {
    _initTextPainter();
  }

  void _initTextPainter() {
    textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textSettings.textStyle,
      ),
      textAlign: textSettings.textAlign,
      textDirection: direction,
      textScaleFactor: scale,
    );
  }

  @override
  void drawObject(Canvas canvas, Size size) {
    // Draw container background if specified
    if (textSettings.backgroundColor != null || textSettings.border != null) {
      final Paint backgroundPaint = Paint()
        ..color = textSettings.backgroundColor ?? Colors.transparent;

      final textSize = getSize(maxWidth: size.width * scale);
      final paddingToUse = textSettings.padding ?? EdgeInsets.zero;
      final rect = Rect.fromCenter(
        center: position,
        width: textSize.width + paddingToUse.horizontal,
        height: textSize.height + paddingToUse.vertical,
      );

      final RRect rrect =
          (textSettings.borderRadius ?? BorderRadius.zero).toRRect(rect);

      // Draw background
      canvas.drawRRect(rrect, backgroundPaint);

      // Draw border if specified
      if (textSettings.border != null) {
        textSettings.border!
            .paint(canvas, rect, borderRadius: textSettings.borderRadius);
      }
    }

    // Update and draw text
    _updateTextPainter();
    textPainter.layout(maxWidth: size.width * scale);

    // Apply padding offset if specified
    final Offset paddingOffset = textSettings.padding != null
        ? Offset(textSettings.padding!.left - textSettings.padding!.right,
                textSettings.padding!.top - textSettings.padding!.bottom) /
            2
        : Offset.zero;

    textPainter.paint(
      canvas,
      position -
          Offset(textPainter.width / 2, textPainter.height / 2) +
          paddingOffset,
    );
  }

  void _updateTextPainter() {
    textPainter.text = TextSpan(text: text, style: textSettings.textStyle);
    textPainter.textAlign = textSettings.textAlign;
    textPainter.textDirection = direction;
  }

  @override
  TextDrawable copyWith({
    String? id,
    String? text,
    Offset? position,
    TextSettings? textSettings,
    TextDirection? direction,
    double? rotation,
    double? scale,
    bool? locked,
    bool? hidden,
    Set<ObjectDrawableAssist>? assists,
  }) {
    return TextDrawable(
      id: id ?? this.id,
      text: text ?? this.text,
      position: position ?? this.position,
      textSettings: textSettings ?? this.textSettings,
      direction: direction ?? this.direction,
      rotation: rotation ?? rotationAngle,
      scale: scale ?? this.scale,
      locked: locked ?? this.locked,
      hidden: hidden ?? this.hidden,
      assists: assists ?? this.assists,
    );
  }

  @override
  Size getSize({double minWidth = 0.0, double maxWidth = double.infinity}) {
    textPainter.layout(minWidth: minWidth, maxWidth: maxWidth * scale);
    return textPainter.size;
  }
}
