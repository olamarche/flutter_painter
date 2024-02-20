import 'package:flutter/foundation.dart';

import '../drawables/drawable.dart';

import '../painter_controller.dart';
import 'action.dart';
import 'add_drawables_action.dart';
import 'insert_drawables_action.dart';

class LowerBottomDrawablesAction extends ControllerAction<bool, bool> {
  final Drawable drawable;

  int? _removedIndex;

  LowerBottomDrawablesAction(this.drawable);

  @protected
  @override
  bool perform$(PainterController controller) {
    final value = controller.value;
    final currentDrawables = List<Drawable>.from(value.drawables);
    final index = currentDrawables.indexOf(drawable);
    if (index < 0) return false;
    _removedIndex = index;

    currentDrawables.removeAt(index);
    currentDrawables.insert(0, drawable);
    controller.value = value.copyWith(drawables: currentDrawables);

    return true;
  }

  @protected
  @override
  bool unperform$(PainterController controller) {
    final removedIndex = _removedIndex;
    if (removedIndex == null) return false;
    final value = controller.value;
    final currentDrawables = List<Drawable>.from(value.drawables);
    currentDrawables.removeAt(0);
    currentDrawables.insert(removedIndex, drawable);
    controller.value = value.copyWith(drawables: currentDrawables);
    _removedIndex = null;
    return true;
  }

  // @protected
  // @override
  // ControllerAction? merge$(ControllerAction previousAction) {
  //   if (previousAction is AddDrawablesAction &&
  //       previousAction.drawables.length == 1 &&
  //       previousAction.drawables.first == drawable) return null;
  //   if (previousAction is InsertDrawablesAction &&
  //       previousAction.drawables.length == 1 &&
  //       previousAction.drawables.first == drawable) return null;
  //   return super.merge$(previousAction);
  // }
}
