import 'package:flutter/cupertino.dart';

class Feature {
  final String name;
  final String label;
  final Widget widget;
  final bool active;
  
  Feature({
    required this.name,
    required this.label,
    required this.widget,
    required this.active,
  });
}
