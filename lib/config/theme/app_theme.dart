import 'package:flutter/material.dart';
const Color _miColor = Color(0xFF125067);

const List<Color> _colorThemes = [
  _miColor,
  Colors.blue,
  Colors.teal,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 1})
      : assert(selectedColor >= 0 && selectedColor < _colorThemes.length - 1);

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
    );
  }
}
