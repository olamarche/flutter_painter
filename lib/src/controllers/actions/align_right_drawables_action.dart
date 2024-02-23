import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../drawables/drawable.dart';
import '../drawables/object_drawable.dart';

import '../painter_controller.dart';
import 'action.dart';

class AlignRightDrawablesAction extends ControllerAction<void, void> {
  AlignRightDrawablesAction();

  List<ObjectDrawable>? _selectedDrawables;
  List<ObjectDrawable>? _currentDrawables;

  @protected
  @override
  void perform$(PainterController controller) {
    final value = controller.value;
    List<ObjectDrawable> currentSelectedDrawables = value.selectedDrawables;
    final currentDrawables =
        value.drawables.whereType<ObjectDrawable>().toList();

    _selectedDrawables = currentSelectedDrawables;
    _currentDrawables = currentDrawables;
    ObjectDrawable fist = currentSelectedDrawables.first;
    double maxDx = fist.position.dx + fist.getSize().width / 2;
    // ignore: avoid_function_literals_in_foreach_calls
    currentSelectedDrawables.forEach((item) => {
          if (item.position.dx + item.getSize().width / 2 > maxDx)
            {maxDx = item.position.dx + item.getSize().width / 2}
        });

    List<Drawable> newDrawables = currentDrawables;
    List<ObjectDrawable> newSelectedDrawables = [];
    for (var obj in currentSelectedDrawables) {
      ObjectDrawable drawable = obj.copyWith(
          position: Offset(maxDx - (obj.getSize().width / 2), obj.position.dy));

      final index = currentDrawables.indexOf(obj);

      if (index >= 0) {
        newDrawables[index] = drawable;
      }
      newSelectedDrawables.add(drawable);
    }

    controller.value = value.copyWith(
      drawables: newDrawables,
      selectedDrawables: newSelectedDrawables,
    );
  }

  @protected
  @override
  void unperform$(PainterController controller) {
    final selectedDrawables = _selectedDrawables;
    final currentDrawables = _currentDrawables;
    final value = controller.value;
    if (selectedDrawables != null && currentDrawables != null) {
      controller.value = value.copyWith(
        drawables: currentDrawables,
        selectedDrawables: selectedDrawables,
      );
    }
    _selectedDrawables = null;
    _currentDrawables = null;
  }

  // @protected
  // @override
  // ControllerAction? merge$(ControllerAction previousAction) {
  // }
}
