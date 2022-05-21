import 'package:flutter/material.dart';
import 'package:log_table/models/feature.dart';

import 'package:log_table/ui/antilog_page.dart';
import 'package:log_table/ui/inverse_page.dart';
import 'package:log_table/ui/log_cosines_page.dart';
import 'package:log_table/ui/log_page.dart';
import 'package:log_table/ui/log_sines_page.dart';
import 'package:log_table/ui/log_tangents_page.dart';
import 'package:log_table/ui/natural_tangents_page.dart';
import 'package:log_table/ui/sqrt_page.dart';
import 'package:log_table/ui/squares_page.dart';
import 'package:log_table/ui/widgets/info_dialog.dart';
import 'natural_cosines_page.dart';
import 'natural_sines_page.dart';
import 'sqrt2_page.dart';
import 'widgets/feature_card.dart';
import 'package:share_plus/share_plus.dart';

import 'widgets/theme_settings_dialog.dart';

class HomePage extends StatelessWidget {
  static const List<Feature> features = [
    Feature(
      name: "LOGARITHMS",
      widget: LogPage(),
      active: true,
    ),
    Feature(
      name: "ANTILOGARITHMS",
      widget: AntilogPage(),
      active: true,
    ),
    Feature(
      name: "NATURAL SINES",
      widget: NaturalSinesPage(),
      active: true,
    ),
    Feature(
      name: "NATURAL COSINES",
      widget: NaturalCosinesPage(),
      active: true,
    ),
    Feature(
      name: "NATURAL TANGENTS",
      widget: NaturalTangentsPage(),
      active: true,
    ),
    Feature(
      name: "LOGARITHMIC SINES",
      widget: LogSinesPage(),
      active: true,
    ),
    Feature(
      name: "LOGARITHMIC COSINES",
      widget: LogCosinesPage(),
      active: true,
    ),
    Feature(
      name: "LOGARITHMIC TANGENTS",
      widget: LogTangentsPage(),
      active: true,
    ),
    Feature(
      name: "SQUARES",
      widget: SquaresPage(),
      active: true,
      label: "NEW",
    ),
    Feature(
      name: "SQUARE ROOTS 1 - 10",
      widget: SqrtPage(),
      active: true,
      label: "NEW",
    ),
    Feature(
      name: "SQUARE ROOTS 10 - 100",
      widget: Sqrt2Page(),
      active: true,
      label: "NEW",
    ),
    Feature(
      name: "INVERSE",
      widget: InversePage(),
      active: true,
      label: "NEW",
    ),
  ];

  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share(
            'Log Table app is best app for Logarithmic and Mathematical Tables. Smooth ui, simple to use. User can select row, column and mean difference column and get answer easily. 9th, 10th, 11th Science, 12th Science and JEE, NEET and other entrance exams students can use this app as daily log table. Install now. https://play.google.com/store/apps/details?id=com.logtable.app',
          );
        },
        child: const Icon(Icons.share),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                "LOG TABLE",
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
              titlePadding: const EdgeInsets.all(16),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ThemeSettingsDialog(),
                  );
                },
                icon: scheme.brightness == Brightness.dark
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => InfoDialog(),
                  );
                },
                icon: const Icon(Icons.info_outline),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                features
                    .map(
                      (e) => FeatureCard(feature: e),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
