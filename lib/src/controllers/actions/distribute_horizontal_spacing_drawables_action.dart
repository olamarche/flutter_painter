import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../drawables/drawable.dart';
import '../drawables/object_drawable.dart';

import '../painter_controller.dart';
import 'action.dart';

class DistributeHorizontalSpacingDrawablesAction
    extends ControllerAction<void, void> {
  DistributeHorizontalSpacingDrawablesAction();

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
    double minDx = controller.leftX(fist);
    double maxDx = controller.rightX(fist);
    double sumWidth = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    currentSelectedDrawables.forEach((item) => {
          if (controller.leftX(item) < minDx) {minDx = controller.leftX(item)},
          if (controller.rightX(item) > maxDx)
            {maxDx = controller.rightX(item)},
          sumWidth += item.getSize().width,
        });
    double space = ((maxDx - minDx) - sumWidth).abs() /
        (currentSelectedDrawables.length - 1);
    double xAxis = 0;
    List<Drawable> newDrawables = currentDrawables;
    List<ObjectDrawable> newSelectedDrawables = [];

    for (int i = 0; i < currentSelectedDrawables.length - 1; i++) {
      final obj = currentSelectedDrawables[i];
      ObjectDrawable? prvObj = i > 0 ? currentSelectedDrawables[i - 1] : null;

      if (i == 0) {
        xAxis += (obj.getSize().width / 2);
      } else {
        xAxis +=
            (prvObj!.getSize().width / 2 + space + obj.getSize().width / 2);
      }

      final index = currentDrawables.indexOf(obj);
      final drawable = obj.copyWith(position: Offset(xAxis, obj.position.dy));

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
