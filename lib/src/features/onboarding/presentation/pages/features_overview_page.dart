import 'package:flutter/material.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';

class FeaturesOverviewPage extends StatefulWidget {
  final VoidCallback onComplete;

  const FeaturesOverviewPage({super.key, required this.onComplete});

  @override
  State<FeaturesOverviewPage> createState() => _FeaturesOverviewPageState();
}

class _FeaturesOverviewPageState extends State<FeaturesOverviewPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _FeatureCard(
                icon: Icons.assignment_outlined,
                title: l10n.examineTitle,
                description: l10n.examineDescription,
                color: theme.colorScheme.primary,
              ),
              _FeatureCard(
                icon: Icons.church_outlined,
                title: l10n.confessTitle,
                description: l10n.confessDescription,
                color: theme.colorScheme.secondary,
              ),
              _FeatureCard(
                icon: Icons.menu_book_outlined,
                title: l10n.prayersTitle,
                description: l10n.prayersDescription,
                color: theme.colorScheme.tertiary,
              ),
              _FeatureCard(
                icon: Icons.notifications_outlined,
                title: l10n.reminders,
                description: l10n.remindersDescription,
                color: theme.colorScheme.error,
              ),
            ],
          ),
        ),

        // Page Indicators
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _totalPages,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),

        // Next/Get Started Button
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: FilledButton(
              onPressed: _nextPage,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(double.infinity, 0),
                elevation: 0,
              ),
              child: Text(
                _currentPage < _totalPages - 1
                    ? l10n.nextButton
                    : l10n.getStarted,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    this.icon,
    this.customIcon,
    required this.title,
    required this.description,
    required this.color,
  }) : assert(icon != null || customIcon != null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration:
                customIcon != null
                    ? BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    )
                    : BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
            child: customIcon ?? Icon(icon, size: 64, color: color),
          ),

          const SizedBox(height: 48),

          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Container(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Text(
              description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
