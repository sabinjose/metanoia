import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

part 'confession_screen.g.dart';

class ConfessionScreen extends ConsumerWidget {
  const ConfessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final confessionData = ref.watch(activeConfessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.confessTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            tooltip: l10n.penanceTracker,
            onPressed: () {
              HapticUtils.lightImpact();
              context.go('/confess/penance');
            },
          ),
          IconButton(
            icon: const Icon(Icons.insights),
            tooltip: l10n.insights,
            onPressed: () {
              HapticUtils.lightImpact();
              context.go('/confess/insights');
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: l10n.viewHistory,
            onPressed: () {
              HapticUtils.lightImpact();
              context.go('/confess/history');
            },
          ),
        ],
      ),
      body: confessionData.when(
        data: (data) {
          if (data == null || data.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.noActiveConfession,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.startExaminationPrompt,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: () {
                      HapticUtils.mediumImpact();
                      context.go('/examine');
                    },
                    icon: const Icon(Icons.assignment_outlined),
                    label: Text(l10n.startExamination),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().scale();
          }

          final items = data.items;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 12),
                          color: Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.secondaryContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${index + 1}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSecondaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      item.content,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: (100 * index).ms)
                        .slideX(begin: 0.1, end: 0);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text(l10n.finishConfessionTitle),
                                content: Text(l10n.finishConfessionContent),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(l10n.cancel),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Show delete confirmation
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder:
                                            (context) => AlertDialog(
                                              title: Text(
                                                l10n.deleteConfession,
                                              ),
                                              content: Text(
                                                l10n.deleteConfessionContent,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                        false,
                                                      ),
                                                  child: Text(l10n.cancel),
                                                ),
                                                FilledButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                        true,
                                                      ),
                                                  style: FilledButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.error,
                                                  ),
                                                  child: Text(
                                                    l10n.deleteConfession,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      );

                                      if (confirm == true) {
                                        await ref
                                            .read(confessionRepositoryProvider)
                                            .deleteConfession(
                                              data.confession.id,
                                            );
                                        ref.invalidate(
                                          activeConfessionProvider,
                                        );
                                        if (context.mounted) {
                                          Navigator.pop(
                                            context,
                                          ); // Close finish dialog
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Confession deleted',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                    child: Text(l10n.deleteConfession),
                                  ),
                                  FilledButton(
                                    onPressed: () async {
                                      Navigator.pop(context); // Close confirmation dialog

                                      // Show penance input dialog
                                      final penanceText = await _showPenanceInputDialog(
                                        context,
                                        l10n,
                                      );

                                      final keepHistory = await ref.read(
                                        keepHistorySettingsProvider.future,
                                      );
                                      await ref
                                          .read(confessionRepositoryProvider)
                                          .markConfessionAsFinished(
                                            data.confession.id,
                                            keepHistory: keepHistory,
                                          );

                                      // Save penance if provided
                                      if (penanceText != null && penanceText.isNotEmpty) {
                                        await ref
                                            .read(penanceRepositoryProvider)
                                            .addPenance(data.confession.id, penanceText);
                                        ref.invalidate(pendingPenancesProvider);
                                      }

                                      // Refresh the active confession state
                                      ref.invalidate(activeConfessionProvider);

                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              l10n.confessionCompletedMessage,
                                            ),
                                          ),
                                        );

                                        // Check for rating
                                        _checkAndRequestReview(context);
                                      }
                                    },
                                    child: Text(l10n.finish),
                                  ),
                                ],
                              ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.check),
                      label: Text(l10n.finishConfession),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('${l10n.error}: $error')),
      ),
    );
  }

  Future<void> _checkAndRequestReview(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final dontAsk = prefs.getBool('rate_app_dont_ask') ?? false;

    if (dontAsk) return;

    int count = prefs.getInt('confession_count') ?? 0;
    count++;
    await prefs.setInt('confession_count', count);

    if (count == 2 && context.mounted) {
      final l10n = AppLocalizations.of(context)!;
      final InAppReview inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(l10n.rateDialogTitle),
                content: Text(l10n.rateDialogContent),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await prefs.setBool('rate_app_dont_ask', true);
                      if (context.mounted) Navigator.pop(context);
                    },
                    child: Text(l10n.rateDialogNo),
                  ),
                  TextButton(
                    onPressed: () async {
                      await prefs.setInt(
                        'confession_count',
                        0,
                      ); // Reset to ask again later
                      if (context.mounted) Navigator.pop(context);
                    },
                    child: Text(l10n.rateDialogLater),
                  ),
                  FilledButton(
                    onPressed: () async {
                      await prefs.setBool('rate_app_dont_ask', true);
                      if (context.mounted) Navigator.pop(context);
                      inAppReview.requestReview();
                    },
                    child: Text(l10n.rateDialogYes),
                  ),
                ],
              ),
        );
      }
    }
  }

  Future<String?> _showPenanceInputDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController();

    return showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.checklist,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(l10n.addPenance),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.penanceDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: l10n.penanceHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text(l10n.skipPenance),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(l10n.savePenance),
          ),
        ],
      ),
    );
  }
}

class ConfessionWithItems {
  final Confession confession;
  final List<ConfessionItem> items;

  ConfessionWithItems(this.confession, this.items);
}

@riverpod
Future<ConfessionWithItems?> activeConfession(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);

  // Find the latest unfinished confession
  final confession =
      await (db.select(db.confessions)
            ..where((tbl) => tbl.isFinished.equals(false))
            ..orderBy([
              (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            ])
            ..limit(1))
          .getSingleOrNull();

  if (confession == null) return null;

  final items =
      await (db.select(db.confessionItems)
        ..where((tbl) => tbl.confessionId.equals(confession.id))).get();

  return ConfessionWithItems(confession, items);
}
