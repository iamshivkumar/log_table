import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/providers/cache_provider.dart';
import 'package:log_table/providers/color_provider.dart';
import 'package:log_table/providers/mode_provider.dart';
import 'package:log_table/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
  Provider((ref) => ThemeNotifier(ref));

class ThemeNotifier {
  final Ref _ref;

  ThemeNotifier(this._ref);

  SharedPreferences get _cache => _ref.read(cacheProvider).value!;

  void updateMode(String mode) async {
    if (mode == Constants.system) {
      await _cache.remove(Constants.mode);
    } else {
      await _cache.setString(Constants.mode, mode);
    }
    _ref.refresh(modeProvider);
  }

    void updateColor(Color color) async {
      await _cache.setString(Constants.color, Constants.getName(color));
    _ref.refresh(colorProvider);
  }
}
