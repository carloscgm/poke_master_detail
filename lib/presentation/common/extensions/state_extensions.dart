import 'package:flutter/widgets.dart';

extension StateExtensions on State {
  void listenToProvider(ChangeNotifier changeNotifier, VoidCallback callback) {
    changeNotifier.addListener(() {
      if (!mounted) return;
      callback.call();
    });
  }
}
