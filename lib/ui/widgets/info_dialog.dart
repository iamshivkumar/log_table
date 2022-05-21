import 'package:flutter/material.dart';
import 'package:log_table/utils/assets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            const Spacer(),
            Container(
              decoration: ShapeDecoration(
                color: scheme.secondaryContainer,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                "Developed\nBy".toUpperCase(),
                style: style.bodySmall!
                    .copyWith(color: scheme.onSecondaryContainer),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 20,
              backgroundColor: scheme.secondaryContainer,
            ),
            const Spacer(),
            CircleAvatar(
              radius: 10,
              backgroundColor: scheme.secondaryContainer,
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 72,
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        color: scheme.surfaceVariant,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(56),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 72,
                          ),
                          Text(
                            "Shivkumar Konade",
                            textAlign: TextAlign.center,
                            style: style.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ElevatedButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(
                                      'https://www.buymeacoffee.com/shivkumarkonade'),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(8)),
                                backgroundColor: MaterialStateProperty.all(
                                    scheme.primaryContainer),
                              ),
                              child: SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: Image.asset(
                                  Assets.buyMeCoffee,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                            child: TextButton(
                              onPressed: () {
                                launchUrlString(
                                  'https://play.google.com/store/apps/details?id=com.logtable.app',
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: const Text('Give Feedback'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                            child: TextButton(
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      scheme.tertiary)),
                              onPressed: () {
                                String? encodeQueryParameters(
                                    Map<String, String> params) {
                                  return params.entries
                                      .map((e) =>
                                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                      .join('&');
                                }

                                final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: 'shivkumarkonade@gmail.com',
                                  query: encodeQueryParameters(<String, String>{
                                    'subject':
                                        'Raising an issue about Log Table app.',
                                  }),
                                );
                                launchUrl(
                                  emailLaunchUri,
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: const Text('Raise an Issue'),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                  ],
                ),
                CircleAvatar(
                  backgroundColor: scheme.surfaceVariant,
                  radius: 72,
                  child: CircleAvatar(
                    backgroundColor: scheme.surfaceVariant,
                    radius: 56,
                    backgroundImage: AssetImage(Assets.photo),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 12),
          ],
        ),
      ),
    );
  }
}
