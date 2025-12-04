import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/router/navigation_provider.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A CTA card that shows "Continue Examination" when there's an active draft.
/// Returns empty space when no draft exists.
class ExaminationCtaCard extends ConsumerStatefulWidget {
  const ExaminationCtaCard({super.key});

  @override
  ConsumerState<ExaminationCtaCard> createState() => _ExaminationCtaCardState();
}

class _ExaminationCtaCardState extends ConsumerState<ExaminationCtaCard>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Refresh when app resumes
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(activeExaminationDraftProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Listen to tab changes - when home tab (index 0) is selected, refresh the draft
    ref.listen(currentTabIndexProvider, (previous, current) {
      if (current == 0 && previous != 0) {
        // User navigated to home tab, refresh the draft provider
        ref.invalidate(activeExaminationDraftProvider);
      }
    });

    final draftAsync = ref.watch(activeExaminationDraftProvider);

    return draftAsync.when(
      data: (draft) {
        // Only show CTA when there's an active draft
        if (draft == null) return const SizedBox.shrink();

        return _CtaCardContent(
          itemCount: draft.itemCount,
          theme: theme,
          l10n: l10n,
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/examine');
          },
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _CtaCardContent extends StatelessWidget {
  const _CtaCardContent({
    required this.itemCount,
    required this.theme,
    required this.l10n,
    required this.onTap,
  });

  final int itemCount;
  final ThemeData theme;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;

    // Use secondary (gold) theme for continue action
    final backgroundColor = theme.colorScheme.secondaryContainer;
    final foregroundColor = theme.colorScheme.onSecondaryContainer;
    final accentColor = theme.colorScheme.secondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                backgroundColor,
                backgroundColor.withValues(alpha: isDark ? 0.7 : 0.85),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon with circular background
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: accentColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.continueExamination,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: foregroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.examinationProgress(itemCount),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: foregroundColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow indicator
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: accentColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1, end: 0);
  }
}
