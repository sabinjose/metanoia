import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:confessionapp/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/lockout_timer_widget.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/pin_dots_display.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/pin_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lock screen that requires PIN or biometric authentication
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String _enteredPin = '';
  bool _hasError = false;
  bool _isVerifying = false;
  bool _hasAttemptedBiometric = false;

  @override
  void initState() {
    super.initState();
    // Schedule biometric check after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndTriggerBiometric();
    });
  }

  /// Check auth state and trigger biometric if conditions are met
  Future<void> _checkAndTriggerBiometric() async {
    if (_hasAttemptedBiometric || !mounted) return;

    final authState = ref.read(authControllerProvider);

    // If still loading, wait for it
    if (authState.isLoading) {
      // Wait a bit and try again
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        _checkAndTriggerBiometric();
      }
      return;
    }

    final state = authState.valueOrNull;
    if (state != null &&
        state.status == AuthStatus.locked &&
        state.biometricAvailable &&
        state.biometricEnabled) {
      _attemptBiometric();
    }
  }

  Future<void> _attemptBiometric() async {
    if (_hasAttemptedBiometric || !mounted) return;
    _hasAttemptedBiometric = true;

    final success =
        await ref.read(authControllerProvider.notifier).authenticateWithBiometric();
    if (!success && mounted) {
      // Biometric failed or cancelled, user can use PIN
    }
  }

  void _onDigitPressed(String digit) {
    if (_enteredPin.length >= 6 || _isVerifying) return;

    setState(() {
      _enteredPin += digit;
      _hasError = false;
    });

    if (_enteredPin.length == 6) {
      _verifyPin();
    }
  }

  void _onBackspacePressed() {
    if (_enteredPin.isEmpty || _isVerifying) return;

    setState(() {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      _hasError = false;
    });
  }

  Future<void> _verifyPin() async {
    setState(() => _isVerifying = true);

    final success =
        await ref.read(authControllerProvider.notifier).verifyPin(_enteredPin);

    if (!mounted) return;

    if (!success) {
      setState(() {
        _hasError = true;
        _enteredPin = '';
        _isVerifying = false;
      });
    }
    // If success, the auth state will update and this screen will be hidden
  }

  void _onLockoutExpired() {
    ref.read(authControllerProvider.notifier).checkLockoutExpired();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      data: (state) => _buildContent(context, theme, state),
      loading: () => _buildLoading(theme),
      error: (_, __) => _buildContent(context, theme, null),
    );
  }

  Widget _buildLoading(ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme, dynamic state) {
    final isLockedOut = state?.isLockedOut ?? false;
    final lockoutEndTime = state?.lockoutEndTime;
    final biometricAvailable = state?.biometricAvailable ?? false;
    final biometricEnabled = state?.biometricEnabled ?? false;
    final failedAttempts = state?.failedAttempts ?? 0;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // App icon and title
              _buildHeader(theme),
              const Spacer(),
              // Lockout timer or PIN entry
              if (isLockedOut && lockoutEndTime != null)
                LockoutTimerWidget(
                  lockoutEndTime: lockoutEndTime,
                  onLockoutExpired: _onLockoutExpired,
                ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9))
              else ...[
                // PIN dots
                PinDotsDisplay(
                  pinLength: _enteredPin.length,
                  error: _hasError,
                ),
                const SizedBox(height: 16),
                // Error message or attempts remaining
                if (_hasError)
                  Text(
                    failedAttempts >= 3
                        ? 'Incorrect PIN (${5 - failedAttempts} attempts remaining)'
                        : 'Incorrect PIN',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ).animate().shake(hz: 3, duration: 300.ms)
                else
                  const SizedBox(height: 20),
                const SizedBox(height: 32),
                // PIN keypad
                PinInputWidget(
                  onDigitPressed: _onDigitPressed,
                  onBackspacePressed: _onBackspacePressed,
                  onBiometricPressed:
                      biometricAvailable && biometricEnabled ? _attemptBiometric : null,
                  showBiometric: biometricAvailable && biometricEnabled,
                  enabled: !_isVerifying,
                ),
              ],
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_outline_rounded,
            size: 40,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Metanoia',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your PIN to unlock',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
