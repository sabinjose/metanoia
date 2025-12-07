import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';

class ContentLanguagePage extends ConsumerWidget {
  final VoidCallback onNext;

  const ContentLanguagePage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;
    final contentLanguage = ref.watch(contentLanguageControllerProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
              isDark
                  ? [
                    theme.colorScheme.primaryContainer,
                    theme.scaffoldBackgroundColor,
                    theme.scaffoldBackgroundColor,
                  ]
                  : [
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                    theme.scaffoldBackgroundColor,
                    theme.colorScheme.secondaryContainer.withValues(alpha: 0.2),
                  ],
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 24.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 1),

              // Icon with elevated background
              Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.15,
                            ),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.language,
                        size: 48,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.2,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  )
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 400.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: 40),

              // Title
              Text(
                    l10n.chooseContentLanguage,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate(delay: 150.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.1,
                    end: 0,
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 12),

              // Subtitle
              Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Text(
                        l10n.contentLanguageDescription,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  .animate(delay: 250.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.1,
                    end: 0,
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 48),

              // Language Options
              contentLanguage.when(
                data: (selectedLanguage) {
                  final languages =
                      LanguageConfig.supportedContentLanguages.entries.toList();
                  return Column(
                    children: [
                      for (int i = 0; i < languages.length; i++) ...[
                        if (i > 0) const SizedBox(height: 16),
                        _LanguageOption(
                              label: languages[i].value,
                              locale: Locale(languages[i].key),
                              isSelected: selectedLanguage.languageCode ==
                                  languages[i].key,
                              onTap: () {
                                HapticUtils.selectionClick();
                                ref
                                    .read(
                                      contentLanguageControllerProvider
                                          .notifier,
                                    )
                                    .setLanguage(Locale(languages[i].key));
                              },
                            )
                            .animate(delay: (350 + i * 100).ms)
                            .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                            .slideX(
                              begin: i.isEven ? -0.1 : 0.1,
                              end: 0,
                              duration: 350.ms,
                              curve: Curves.easeOut,
                            ),
                      ],
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text('Error loading language'),
              ),

              const SizedBox(height: 32),

              // Note
              Text(
                    l10n.changeAnytimeNote,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.7,
                      ),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate(delay: 550.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut),

              const Spacer(flex: 2),

              // Continue Button
              Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.25,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: FilledButton(
                      onPressed: () {
                        HapticUtils.mediumImpact();
                        onNext();
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        l10n.continueButton,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .animate(delay: 650.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.1,
                    end: 0,
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final Locale locale;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.locale,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              width: isSelected ? 2.5 : 1.5,
            ),
            borderRadius: BorderRadius.circular(20),
            color:
                isSelected
                    ? theme.colorScheme.primaryContainer.withValues(alpha: 0.5)
                    : theme.colorScheme.surface.withValues(alpha: 0.5),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ]
                    : [],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline,
                    width: 2,
                  ),
                  color:
                      isSelected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                ),
                child:
                    isSelected
                        ? Icon(
                          Icons.check,
                          size: 16,
                          color: theme.colorScheme.onPrimary,
                        )
                        : null,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color:
                      isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
