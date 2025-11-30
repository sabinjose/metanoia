import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Guided examination view - one commandment at a time with horizontal navigation
class GuidedExaminationView extends ConsumerStatefulWidget {
  final List<CommandmentWithQuestions> data;
  final VoidCallback onFinish;
  final Function(String?) onAddCustomSin;

  const GuidedExaminationView({
    super.key,
    required this.data,
    required this.onFinish,
    required this.onAddCustomSin,
  });

  @override
  ConsumerState<GuidedExaminationView> createState() =>
      _GuidedExaminationViewState();
}

class _GuidedExaminationViewState extends ConsumerState<GuidedExaminationView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    HapticUtils.selectionClick();
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    if (_currentPage < widget.data.length - 1) {
      _goToPage(_currentPage + 1);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final selectedQuestions = ref.watch(examinationControllerProvider);

    return Column(
      children: [
        // Progress indicator
        _buildProgressHeader(context, theme, l10n),

        // Page view with commandments
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
              HapticUtils.selectionClick();
            },
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              final item = widget.data[index];
              return _CommandmentPage(
                item: item,
                selectedQuestions: selectedQuestions,
                onAddCustomSin: widget.onAddCustomSin,
              );
            },
          ),
        ),

        // Navigation buttons
        _buildNavigationBar(context, theme, l10n, selectedQuestions),
      ],
    );
  }

  Widget _buildProgressHeader(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final progress = ((_currentPage + 1) / widget.data.length);
    final currentItem = widget.data[_currentPage];

    // Get selected count for current commandment
    final selectedQuestions = ref.watch(examinationControllerProvider);
    final selectedInSection = _getSelectedCountForItem(currentItem, selectedQuestions);
    final totalInSection = currentItem.questions.length + currentItem.customSins.length;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Commandment title and progress text
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentItem.isGeneral
                          ? l10n.noCommandment
                          : currentItem.commandment?.customTitle ??
                              '${l10n.commandment} ${currentItem.commandment?.commandmentNo}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    if (!currentItem.isGeneral &&
                        currentItem.commandment?.content != null &&
                        currentItem.commandment?.customTitle != currentItem.commandment?.content)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          currentItem.commandment!.content,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Progress badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  l10n.commandmentProgress(
                    _currentPage + 1,
                    widget.data.length,
                  ),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // Selected count for this section
          if (selectedInSection > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$selectedInSection / $totalInSection ${l10n.selected(selectedInSection)}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildNavigationBar(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
    Map<int, String> selectedQuestions,
  ) {
    final isFirstPage = _currentPage == 0;
    final isLastPage = _currentPage == widget.data.length - 1;
    final hasSelections = selectedQuestions.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Previous button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isFirstPage ? null : _previousPage,
                icon: const Icon(Icons.chevron_left),
                label: Text(l10n.previousCommandment),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Next / Finish button
            Expanded(
              child: isLastPage
                  ? FilledButton.icon(
                      onPressed: hasSelections ? widget.onFinish : null,
                      icon: const Icon(Icons.check),
                      label: Text(l10n.finishExamination),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    )
                  : FilledButton.icon(
                      onPressed: _nextPage,
                      icon: const Icon(Icons.chevron_right),
                      label: Text(l10n.nextCommandment),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  int _getSelectedCountForItem(
    CommandmentWithQuestions item,
    Map<int, String> selectedQuestions,
  ) {
    int count = 0;
    // Count selected standard questions
    for (final q in item.questions) {
      if (selectedQuestions.containsKey(q.id)) count++;
    }
    // Count selected custom sins (negative IDs)
    for (final s in item.customSins) {
      if (selectedQuestions.containsKey(-s.id)) count++;
    }
    return count;
  }
}

/// Individual commandment page with questions
class _CommandmentPage extends ConsumerWidget {
  final CommandmentWithQuestions item;
  final Map<int, String> selectedQuestions;
  final Function(String?) onAddCustomSin;

  const _CommandmentPage({
    required this.item,
    required this.selectedQuestions,
    required this.onAddCustomSin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allItems = <Widget>[];

    // Standard questions
    for (int i = 0; i < item.questions.length; i++) {
      final q = item.questions[i];
      final isSelected = selectedQuestions.containsKey(q.id);
      allItems.add(
        _QuestionTile(
          question: q.question,
          isSelected: isSelected,
          isCustom: false,
          onTap: () {
            HapticUtils.selectionClick();
            final controller = ref.read(examinationControllerProvider.notifier);
            if (isSelected) {
              controller.unselectQuestion(q.id);
            } else {
              controller.selectQuestion(q.id, q.question);
            }
          },
        ),
      );
    }

    // Custom sins
    for (final customSin in item.customSins) {
      final customSinId = -customSin.id;
      final isSelected = selectedQuestions.containsKey(customSinId);
      allItems.add(
        _QuestionTile(
          question: customSin.sinText,
          isSelected: isSelected,
          isCustom: true,
          onTap: () {
            HapticUtils.selectionClick();
            final controller = ref.read(examinationControllerProvider.notifier);
            if (isSelected) {
              controller.unselectQuestion(customSinId);
            } else {
              controller.selectQuestion(customSinId, customSin.sinText);
            }
          },
        ),
      );
    }

    // Add your own (only for commandments 1-11)
    if (_shouldShowAddYourOwn(item)) {
      allItems.add(
        _AddYourOwnTile(
          onTap: () => onAddCustomSin(
            item.isGeneral ? null : item.commandment?.code,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: allItems.length,
      itemBuilder: (context, index) {
        return allItems[index]
            .animate()
            .fadeIn(delay: (30 * index).ms)
            .slideX(begin: 0.05, end: 0);
      },
    );
  }

  bool _shouldShowAddYourOwn(CommandmentWithQuestions item) {
    if (item.isGeneral) return true;
    final commandmentNo = item.commandment?.commandmentNo;
    if (commandmentNo == null) return false;
    return commandmentNo <= 11;
  }
}

class _QuestionTile extends StatelessWidget {
  final String question;
  final bool isSelected;
  final bool isCustom;
  final VoidCallback onTap;

  const _QuestionTile({
    required this.question,
    required this.isSelected,
    required this.isCustom,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: isSelected
          ? (isCustom
              ? theme.colorScheme.secondaryContainer.withValues(alpha: 0.5)
              : theme.colorScheme.primaryContainer.withValues(alpha: 0.5))
          : theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? (isCustom
                  ? theme.colorScheme.secondary.withValues(alpha: 0.5)
                  : theme.colorScheme.primary.withValues(alpha: 0.5))
              : theme.colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: isSelected
                    ? (isCustom
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.primary)
                    : theme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              const SizedBox(width: 12),
              if (isCustom) ...[
                Icon(
                  Icons.auto_awesome,
                  size: 16,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  question,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddYourOwnTile extends StatelessWidget {
  final VoidCallback onTap;

  const _AddYourOwnTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.secondary.withValues(alpha: 0.3),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: theme.colorScheme.secondary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.addYourOwn,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.secondary.withValues(alpha: 0.7),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
