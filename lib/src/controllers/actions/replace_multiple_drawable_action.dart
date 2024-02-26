import 'package:flutter/foundation.dart';

import '../drawables/object_drawable.dart';
import '../drawables/drawable.dart';

import '../painter_controller.dart';
import 'action.dart';
import 'add_drawables_action.dart';
import 'insert_drawables_action.dart';

class ReplaceMultipleDrawableAction extends ControllerAction<bool, bool> {
  final List<Drawable> oldDrawables;

  final List<Drawable> newDrawables;

  ReplaceMultipleDrawableAction(this.oldDrawables, this.newDrawables);

  @protected
  @override
  bool perform$(PainterController controller) {
    final value = controller.value;
    final currentDrawables = List<Drawable>.from(value.drawables);
    final selectedDrawables = controller.value.selectedDrawables;
    final selectedObject = controller.value.selectedObjectDrawable;

    final oldObjectDrawables = List<ObjectDrawable>.from(oldDrawables);
    final newObjectDrawables = List<ObjectDrawable>.from(newDrawables);

    for (int i = 0; i < oldDrawables.length - 1; i++) {
      final oldDrawableIndex = currentDrawables.indexOf(oldDrawables[i]);
      if (oldDrawableIndex < 0) {
        return false;
      }
      final isSelectedObject = oldDrawables[i] == selectedObject;
      currentDrawables
          .setRange(oldDrawableIndex, oldDrawableIndex + 1, [newDrawables[i]]);

      final oldSelectedDrawablesIndex =
          selectedDrawables.indexOf(oldObjectDrawables[i]);
      if (oldSelectedDrawablesIndex >= 0) {
        selectedDrawables.setRange(oldSelectedDrawablesIndex,
            oldSelectedDrawablesIndex + 1, [newObjectDrawables[i]]);
      }

      controller.value = value.copyWith(
        drawables: currentDrawables,
        selectedObjectDrawable: isSelectedObject
            ? newDrawables[i] is ObjectDrawable
                ? (newDrawables[i] as ObjectDrawable)
                : selectedObject
            : null,
        selectedDrawables: selectedDrawables,
      );
      if (isSelectedObject && newDrawables[i] is! ObjectDrawable) {
        controller.deselectObjectDrawable(isRemoved: true);
      }
    }

    return true;
  }

  /// Un-performs the action.
  @protected
  @override
  bool unperform$(PainterController controller) {
    final value = controller.value;
    final currentDrawables = List<Drawable>.from(value.drawables);
    final selectedDrawables = controller.value.selectedDrawables;
    final selectedObject = controller.value.selectedObjectDrawable;

    final oldObjectDrawables = List<ObjectDrawable>.from(oldDrawables);
    final newObjectDrawables = List<ObjectDrawable>.from(newDrawables);

    for (int i = 0; i < newDrawables.length - 1; i++) {
      final newDrawableIndex = value.drawables.indexOf(newDrawables[i]);
      if (newDrawableIndex < 0) {
        return false;
      }
      final isSelectedObject = newDrawables[i] == selectedObject;
      currentDrawables
          .setRange(newDrawableIndex, newDrawableIndex + 1, [oldDrawables[i]]);

      final newSelectedDrawablesIndex =
          selectedDrawables.indexOf(newObjectDrawables[i]);
      if (newSelectedDrawablesIndex >= 0) {
        selectedDrawables.setRange(newSelectedDrawablesIndex,
            newSelectedDrawablesIndex + 1, [oldObjectDrawables[i]]);
      }

      controller.value = value.copyWith(
        drawables: currentDrawables,
        selectedObjectDrawable: isSelectedObject
            ? oldDrawables[i] is ObjectDrawable
                ? (oldDrawables[i] as ObjectDrawable)
                : selectedObject
            : null,
        selectedDrawables: selectedDrawables,
      );
      if (isSelectedObject && oldDrawables[i] is! ObjectDrawable) {
        controller.deselectObjectDrawable(isRemoved: true);
      }
    }
    return true;
  }

  /// Merges [this] action and the [previousAction] into one action.
  /// Returns the result of the merge.
  ///
  /// If [previousAction] is an add, insert or replace action that acts on [oldDrawable], merging
  /// their effects is like performing [previousAction] on its own but with [newDrawable].
  /// Otherwise, the default behavior is used.
  @protected
  @override
  ControllerAction? merge$(ControllerAction previousAction) {
    for (int i = 0; i < newDrawables.length - 1; i++) {
      if (previousAction is AddDrawablesAction &&
          previousAction.drawables.last == oldDrawables[i]) {
        return AddDrawablesAction([...previousAction.drawables]
          ..removeLast()
          ..add(newDrawables[i]));
      }
      if (previousAction is InsertDrawablesAction &&
          previousAction.drawables.last == oldDrawables) {
        return InsertDrawablesAction(
            previousAction.index,
            [...previousAction.drawables]
              ..removeLast()
              ..add(newDrawables[i]));
      }
      if (previousAction is ReplaceMultipleDrawableAction &&
          previousAction.newDrawables == oldDrawables) {
        return ReplaceMultipleDrawableAction(
            previousAction.oldDrawables, newDrawables);
      }
    }

    return super.merge$(previousAction);
  }
}
