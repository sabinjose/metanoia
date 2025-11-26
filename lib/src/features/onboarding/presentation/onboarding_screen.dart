import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/welcome_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/content_language_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/features_overview_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/metanoia_intro_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    await ref
        .read(onboardingControllerProvider.notifier)
        .markOnboardingComplete();
    if (mounted) {
      context.go('/');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // Progress Bar
          if (_currentPage > 0)
            LinearProgressIndicator(
              value: _currentPage / (_totalPages - 1),
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),

          // Pages
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                MetanoiaIntroPage(onNext: _nextPage),
                WelcomePage(onNext: _nextPage),
                FeaturesOverviewPage(onComplete: _nextPage),
                ContentLanguagePage(onNext: _completeOnboarding),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
