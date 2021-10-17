import 'package:flutter/material.dart';
import 'package:log_table/models/feature.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    Key? key,
    required this.feature,
  }) : super(key: key);
  final Feature feature;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 3,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => feature.widget,
              ),
            );
          },
          child: Container(
            decoration: ShapeDecoration(
              color: theme.primaryColor,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(56),
              ),
            ),
            child: Center(
              child: Text(
                feature.name,
                style: style.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}