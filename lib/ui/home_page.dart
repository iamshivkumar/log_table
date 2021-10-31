import 'package:flutter/material.dart';
import 'package:log_table/models/feature.dart';
import 'package:log_table/ui/antilog_page.dart';
import 'package:log_table/ui/log_page.dart';
import 'natural_cosines_page.dart';
import 'natural_sines_page.dart';
import 'widgets/feature_card.dart';

class HomePage extends StatelessWidget {
  final List<Feature> features = [
    Feature(
      name: "LOGARITHMS",
      widget: LogPage(),
      active: true,
      label: "NEW",
    ),
    Feature(
      name: "ANTILOGARITHMS",
      widget: AntilogPage(),
      active: true,
      label: "NEW",
    ),
    Feature(
      name: "NATURAL SINES",
      widget: NaturalSinesPage(),
      active: true,
      label: "NEW",
    ),
    Feature(
      name: "NATURAL COSINES",
      widget: NaturalCosinesPage(),
      active: true,
      label: "COMING SOON",
    ),
    Feature(
      name: "NATURAL TANGENTS",
      widget: Scaffold(),
      active: false,
      label: "COMING SOON",
    ),
    Feature(
      name: "LOGARITHMIC SINES",
      widget: Scaffold(),
      active: false,
      label: "COMING SOON",
    ),
    Feature(
      name: "LOGARITHMIC COSINES",
      widget: Scaffold(),
      active: false,
      label: "COMING SOON",
    ),
    Feature(
      name: "LOGARITHMIC TANGENTS",
      widget: Scaffold(),
      active: false,
      label: "COMING SOON",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final style = theme.textTheme;
    // final scheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("LOG TABLE"),
              titlePadding: EdgeInsets.all(16),
            ),
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
