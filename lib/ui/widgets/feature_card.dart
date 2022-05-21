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
    return AspectRatio(
      aspectRatio: 3.5,
      child: GestureDetector(
        onTap: () {
          if (feature.active) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => feature.widget,
              ),
            );
          }
        },
        child: Card(
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(56),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  feature.name,
                  style: style.headline6,
                ),
              ),
              if (!feature.active)
                Container(
                  color: theme.cardColor.withOpacity(0.5),
                ),
              if (feature.label != null)
                Positioned(
                  right: 0,
                  child: Material(
                    color: scheme.tertiary,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(56),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        feature.label!,
                        style:
                            style.overline!.copyWith(color: scheme.onPrimary),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
