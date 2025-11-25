import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.about)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 48),
            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/images/applogo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              l10n.appTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            // Version
            Text(
              '${l10n.version} 1.0.0',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 48),
            // Made with love
            Text(l10n.madeWithLove, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 32),
            // GitHub Link
            ListTile(
              leading: const Icon(Icons.code),
              title: Text(l10n.sourceCode),
              subtitle: Text(l10n.viewOnGithub),
              trailing: const Icon(Icons.open_in_new, size: 20),
              onTap:
                  () =>
                      _launchUrl('https://github.com/sabinjose/confessionapp'),
            ),
            const Divider(),
            // Licenses
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: const Text('Open Source Licenses'),
              trailing: const Icon(Icons.chevron_right),
              onTap:
                  () => showLicensePage(
                    context: context,
                    applicationName: l10n.appTitle,
                    applicationVersion: '1.0.0',
                    applicationIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/applogo.png',
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
