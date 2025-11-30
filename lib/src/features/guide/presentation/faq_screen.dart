import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FaqScreen extends ConsumerWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final faqsAsync = ref.watch(faqsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.faqTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: faqsAsync.when(
        data: (faqs) {
          if (faqs.isEmpty) {
            return EmptyState(
              icon: Icons.help_outline,
              title: l10n.noFaqContent,
              subtitle: l10n.noFaqContentDesc,
            ).animate().fadeIn().scale();
          }

          // Group FAQs by heading
          final groupedFaqs = <String, List<Faq>>{};
          for (final faq in faqs) {
            if (!groupedFaqs.containsKey(faq.heading)) {
              groupedFaqs[faq.heading] = [];
            }
            groupedFaqs[faq.heading]!.add(faq);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groupedFaqs.length,
            itemBuilder: (context, sectionIndex) {
              final heading = groupedFaqs.keys.elementAt(sectionIndex);
              final sectionFaqs = groupedFaqs[heading]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (sectionIndex > 0) const SizedBox(height: 24),
                  // Section heading
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            heading,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // FAQs in this section
                  ...sectionFaqs.asMap().entries.map((entry) {
                    final index = entry.key;
                    final faq = entry.value;
                    return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Q',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.copyWith(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimaryContainer,
                                          fontWeight: FontWeight.bold,
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      faq.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest
                                        .withValues(alpha: 0.3),
                                    border: Border(
                                      top: BorderSide(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.outlineVariant,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.secondaryContainer,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'A',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelMedium?.copyWith(
                                              color:
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onSecondaryContainer,
                                              fontWeight: FontWeight.bold,
                                              height: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          faq.content,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(height: 1.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: (100 * index).ms)
                        .slideY(begin: 0.1, end: 0);
                  }),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

final faqsProvider = FutureProvider<List<Faq>>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final contentLanguage = await ref.watch(
    contentLanguageControllerProvider.future,
  );
  return (db.select(db.faqs)
        ..where((tbl) => tbl.languageCode.equals(contentLanguage.languageCode))
        ..orderBy([(tbl) => OrderingTerm(expression: tbl.id)]))
      .get();
});
