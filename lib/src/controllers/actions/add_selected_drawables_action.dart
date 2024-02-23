import 'package:flutter/foundation.dart';

import '../drawables/object_drawable.dart';

import '../painter_controller.dart';
import 'action.dart';

class AddSelectedDrawablesAction extends ControllerAction<bool, bool> {
  final ObjectDrawable drawable;

  AddSelectedDrawablesAction(this.drawable);

  @protected
  @override
  bool perform$(PainterController controller) {
    ///
    ///isMultiselect
    ///
    final value = controller.value;
    List<ObjectDrawable> currentSelectedDrawables =
        List<ObjectDrawable>.from(value.selectedDrawables);
    currentSelectedDrawables.add(drawable);
    controller.value =
        value.copyWith(selectedDrawables: currentSelectedDrawables);

    return true;
  }

  @protected
  @override
  bool unperform$(PainterController controller) {
    final value = controller.value;
    List<ObjectDrawable>? currentSelectedDrawables = value.selectedDrawables;
    final index = currentSelectedDrawables.lastIndexOf(drawable);
    currentSelectedDrawables.removeAt(index);
    controller.value =
        value.copyWith(selectedDrawables: currentSelectedDrawables);

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
