import 'dart:async';

import 'package:flutter/foundation.dart';

import '../drawables/object_drawable.dart';

import '../events/events.dart';
import '../events/selected_drawables_removed_event.dart';
import '../painter_controller.dart';
import 'action.dart';

class RemoveSelectedDrawablesAction extends ControllerAction<void, void> {
  final ObjectDrawable drawable;
  int? _removedIndex;
  final StreamController<PainterEvent> eventsSteamController;

  RemoveSelectedDrawablesAction(this.drawable, this.eventsSteamController);

  @protected
  @override
  void perform$(PainterController controller) {
    final value = controller.value;
    List<ObjectDrawable> currentSelectedDrawables = value.selectedDrawables;
    final index = currentSelectedDrawables.indexOf(drawable);
    if (index < 0) return;

    currentSelectedDrawables.removeAt(index);
    _removedIndex = index;
    controller.value = value.copyWith(
      selectedDrawables: currentSelectedDrawables,
    );
  }

  @protected
  @override
  void unperform$(PainterController controller) {
    final removedIndex = _removedIndex;
    if (removedIndex == null) return;
    final value = controller.value;
    List<ObjectDrawable> currentSelectedDrawables = value.selectedDrawables;
    currentSelectedDrawables.insert(removedIndex, drawable);
    controller.value =
        value.copyWith(selectedDrawables: currentSelectedDrawables);
    eventsSteamController.add(const SelectedDrawablesRemovedEvent());
    _removedIndex = null;
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
