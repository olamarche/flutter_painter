import 'package:flutter/foundation.dart';

import '../drawables/object_drawable.dart';

import '../painter_controller.dart';
import 'action.dart';

class ClearSelectedDrawablesAction extends ControllerAction<void, void> {
  List<ObjectDrawable>? _removedDrawables;

  ClearSelectedDrawablesAction();

  /// be removed.
  @protected
  @override
  void perform$(PainterController controller) {
    final value = controller.value;
    _removedDrawables = List<ObjectDrawable>.from(value.selectedDrawables);
    controller.value = value.copyWith(
      selectedDrawables: [],
    );
  }

  @protected
  @override
  void unperform$(PainterController controller) {
    final removedDrawables = _removedDrawables;
    if (removedDrawables == null) return;
    final value = controller.value;
    controller.value = value.copyWith(selectedDrawables: removedDrawables);
    _removedDrawables = null;
  }

  @protected
  @override
  ControllerAction? merge$(ControllerAction previousAction) {
    return this;
  }
}
