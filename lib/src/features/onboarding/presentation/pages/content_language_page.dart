import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';

class ContentLanguagePage extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const ContentLanguagePage({super.key, required this.onNext});

  @override
  ConsumerState<ContentLanguagePage> createState() =>
      _ContentLanguagePageState();
}

class _ContentLanguagePageState extends ConsumerState<ContentLanguagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final contentLanguage = ref.watch(contentLanguageControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder:
            (context, child) => FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(position: _slideAnimation, child: child),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),

            // Icon with elevated background
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.15),
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
            ),

            const SizedBox(height: 12),

            // Subtitle
            Container(
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

            const SizedBox(height: 48),

            // Language Options
            contentLanguage.when(
              data:
                  (selectedLanguage) => Column(
                    children: [
                      _LanguageOption(
                        label: 'English',
                        locale: const Locale('en'),
                        isSelected: selectedLanguage.languageCode == 'en',
                        onTap: () {
                          ref
                              .read(contentLanguageControllerProvider.notifier)
                              .setLanguage(const Locale('en'));
                        },
                      ),
                      const SizedBox(height: 16),
                      _LanguageOption(
                        label: 'മലയാളം',
                        locale: const Locale('ml'),
                        isSelected: selectedLanguage.languageCode == 'ml',
                        onTap: () {
                          ref
                              .read(contentLanguageControllerProvider.notifier)
                              .setLanguage(const Locale('ml'));
                        },
                      ),
                    ],
                  ),
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
            ),

            const Spacer(flex: 3),

            // Continue Button
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 400),
              child: FilledButton(
                onPressed: widget.onNext,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                  shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
                ),
                child: Text(
                  l10n.continueButton,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
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
