import 'package:flutter/material.dart';

class Constants {
  static const String mode = 'mode';
  static const String dark = 'dark';
  static const String light = 'light';
  static const String system = 'system';
  static const String color = 'color';

  static const Map<String, Color> colors = {
    'red': Colors.red,
    'pink': Colors.pink,
    'purple': Colors.purple,
    'deepPurple': Colors.deepPurple,
    'indigo': Colors.indigo,
    'blue': Colors.blue,
    'lightBlue': Colors.lightBlue,
    'cyan': Colors.cyan,
    'teal': Colors.teal,
    'green': Colors.green,
    'lightGreen': Colors.lightGreen,
    'lime': Colors.lime,
    'yellow': Colors.yellow,
    'amber': Colors.amber,
    'orange': Colors.orange,
    'deepOrange': Colors.deepOrange,
    'brown': Colors.brown,
  };

  static Color seedColor(String key) => colors[key] ?? Colors.purple;

  static String getName(Color color) => colors.entries.where((element) => element.value==color).first.key;
}
