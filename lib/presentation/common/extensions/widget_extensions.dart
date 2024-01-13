import 'package:flutter/material.dart';

extension WidgetExtensions on BuildContext {

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

}
