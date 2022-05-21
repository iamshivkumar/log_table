import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/providers/color_provider.dart';
import 'package:log_table/providers/mode_provider.dart';
import 'package:log_table/ui/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(colorProvider);
    final scheme = ColorScheme.fromSeed(seedColor:color);
    final schemeDark = ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.dark,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Log Table',
      themeMode: ref.watch(modeProvider),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light
          ),
        ),
        useMaterial3: true,
        primaryColor: schemeDark.primary,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: schemeDark,
      ),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        useMaterial3: true,
        primaryColor: scheme.primary,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: scheme,
      ),
      home: const HomePage(),
    );
  }
}
