import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_painter/src/controllers/events/selected_drawables_removed_event.dart';

import '../drawables/object_drawable.dart';

import '../events/events.dart';
import '../painter_controller.dart';
import 'action.dart';

class AddSelectedDrawablesAction extends ControllerAction<bool, bool> {
  final ObjectDrawable drawable;
  final StreamController<PainterEvent> eventsSteamController;

  AddSelectedDrawablesAction(this.drawable, this.eventsSteamController);

  @protected
  @override
  bool perform$(PainterController controller) {
    final value = controller.value;
    List<ObjectDrawable> currentSelectedDrawables = value.selectedDrawables;
    currentSelectedDrawables.add(drawable);
    controller.value =
        value.copyWith(selectedDrawables: currentSelectedDrawables);

    return true;
  }

  @protected
  @override
  bool unperform$(PainterController controller) {
    final value = controller.value;
    List<ObjectDrawable> currentSelectedDrawables = value.selectedDrawables;

    debugPrint('currentSelectedDrawables: ${currentSelectedDrawables.length}');
    currentSelectedDrawables.removeLast();

    controller.value =
        value.copyWith(selectedDrawables: currentSelectedDrawables);
    debugPrint(
        'after removeLast: ${controller.value.selectedDrawables.length}');
    eventsSteamController.add(const SelectedDrawablesRemovedEvent());

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
