import 'package:flutter/foundation.dart';

import '../drawables/object_drawable.dart';

import '../painter_controller.dart';
import 'action.dart';

class RemoveSelectedDrawablesAction extends ControllerAction<bool, bool> {
  final ObjectDrawable drawable;
  int? _removedIndex;

  RemoveSelectedDrawablesAction(this.drawable);

  @protected
  @override
  bool perform$(PainterController controller) {
    final value = controller.value;
    List<ObjectDrawable>? currentSelectedDrawables = value.selectedDrawables;
    final index = currentSelectedDrawables.indexOf(drawable);
    if (index < 0) return false;

    ///
    ///isMultiselect
    ///

    currentSelectedDrawables.removeAt(index);
    _removedIndex = index;
    controller.value = value.copyWith(
      selectedDrawables: currentSelectedDrawables,
    );

    return true;
  }

  @protected
  @override
  bool unperform$(PainterController controller) {
    final removedIndex = _removedIndex;
    if (removedIndex == null) return false;
    final value = controller.value;
    List<ObjectDrawable>? currentSelectedDrawables = value.selectedDrawables;
    currentSelectedDrawables.insert(removedIndex, drawable);
    controller.value =
        value.copyWith(selectedDrawables: currentSelectedDrawables);
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
