import 'package:flutter/material.dart';

extension AppTheme on ThemeData {
  Color get iconAndTextColor =>
      brightness == Brightness.dark ? Colors.white : Colors.black;
}
