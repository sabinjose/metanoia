import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A single feature page for onboarding
class FeaturePage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onNext;
  final String buttonText;

  const FeaturePage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onNext,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Icon container with enhanced animation
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
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
                child: Icon(icon, size: 64, color: color),
              )
                  .animate()
                  .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.2, end: 0, duration: 400.ms, curve: Curves.easeOut)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 400.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: 48),

              // Title with staggered animation
              Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              )
                  .animate(delay: 150.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.1, end: 0, duration: 350.ms, curve: Curves.easeOut),

              const SizedBox(height: 20),

              // Description with staggered animation
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
              )
                  .animate(delay: 250.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.1, end: 0, duration: 350.ms, curve: Curves.easeOut),

              const Spacer(flex: 3),

              // Next Button with staggered animation
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 400),
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
                    buttonText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              )
                  .animate(delay: 350.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.1, end: 0, duration: 350.ms, curve: Curves.easeOut),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
