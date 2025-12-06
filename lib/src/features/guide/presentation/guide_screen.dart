import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GuideScreen extends ConsumerWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final guideItemsAsync = ref.watch(guideItemsProvider);
    final contentLanguageAsync = ref.watch(contentLanguageControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.guideTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: guideItemsAsync.when(
        data: (guideItems) {
          // Get content language localization for FAQ
          final contentLocale = contentLanguageAsync.valueOrNull;
          final contentL10n = contentLocale != null
              ? lookupAppLocalizations(contentLocale)
              : l10n;

          if (guideItems.isEmpty) {
            return EmptyState(
              icon: Icons.menu_book,
              title: l10n.noGuideContent,
              subtitle: l10n.noGuideContentDesc,
            ).animate().fadeIn().scale();
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // FAQ Card with content language
              _buildFaqCard(context, contentL10n, theme),
              const SizedBox(height: 16),
              // Guide items as expandable cards
              ...guideItems.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _GuideItemCard(
                    guideItem: entry.value,
                  ).animate().fadeIn(delay: (100 * (entry.key + 1)).ms).slideY(begin: 0.1, end: 0),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('${l10n.error}: $error')),
      ),
    );
  }

  Widget _buildFaqCard(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          context.push('/guide/faq');
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.question_answer,
                  size: 24,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.faqTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.faqSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }
}

class _GuideItemCard extends StatelessWidget {
  final GuideItem guideItem;

  const _GuideItemCard({required this.guideItem});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'church_outlined':
        return Icons.church_outlined;
      case 'favorite_outline':
        return Icons.favorite_outline;
      case 'check_circle_outline':
        return Icons.check_circle_outline;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: EdgeInsets.zero,
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconData(guideItem.icon),
              size: 24,
              color: theme.colorScheme.primary,
            ),
          ),
          title: Text(
            guideItem.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
              ),
              child: _buildFormattedContent(context, guideItem.content),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormattedContent(BuildContext context, String content) {
    final theme = Theme.of(context);
    final paragraphs = content.split('\n\n');

    if (paragraphs.length == 1) {
      // Single paragraph
      return Text(
        content,
        style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
      );
    }

    // Multiple paragraphs - add spacing between them
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.asMap().entries.map((entry) {
        final isLast = entry.key == paragraphs.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
          child: Text(
            entry.value,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
          ),
        );
      }).toList(),
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
