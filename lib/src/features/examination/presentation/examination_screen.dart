import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/animated_count.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_screen.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/data/user_custom_sins_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/custom_sin_dialog.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/guided_examination_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ExaminationScreen extends StatelessWidget {
  const ExaminationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ShowCaseWidget(
      blurValue: 1,
      enableAutoScroll: true,
      builder: (context) => const _ExaminationContent(),
    );
  }
}

class _ExaminationContent extends ConsumerStatefulWidget {
  const _ExaminationContent();

  @override
  ConsumerState<_ExaminationContent> createState() => _ExaminationContentState();
}

class _ExaminationContentState extends ConsumerState<_ExaminationContent> {
  bool _hasShownRestoreSnackbar = false;
  bool _hasCheckedTutorial = false;
  bool _hasCheckedInvitationDialog = false;

  static const String _invitationShownKey = 'invitation_dialog_shown';
  static const String _invitationDontShowKey = 'invitation_dialog_dont_show';

  // Showcase keys
  final GlobalKey _swipeKey = GlobalKey();
  final GlobalKey _selectKey = GlobalKey();
  final GlobalKey _counterKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _finishKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Show snackbar after first frame if draft was restored
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(examinationControllerProvider.notifier);
      final l10n = AppLocalizations.of(context)!;
      if (controller.isDraftRestored && !_hasShownRestoreSnackbar) {
        _hasShownRestoreSnackbar = true;
        final count = ref.read(examinationControllerProvider).length;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.draftRestored(count)),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: l10n.clear,
              onPressed: () async {
                await controller.clearDraft();
              },
            ),
          ),
        );
      }

      // Check if we should show invitation dialog
      _checkAndShowInvitationDialog();
    });
  }

  Future<void> _checkAndShowInvitationDialog() async {
    if (_hasCheckedInvitationDialog) return;
    _hasCheckedInvitationDialog = true;

    final prefs = await SharedPreferences.getInstance();
    final dontShow = prefs.getBool(_invitationDontShowKey) ?? false;
    final hasShown = prefs.getBool(_invitationShownKey) ?? false;

    // Only show on first examination start and if not opted out
    if (!hasShown && !dontShow && mounted) {
      // Mark as shown
      await prefs.setBool(_invitationShownKey, true);

      // Small delay to let the screen settle
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        _showInvitationDialog();
      }
    }
  }

  void _showInvitationDialog() {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    bool dontShowAgain = false;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          icon: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite,
              color: theme.colorScheme.primary,
              size: 32,
            ),
          ),
          title: Text(
            l10n.invitationDialogTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppTheme.fontFamilyEBGaramond,
              fontSize: 24,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.invitationDialogContent,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: dontShowAgain,
                      onChanged: (value) {
                        setDialogState(() {
                          dontShowAgain = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setDialogState(() {
                          dontShowAgain = !dontShowAgain;
                        });
                      },
                      child: Text(
                        l10n.invitationDialogDontShowAgain,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton.icon(
                  onPressed: () async {
                    HapticUtils.lightImpact();
                    if (dontShowAgain) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(_invitationDontShowKey, true);
                    }
                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                      // Navigate to invitation screen
                      context.push('/guide/invitation');
                    }
                  },
                  icon: const Icon(Icons.favorite_outline),
                  label: Text(l10n.invitationDialogYes),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () async {
                    HapticUtils.lightImpact();
                    if (dontShowAgain) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(_invitationDontShowKey, true);
                    }
                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                    }
                  },
                  child: Text(l10n.invitationDialogNo),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkAndShowTutorial() async {
    if (_hasCheckedTutorial) return;
    _hasCheckedTutorial = true;

    final tutorialController = ref.read(tutorialControllerProvider.notifier);
    final shouldShow = await tutorialController.shouldShowExaminationTutorial();
    if (shouldShow && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // ignore: deprecated_member_use
          ShowCaseWidget.of(context).startShowCase([
            _swipeKey,
            _selectKey,
            _counterKey,
            _menuKey,
            _finishKey,
          ]);
        }
      });
      await tutorialController.markExaminationTutorialShown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final examinationDataAsync = ref.watch(examinationDataProvider);
    final selectedQuestions = ref.watch(examinationControllerProvider);

    // Check tutorial after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(l10n.examinationTitle),
          actions: [
            AppShowcase(
              showcaseKey: _counterKey,
              title: l10n.selected(0).split(' ').first,
              description: l10n.tutorialCounterDesc,
              currentStep: 3,
              totalSteps: 5,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: selectedQuestions.isNotEmpty
                    ? AnimatedCountBadge(
                        count: selectedQuestions.length,
                        label: l10n.selected(selectedQuestions.length),
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        textColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        textStyle:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ).animate().fadeIn().scale()
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '0 ${l10n.selectedLabel}',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
              ),
            ),
            AppShowcase(
              showcaseKey: _menuKey,
              title: l10n.quickActions,
              description: l10n.tutorialMenuDesc,
              currentStep: 4,
              totalSteps: 5,
              child: PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'clear') {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(l10n.clearDraftTitle),
                          content: Text(l10n.clearDraftMessage),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(l10n.cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(l10n.clear),
                            ),
                          ],
                        ),
                  );
                  if (confirmed == true && context.mounted) {
                    await ref.read(examinationControllerProvider.notifier).clearDraft();
                  }
                } else if (value == 'custom_sins') {
                  context.push('/examine/custom-sins');
                }
              },
              itemBuilder: (context) {
              final theme = Theme.of(context);
              return [
                PopupMenuItem(
                  value: 'custom_sins',
                  child: Row(
                    children: [
                      Icon(
                        Icons.note_add_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(l10n.manageCustomSins),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'clear',
                  enabled: selectedQuestions.isNotEmpty,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: selectedQuestions.isEmpty
                            ? theme.disabledColor
                            : theme.colorScheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.clearDraft,
                        style: selectedQuestions.isEmpty
                            ? TextStyle(color: theme.disabledColor)
                            : TextStyle(color: theme.colorScheme.error),
                      ),
                    ],
                  ),
                ),
              ];
            },
            ),
            ),
          ],
        ),
        body: examinationDataAsync.when(
          data: (data) => GuidedExaminationView(
            data: data,
            onFinish: () => _finishExamination(context, ref),
            onAddCustomSin: (commandmentCode) =>
                _showAddCustomSinDialog(context, commandmentCode),
            swipeShowcaseKey: _swipeKey,
            selectShowcaseKey: _selectKey,
            finishShowcaseKey: _finishKey,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('${l10n.error}: $error')),
        ),
      );
  }

  Future<void> _finishExamination(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(examinationControllerProvider.notifier);
    await controller.saveConfession();
    // Invalidate providers so home screen refreshes
    ref.invalidate(activeConfessionProvider);
    ref.invalidate(activeExaminationDraftProvider);
    if (context.mounted) {
      context.go('/confess');
      // Clear the examination state after navigation
      await controller.clearAfterSave();
    }
  }

  Future<void> _showAddCustomSinDialog(
    BuildContext context,
    String? commandmentCode,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final result = await showDialog<UserCustomSinsCompanion>(
      context: context,
      builder: (context) => CustomSinDialog(
        initialCommandmentCode: commandmentCode,
      ),
    );

    if (result != null && mounted) {
      try {
        final repository = ref.read(userCustomSinsRepositoryProvider);

        // Use the commandment code from the dialog result (user's selection)
        await repository.insertCustomSin(result);

        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(content: Text(l10n.customSinAdded)),
          );
          // Refresh the examination data
          ref.invalidate(examinationDataProvider);
        }
      } catch (e) {
        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(content: Text('${l10n.error}: $e')),
          );
        }
      }
    }
  }
}
