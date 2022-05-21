import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/utils/constants.dart';

import 'cache_provider.dart';

final colorProvider = Provider<Color>((ref) {
  final cache = ref.watch(cacheProvider).asData?.value;
  final color = cache?.getString(Constants.color);
  return Constants.seedColor(color??'');
});
