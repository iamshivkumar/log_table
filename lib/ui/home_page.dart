import 'package:flutter/material.dart';
import 'package:log_table/models/feature.dart';
import 'package:log_table/ui/antilog_page.dart';
import 'package:log_table/ui/log_page.dart';

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
            flexibleSpace: FlexibleSpaceBar(
              title: Text("MATH TABLE"),
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

