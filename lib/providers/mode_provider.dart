import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/utils/constants.dart';

import 'cache_provider.dart';

final modeProvider = Provider<ThemeMode?>((ref) {
  final cache = ref.watch(cacheProvider).asData?.value;
  final mode = cache?.getString(Constants.mode);
  return mode == Constants.dark
      ? ThemeMode.dark
      : mode == Constants.light
          ? ThemeMode.light
          : null;
});
