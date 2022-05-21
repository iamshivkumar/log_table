import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/color_provider.dart';
import '../../providers/mode_provider.dart';
import '../../providers/theme_notifier.dart';
import '../../utils/constants.dart';

class ThemeSettingsDialog extends ConsumerWidget {
  const ThemeSettingsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;
    final model = ref.read(themeNotifierProvider);
    final mode = ref.watch(modeProvider);
    final color = ref.watch(colorProvider);
    return Dialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(72)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Theme Settings",
                style: style.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [Constants.system, Constants.light, Constants.dark]
                    .map(
                      (e) => Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => model.updateMode(e),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                height: 56,
                                decoration: ShapeDecoration(
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  color:
                                      describeEnum(mode ?? ThemeMode.system) ==
                                              e
                                          ? scheme.primary
                                          : scheme.primaryContainer,
                                ),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.all(4),
                                  decoration: ShapeDecoration(
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    color: e == Constants.dark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  child: e == Constants.system
                                      ? Row(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              child: Container(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            Text(
                              e.toUpperCase(),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 5,
              children: Constants.colors.values
                  .map(
                    (e) => GestureDetector(
                      onTap: () => model.updateColor(e),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: e,
                            shape: BoxShape.circle,
                            border: color == e
                                ? Border.all(
                                    width: 4,
                                    color: scheme.onPrimaryContainer,
                                  )
                                : null),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
