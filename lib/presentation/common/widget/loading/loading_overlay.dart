import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _overlay;

  static void show(BuildContext context, {Color? backgroundColor}) {
    if (_overlay != null) return;

    _overlay = OverlayEntry(builder: (BuildContext context) {
      return Stack(
        children: [
          Container(
              color:
                  backgroundColor ?? Theme.of(context).scaffoldBackgroundColor),
          const Center(child: CircularProgressIndicator()),
        ],
      );
    });

    Overlay.of(context).insert(_overlay!);
  }

  static hide() {
    if (_overlay == null) return;
    _overlay!.remove();
    _overlay = null;
  }
}
