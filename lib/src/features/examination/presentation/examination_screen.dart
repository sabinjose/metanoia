import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';

class ExaminationScreen extends StatelessWidget {
  const ExaminationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ShowCaseWidget(
      blurValue: 1,
      builder: (context) => const _ExaminationContent(),
      autoPlayDelay: const Duration(seconds: 3),
    );
  }
}

class _ExaminationContent extends ConsumerStatefulWidget {
  const _ExaminationContent();

  @override
  ConsumerState<_ExaminationContent> createState() =>
      _ExaminationContentState();
}

class _ExaminationContentState extends ConsumerState<_ExaminationContent> {
  String _searchQuery = '';
  bool _hasShownRestoreSnackbar = false;
  final GlobalKey _searchKey = GlobalKey();
  final GlobalKey _checkKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Show snackbar after first frame if draft was restored
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(examinationControllerProvider.notifier);
      if (controller.isDraftRestored && !_hasShownRestoreSnackbar) {
        _hasShownRestoreSnackbar = true;
        final count = ref.read(examinationControllerProvider).length;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Restored $count question${count == 1 ? '' : 's'} from your last session',
            ),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Clear',
              onPressed: () async {
                await controller.clearDraft();
              },
            ),
          ),
        );
      }
      _checkAndShowTutorial();
    });
  }

  Future<void> _checkAndShowTutorial() async {
    final controller = ref.read(tutorialControllerProvider.notifier);
    final shouldShow = await controller.shouldShowExaminationTutorial();

    if (shouldShow && mounted) {
      // ignore: deprecated_member_use
      ShowCaseWidget.of(context).startShowCase([_searchKey, _checkKey]);
      await controller.markExaminationTutorialShown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final examinationDataAsync = ref.watch(examinationDataProvider);
    final selectedQuestions = ref.watch(examinationControllerProvider);
    final controller = ref.watch(examinationControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.examinationTitle),
        actions: [
          if (selectedQuestions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        l10n.selected(selectedQuestions.length),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (controller.lastSavedAt != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          _getTimeAgo(controller.lastSavedAt!),
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                  ],
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
                        title: const Text('Clear Draft?'),
                        content: const Text(
                          'This will remove all selected questions. Are you sure?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                );
                if (confirmed == true && context.mounted) {
                  await controller.clearDraft();
                }
              }
            },
            itemBuilder:
                (context) => [
                  if (selectedQuestions.isNotEmpty)
                    const PopupMenuItem(
                      value: 'clear',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline),
                          SizedBox(width: 8),
                          Text('Clear Draft'),
                        ],
                      ),
                    ),
                ],
          ),
          AppShowcase(
            showcaseKey: _checkKey,
            title: l10n.finishConfession,
            description: l10n.tutorialFinishDesc,
            shapeBorder: const CircleBorder(),
            currentStep: 2,
            totalSteps: 2,
            child: IconButton(
              icon: const Icon(Icons.check),
              onPressed:
                  selectedQuestions.isEmpty
                      ? null
                      : () async {
                        final controller = ref.read(
                          examinationControllerProvider.notifier,
                        );
                        await controller.saveConfession();
                        if (context.mounted) {
                          context.go('/confess');
                          // Clear the examination state after navigation
                          await controller.clearAfterSave();
                        }
                      },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppShowcase(
              showcaseKey: _searchKey,
              title: l10n.searchPlaceholder,
              description: l10n.tutorialSearchDesc,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              currentStep: 1,
              totalSteps: 2,
              child: TextField(
                decoration: InputDecoration(
                  hintText: l10n.searchPlaceholder,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon:
                      _searchQuery.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          // Examination list
          Expanded(
            child: examinationDataAsync.when(
              data: (data) {
                // Filter data based on search query
                final filteredData =
                    _searchQuery.isEmpty
                        ? data
                        : data.where((item) {
                          return item.commandment.content
                                  .toLowerCase()
                                  .contains(_searchQuery) ||
                              item.questions.any(
                                (q) => q.question.toLowerCase().contains(
                                  _searchQuery,
                                ),
                              );
                        }).toList();

                if (filteredData.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noResults,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final item = filteredData[index];
                    final commandmentQuestions = item.questions;
                    final selectedCount =
                        commandmentQuestions
                            .where((q) => selectedQuestions.containsKey(q.id))
                            .length;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 1,
                        ),
                      ),
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.commandment.customTitle ??
                                      '${l10n.commandment} ${item.commandment.commandmentNo}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (selectedCount > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '$selectedCount/${commandmentQuestions.length}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          subtitle:
                              (item.commandment.customTitle != null &&
                                      item.commandment.customTitle ==
                                          item.commandment.content)
                                  ? null
                                  : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      item.commandment.content,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                    ),
                                  ),
                          children:
                              commandmentQuestions.map((q) {
                                final isSelected = selectedQuestions
                                    .containsKey(q.id);
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      if (!isSelected) {
                                        ref
                                            .read(
                                              examinationControllerProvider
                                                  .notifier,
                                            )
                                            .selectQuestion(q.id, q.question);
                                      } else {
                                        ref
                                            .read(
                                              examinationControllerProvider
                                                  .notifier,
                                            )
                                            .unselectQuestion(q.id);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isSelected
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer
                                                    .withValues(alpha: 0.3)
                                                : null,
                                        border: Border(
                                          top: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outlineVariant
                                                .withValues(alpha: 0.5),
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2.0,
                                            ),
                                            child: Icon(
                                              isSelected
                                                  ? Icons.check_box
                                                  : Icons
                                                      .check_box_outline_blank,
                                              color:
                                                  isSelected
                                                      ? Theme.of(
                                                        context,
                                                      ).colorScheme.primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              q.question,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge?.copyWith(
                                                color:
                                                    isSelected
                                                        ? Theme.of(
                                                          context,
                                                        ).colorScheme.onSurface
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .onSurfaceVariant,
                                                fontWeight:
                                                    isSelected
                                                        ? FontWeight.w500
                                                        : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ).animate().fadeIn(delay: (50 * index).ms).slideY(begin: 0.1, end: 0);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (error, stack) =>
                      Center(child: Text('${l10n.error}: $error')),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Saved just now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return 'Saved $mins min${mins == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return 'Saved $hours hr${hours == 1 ? '' : 's'} ago';
    } else {
      final days = difference.inDays;
      return 'Saved $days day${days == 1 ? '' : 's'} ago';
    }
  }
}
