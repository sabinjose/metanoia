import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart'
    show keepHistorySettingsProvider;
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final showLabel = screenWidth > 360;

              if (showLabel) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FilledButton.tonalIcon(
                    onPressed: () {
                      HapticUtils.lightImpact();
                      context.go('/confess/penance');
                    },
                    icon: const Icon(Icons.healing, size: 18),
                    label: Text(l10n.penance),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                );
              }
              return IconButton(
                icon: const Icon(Icons.healing),
                tooltip: l10n.penanceTracker,
                onPressed: () {
                  HapticUtils.lightImpact();
                  context.go('/confess/penance');
                },
              );
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
            return _EmptyConfessionView(l10n: l10n);
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
    return showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _PenanceInputDialog(l10n: l10n),
    );
  }
}

class _PenanceInputDialog extends StatefulWidget {
  final AppLocalizations l10n;

  const _PenanceInputDialog({required this.l10n});

  @override
  State<_PenanceInputDialog> createState() => _PenanceInputDialogState();
}

class _PenanceInputDialogState extends State<_PenanceInputDialog> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return AlertDialog(
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
            controller: _controller,
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
          onPressed: _hasText
              ? () => Navigator.pop(context, _controller.text.trim())
              : null,
          child: Text(l10n.savePenance),
        ),
      ],
    );
  }
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

class _EmptyConfessionView extends ConsumerWidget {
  final AppLocalizations l10n;

  const _EmptyConfessionView({required this.l10n});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final analyticsAsync = ref.watch(confessionAnalyticsProvider);
    final penancesAsync = ref.watch(pendingPenancesProvider);
    final historyAsync = ref.watch(finishedConfessionsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with icon and message
          _buildHeader(context, theme),
          const SizedBox(height: 24),

          // Start Examination Button
          FilledButton.icon(
            onPressed: () {
              HapticUtils.mediumImpact();
              context.go('/examine');
            },
            icon: const Icon(Icons.assignment_outlined),
            label: Text(l10n.startExamination),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
          const SizedBox(height: 24),

          // Analytics Summary (only if has data)
          analyticsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (analytics) {
              if (!analytics.hasData) return const SizedBox.shrink();
              return _buildAnalyticsSummary(context, theme, analytics);
            },
          ),

          // Pending Penances
          penancesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (penances) {
              if (penances.isEmpty) return const SizedBox.shrink();
              return _buildPendingPenances(context, theme, penances, ref);
            },
          ),

          // Recent History
          historyAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (history) {
              if (history.isEmpty) return const SizedBox.shrink();
              return _buildRecentHistory(context, theme, history);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline,
            size: 48,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.noActiveConfession,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.startExaminationPrompt,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ).animate().fadeIn().scale();
  }

  Widget _buildAnalyticsSummary(
    BuildContext context,
    ThemeData theme,
    ConfessionAnalytics analytics,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/confess/insights');
          },
          borderRadius: BorderRadius.circular(16),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.insights,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.insights,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatItem(
                          icon: Icons.church,
                          value: analytics.totalConfessions.toString(),
                          label: l10n.totalConfessions,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        child: _StatItem(
                          icon: Icons.calendar_today,
                          value: analytics.daysSinceLastConfession.toString(),
                          label: l10n.daysSinceLastConfession,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      Expanded(
                        child: _StatItem(
                          icon: Icons.local_fire_department,
                          value: '${analytics.currentStreakWeeks}',
                          label: l10n.currentStreak,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }

  Widget _buildPendingPenances(
    BuildContext context,
    ThemeData theme,
    List<PenanceWithConfession> penances,
    WidgetRef ref,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/confess/penance');
          },
          borderRadius: BorderRadius.circular(16),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: theme.colorScheme.error.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.checklist,
                          color: theme.colorScheme.error,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.pendingPenances,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${penances.length} pending',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Show first penance
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            penances.first.penance.description,
                            style: theme.textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.tonal(
                          onPressed: () async {
                            HapticUtils.mediumImpact();
                            await ref
                                .read(penanceRepositoryProvider)
                                .completePenance(penances.first.penance.id);
                            ref.invalidate(pendingPenancesProvider);
                          },
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Icon(Icons.check, size: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1);
  }

  Widget _buildRecentHistory(
    BuildContext context,
    ThemeData theme,
    List<ConfessionWithItems> history,
  ) {
    final recentHistory = history.take(3).toList();
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/confess/history');
          },
          borderRadius: BorderRadius.circular(16),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: theme.colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.viewHistory,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${history.length} total',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...recentHistory.map((confession) {
                    final date = confession.confession.finishedAt ??
                        confession.confession.date;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              dateFormat.format(date),
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          Text(
                            '${confession.items.length} items',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1);
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
