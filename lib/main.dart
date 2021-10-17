import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/ui/colors.dart';
import 'package:log_table/ui/home_page.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.mauve,
      systemNavigationBarDividerColor: AppColors.palePurplePantone,
    ));

    final theme = ThemeData.light();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Log Table',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: AppColors.mauve,
        backgroundColor: AppColors.palePurplePantone,
        primaryColorDark: AppColors.mediumOrchid,
        primaryColorLight: AppColors.palePurplePantone,
        primaryTextTheme: theme.primaryTextTheme.apply(
            bodyColor: AppColors.indigo,
            displayColor: AppColors.indigo,
            decorationColor: AppColors.indigo),
        shadowColor: AppColors.piggyPink,
        highlightColor: AppColors.mauvelous,
        colorScheme: theme.colorScheme.copyWith(
          primary: AppColors.mauve,
          primaryVariant: AppColors.mauve,
          secondaryVariant: AppColors.mustard,
          secondary: AppColors.blond,
          onSecondary: Colors.black,
          onPrimary: AppColors.indigo,
          background: AppColors.ivory,
        ),
      ),
      home: HomePage(),
    );
  }
}
