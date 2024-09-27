import '../drawable.dart';

/// Abstract class to define a drawable object to be used as a background.
abstract class BackgroundDrawable extends Drawable {
  const BackgroundDrawable({
    required String id,
    bool hidden = false,
  }) : super(id: id, hidden: hidden);
}
