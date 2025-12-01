import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/widgets/animated_count.dart';
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
import 'package:showcaseview/showcaseview.dart';

class ExaminationScreen extends ConsumerStatefulWidget {
  const ExaminationScreen({super.key});

  @override
  ConsumerState<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends ConsumerState<ExaminationScreen> {
  bool _hasShownRestoreSnackbar = false;

  // Showcase keys
  final GlobalKey _swipeKey = GlobalKey();
  final GlobalKey _selectKey = GlobalKey();
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

      // Check if tutorial should be shown
      _checkAndShowTutorial();
    });
  }

  Future<void> _checkAndShowTutorial() async {
    final tutorialController = ref.read(tutorialControllerProvider.notifier);
    final shouldShow = await tutorialController.shouldShowExaminationTutorial();
    if (shouldShow && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([
          _swipeKey,
          _selectKey,
          _finishKey,
        ]);
      });
      await tutorialController.markExaminationTutorialShown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final examinationDataAsync = ref.watch(examinationDataProvider);
    final selectedQuestions = ref.watch(examinationControllerProvider);

    return ShowCaseWidget(
      enableAutoScroll: true,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(l10n.examinationTitle),
          actions: [
            if (selectedQuestions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: AnimatedCountBadge(
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
                ),
              ).animate().fadeIn().scale(),
            PopupMenuButton<String>(
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
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'custom_sins',
                      child: Row(
                        children: [
                          const Icon(Icons.note_add),
                          const SizedBox(width: 8),
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
                                ? Theme.of(context).disabledColor
                                : null,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.clearDraft,
                            style: selectedQuestions.isEmpty
                                ? TextStyle(color: Theme.of(context).disabledColor)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
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
      ),
    );
  }

  Future<void> _finishExamination(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(examinationControllerProvider.notifier);
    await controller.saveConfession();
    // Invalidate the confession provider so it refreshes
    ref.invalidate(activeConfessionProvider);
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
