import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart'
    show ReminderFrequency, reminderSettingsProvider;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/features/home/presentation/providers/quote_provider.dart';
import 'package:confessionapp/src/features/home/presentation/widgets/examination_cta_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ShowCaseWidget(
      blurValue: 1,
      enableAutoScroll: true,
      builder: (context) => const _HomeContent(),
      autoPlayDelay: const Duration(seconds: 3),
    );
  }
}

class _HomeContent extends ConsumerStatefulWidget {
  const _HomeContent();

  @override
  ConsumerState<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<_HomeContent> {
  final GlobalKey _examineKey = GlobalKey();
  final GlobalKey _confessKey = GlobalKey();
  final GlobalKey _prayersKey = GlobalKey();
  final GlobalKey _guideKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if we came from tutorial reset
    final state = GoRouterState.of(context);
    if (state.uri.queryParameters['tutorial_reset'] == 'true') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startTutorial();
      });
    }
  }

  Future<void> _checkAndShowTutorial() async {
    final controller = ref.read(tutorialControllerProvider.notifier);
    final shouldShow = await controller.shouldShowHomeTutorial();

    if (shouldShow && mounted) {
      _startTutorial();
      await controller.markHomeTutorialShown();
    }
  }

  void _startTutorial() {
    if (!mounted) return;
    // ignore: deprecated_member_use
    ShowCaseWidget.of(context).startShowCase([
      _examineKey,
      _confessKey,
      _prayersKey,
      _guideKey,
    ]);
  }

  Future<void> _onRefresh() async {
    HapticUtils.lightImpact();
    // Get the current content language
    final contentLanguageAsync = ref.read(contentLanguageControllerProvider);
    final locale =
        contentLanguageAsync.valueOrNull ?? Localizations.localeOf(context);
    // Invalidate the quote provider to fetch a new random quote
    ref.invalidate(randomQuoteProvider(locale));
    // Wait a bit for the animation to feel natural
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            color: theme.colorScheme.primary,
            child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.appTitle,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings_outlined),
                            onPressed: () {
                              HapticUtils.lightImpact();
                              context.push('/settings');
                            },
                            tooltip: l10n.settingsTitle,
                          ),
                        ],
                      ).animate().fadeIn(),
                      const SizedBox(height: 32),
                      _DailyQuoteCard(theme: theme),
                      const SizedBox(height: 24),
                      const ExaminationCtaCard(),
                      const SizedBox(height: 24),
                      Text(
                        l10n.quickActions,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 16),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _LastConfessionCard(theme: theme)),
                            const SizedBox(width: 16),
                            Expanded(child: _NextReminderCard(theme: theme)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _PendingPenancesCard(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    AppShowcase(
                      showcaseKey: _examineKey,
                      title: l10n.examineTitle,
                      description: l10n.tutorialExamineDesc,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      currentStep: 1,
                      totalSteps: 4,
                      child: _HomeCard(
                        icon: Icons.assignment_outlined,
                        label: l10n.examineTitle,
                        onTap: () => context.go('/examine'),
                        color: theme.colorScheme.primaryContainer,
                        textColor: theme.colorScheme.onPrimaryContainer,
                        delay: 300.ms,
                      ),
                    ),
                    AppShowcase(
                      showcaseKey: _confessKey,
                      title: l10n.confessTitle,
                      description: l10n.tutorialConfessDesc,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      currentStep: 2,
                      totalSteps: 4,
                      child: _HomeCard(
                        icon: Icons.church_outlined,
                        label: l10n.confessTitle,
                        onTap: () => context.go('/confess'),
                        color: theme.colorScheme.secondaryContainer,
                        textColor: theme.colorScheme.onSecondaryContainer,
                        delay: 400.ms,
                      ),
                    ),
                    AppShowcase(
                      showcaseKey: _prayersKey,
                      title: l10n.prayersTitle,
                      description: l10n.tutorialPrayersDesc,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      currentStep: 3,
                      totalSteps: 4,
                      child: _HomeCard(
                        icon: Icons.menu_book_outlined,
                        label: l10n.prayersTitle,
                        onTap: () => context.go('/guide/prayers'),
                        color: theme.colorScheme.tertiaryContainer,
                        textColor: theme.colorScheme.onTertiaryContainer,
                        delay: 500.ms,
                      ),
                    ),
                    AppShowcase(
                      showcaseKey: _guideKey,
                      title: l10n.guideTitle,
                      description: l10n.tutorialGuideDesc,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      currentStep: 4,
                      totalSteps: 4,
                      child: _HomeCard(
                        icon: Icons.help_outline,
                        label: l10n.guideTitle,
                        onTap: () => context.go('/guide'),
                        color: theme.colorScheme.surfaceContainerHighest,
                        textColor: theme.colorScheme.onSurfaceVariant,
                        delay: 600.ms,
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

class _DailyQuoteCard extends ConsumerWidget {
  const _DailyQuoteCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentLanguageAsync = ref.watch(contentLanguageControllerProvider);
    final locale =
        contentLanguageAsync.valueOrNull ?? Localizations.localeOf(context);
    final quoteAsync = ref.watch(randomQuoteProvider(locale));

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: quoteAsync.when(
        data: (quote) => Column(
          children: [
            Icon(
              Icons.format_quote,
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
              size: 32,
            ),
            const SizedBox(height: 16),
            Text(
              quote.quote,
              style: GoogleFonts.merriweather(
                color: theme.colorScheme.onPrimary,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              quote.author,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        loading: () => const SizedBox(
          height: 120,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
        error: (_, __) => const SizedBox(),
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95));
  }
}

class _HomeCard extends StatefulWidget {
  const _HomeCard({
    this.icon,
    this.customIcon,
    required this.label,
    required this.onTap,
    this.color,
    this.textColor,
    required this.delay,
  }) : assert(icon != null || customIcon != null);

  final IconData? icon;
  final Widget? customIcon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  final Duration delay;

  @override
  State<_HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<_HomeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    HapticUtils.lightImpact();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor =
        widget.color ?? theme.colorScheme.surfaceContainerHighest;
    final foregroundColor =
        widget.textColor ?? theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: widget.customIcon != null
                    ? null
                    : BoxDecoration(
                        color: foregroundColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                child: widget.customIcon ??
                    Icon(widget.icon, size: 32, color: foregroundColor),
              ),
              const SizedBox(height: 12),
              Text(
                widget.label,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: widget.delay).slideY(begin: 0.2, end: 0);
  }
}

class _LastConfessionCard extends ConsumerWidget {
  const _LastConfessionCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final lastConfessionAsync = ref.watch(lastFinishedConfessionProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, color: theme.colorScheme.primary, size: 24),
            const SizedBox(height: 12),
            Text(
              l10n.lastConfession,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            lastConfessionAsync.when(
              data: (confession) {
                if (confession == null) {
                  return Text(
                    l10n.noneYet,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                final daysAgo =
                    DateTime.now().difference(confession.date).inDays;
                String timeText;
                if (daysAgo == 0) {
                  timeText = l10n.today;
                } else if (daysAgo == 1) {
                  timeText = l10n.yesterday;
                } else {
                  timeText = l10n.daysAgo(daysAgo);
                }
                return Text(
                  timeText,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              loading:
                  () => const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              error:
                  (_, __) => Text(l10n.error, style: theme.textTheme.bodySmall),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}

class _NextReminderCard extends ConsumerWidget {
  const _NextReminderCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final reminderSettings = ref.watch(reminderSettingsProvider);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          context.push(
            Uri(
              path: '/settings',
              queryParameters: {'scrollTo': 'reminders'},
            ).toString(),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: theme.colorScheme.secondary,
                  size: 24,
                  // ignore: deprecated_member_use
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.nextReminder,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                reminderSettings.when(
                  data: (config) {
                    if (config.frequency == ReminderFrequency.none) {
                      return Text(
                        l10n.off,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.outline,
                        ),
                      );
                    }

                    String text = '';
                    switch (config.frequency) {
                      case ReminderFrequency.weekly:
                        text = l10n.weekly;
                        break;
                      case ReminderFrequency.biweekly:
                        text = l10n.biweekly;
                        break;
                      case ReminderFrequency.monthly:
                        text = l10n.monthly;
                        break;
                      case ReminderFrequency.quarterly:
                        text = l10n.quarterly;
                        break;
                      case ReminderFrequency.none:
                        text = l10n.off;
                        break;
                    }

                    // Add day info
                    final days = [
                      l10n.mon,
                      l10n.tue,
                      l10n.wed,
                      l10n.thu,
                      l10n.fri,
                      l10n.sat,
                      l10n.sun,
                    ];
                    text += ' (${days[config.weekday - 1]})';

                    return Text(
                      text,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  loading:
                      () => const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  error:
                      (_, __) =>
                          Text(l10n.error, style: theme.textTheme.bodySmall),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 150.ms);
  }
}

class _PendingPenancesCard extends ConsumerWidget {
  const _PendingPenancesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final pendingPenancesAsync = ref.watch(pendingPenancesProvider);

    return pendingPenancesAsync.when(
      data: (penances) {
        // Don't show card if no pending penances
        if (penances.isEmpty) {
          return const SizedBox.shrink();
        }

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              HapticUtils.lightImpact();
              context.push('/confess/penance');
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.task_alt,
                      color: theme.colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.pendingPenances,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          penances.length == 1
                              ? penances.first.penance.description
                              : '${penances.length} ${l10n.pendingPenances.toLowerCase()}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
