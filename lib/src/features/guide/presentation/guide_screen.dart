import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/guide/presentation/faq_screen.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';

class GuideScreen extends ConsumerWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final guideItemsAsync = ref.watch(guideItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.guideTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: guideItemsAsync.when(
        data: (guideItems) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                child: InkWell(
                  onTap: () {
                    HapticUtils.lightImpact();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FaqScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.question_answer,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Frequently Asked Questions',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fadeIn().slideY(begin: 0.1, end: 0),
              const SizedBox(height: 24),
              ...guideItems.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildSectionCard(
                    context,
                    entry.value.title,
                    _getIcon(context, entry.value.icon),
                    entry.value.content,
                  ).animate().fadeIn(delay: (100 * (entry.key + 1)).ms).slideY(begin: 0.1, end: 0),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _getIcon(BuildContext context, String iconName) {
    final color = Theme.of(context).colorScheme.primary;
    switch (iconName) {
      case 'church_outlined':
        return Icon(Icons.church_outlined, color: color);
      case 'favorite_outline':
        return Icon(Icons.favorite_outline, color: color);
      case 'check_circle_outline':
        return Icon(Icons.check_circle_outline, color: color);
      default:
        return Icon(Icons.info_outline, color: color);
    }
  }

  Widget _buildSectionCard(
    BuildContext context,
    String title,
    Widget icon,
    String content,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}

final guideItemsProvider = FutureProvider<List<GuideItem>>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final contentLanguage = await ref.watch(
    contentLanguageControllerProvider.future,
  );
  return (db.select(db.guideItems)
        ..where((tbl) => tbl.languageCode.equals(contentLanguage.languageCode))
        ..orderBy([(tbl) => OrderingTerm(expression: tbl.displayOrder)]))
      .get();
});
