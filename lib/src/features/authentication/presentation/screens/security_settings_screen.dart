import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/pin_dots_display.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/pin_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Security settings screen for managing PIN and biometric authentication
class SecuritySettingsScreen extends ConsumerStatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  ConsumerState<SecuritySettingsScreen> createState() =>
      _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends ConsumerState<SecuritySettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Security'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: authState.when(
        data: (state) => _buildContent(context, theme, state),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Error loading settings')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme, dynamic state) {
    final biometricAvailable = state?.biometricAvailable ?? false;
    final biometricEnabled = state?.biometricEnabled ?? false;
    final backgroundTimeout = state?.backgroundTimeout ?? const Duration(seconds: 15);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Biometric section
        if (biometricAvailable) ...[
          _buildSectionHeader(theme, 'Biometric Authentication'),
          const SizedBox(height: 8),
          _buildBiometricCard(theme, biometricEnabled),
          const SizedBox(height: 24),
        ],

        // Auto-lock section
        _buildSectionHeader(theme, 'Auto-Lock'),
        const SizedBox(height: 8),
        _buildTimeoutCard(theme, backgroundTimeout),
        const SizedBox(height: 24),

        // PIN management section
        _buildSectionHeader(theme, 'PIN Management'),
        const SizedBox(height: 8),
        _buildChangePinCard(theme),
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBiometricCard(ThemeData theme, bool enabled) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: SwitchListTile(
        title: const Text('Use Biometric Unlock'),
        subtitle: const Text('Unlock with fingerprint or face'),
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.fingerprint_rounded,
            color: theme.colorScheme.primary,
          ),
        ),
        value: enabled,
        onChanged: (value) async {
          HapticUtils.lightImpact();
          await ref.read(authControllerProvider.notifier).setBiometricEnabled(value);
        },
      ),
    );
  }

  Widget _buildTimeoutCard(ThemeData theme, Duration currentTimeout) {
    final timeoutOptions = [
      (const Duration(seconds: 15), '15 seconds'),
      (const Duration(seconds: 30), '30 seconds'),
      (const Duration(minutes: 1), '1 minute'),
      (const Duration(minutes: 5), '5 minutes'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.timer_outlined,
                color: theme.colorScheme.secondary,
              ),
            ),
            title: const Text('Lock After'),
            subtitle: const Text('Time in background before locking'),
          ),
          const Divider(height: 1),
          ...timeoutOptions.map((option) {
            final (duration, label) = option;

            return RadioListTile<Duration>(
              title: Text(label),
              value: duration,
              groupValue: currentTimeout,
              onChanged: (value) async {
                if (value != null) {
                  HapticUtils.lightImpact();
                  await ref
                      .read(authControllerProvider.notifier)
                      .setBackgroundTimeout(value);
                }
              },
              activeColor: theme.colorScheme.primary,
              dense: true,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChangePinCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.pin_outlined,
            color: theme.colorScheme.tertiary,
          ),
        ),
        title: const Text('Change PIN'),
        subtitle: const Text('Update your security PIN'),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () => _showChangePinDialog(context, theme),
      ),
    );
  }

  Future<void> _showChangePinDialog(BuildContext context, ThemeData theme) async {
    HapticUtils.lightImpact();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _ChangePinSheet(),
    );
  }
}

/// Bottom sheet for changing PIN
class _ChangePinSheet extends ConsumerStatefulWidget {
  const _ChangePinSheet();

  @override
  ConsumerState<_ChangePinSheet> createState() => _ChangePinSheetState();
}

class _ChangePinSheetState extends ConsumerState<_ChangePinSheet> {
  String _currentPin = '';
  String _newPin = '';
  String _confirmPin = '';
  int _step = 0; // 0: current, 1: new, 2: confirm
  bool _hasError = false;
  String _errorMessage = '';
  bool _isProcessing = false;

  void _onDigitPressed(String digit) {
    if (_isProcessing) return;

    setState(() {
      _hasError = false;
      _errorMessage = '';

      switch (_step) {
        case 0:
          if (_currentPin.length < 6) {
            _currentPin += digit;
          }
          if (_currentPin.length == 6) {
            _step = 1;
          }
          break;
        case 1:
          if (_newPin.length < 6) {
            _newPin += digit;
          }
          if (_newPin.length == 6) {
            _step = 2;
          }
          break;
        case 2:
          if (_confirmPin.length < 6) {
            _confirmPin += digit;
          }
          if (_confirmPin.length == 6) {
            _verifyAndChange();
          }
          break;
      }
    });
  }

  void _onBackspacePressed() {
    if (_isProcessing) return;

    setState(() {
      _hasError = false;
      _errorMessage = '';

      switch (_step) {
        case 0:
          if (_currentPin.isNotEmpty) {
            _currentPin = _currentPin.substring(0, _currentPin.length - 1);
          }
          break;
        case 1:
          if (_newPin.isNotEmpty) {
            _newPin = _newPin.substring(0, _newPin.length - 1);
          } else {
            _step = 0;
            _currentPin = '';
          }
          break;
        case 2:
          if (_confirmPin.isNotEmpty) {
            _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
          } else {
            _step = 1;
            _newPin = '';
          }
          break;
      }
    });
  }

  Future<void> _verifyAndChange() async {
    if (_newPin != _confirmPin) {
      setState(() {
        _hasError = true;
        _errorMessage = 'PINs don\'t match';
        _confirmPin = '';
      });
      return;
    }

    setState(() => _isProcessing = true);

    final success = await ref
        .read(authControllerProvider.notifier)
        .changePin(_currentPin, _newPin);

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN changed successfully')),
      );
    } else {
      setState(() {
        _hasError = true;
        _errorMessage = 'Current PIN is incorrect';
        _currentPin = '';
        _newPin = '';
        _confirmPin = '';
        _step = 0;
        _isProcessing = false;
      });
    }
  }

  String get _currentPinDisplay {
    switch (_step) {
      case 0:
        return _currentPin;
      case 1:
        return _newPin;
      case 2:
        return _confirmPin;
      default:
        return '';
    }
  }

  String get _stepTitle {
    switch (_step) {
      case 0:
        return 'Enter Current PIN';
      case 1:
        return 'Enter New PIN';
      case 2:
        return 'Confirm New PIN';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                _stepTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Progress indicator
              _buildProgressIndicator(theme),
              const SizedBox(height: 24),
              // PIN dots
              PinDotsDisplay(
                pinLength: _currentPinDisplay.length,
                error: _hasError,
              ),
              const SizedBox(height: 12),
              // Error message
              if (_hasError)
                Text(
                  _errorMessage,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                )
              else
                const SizedBox(height: 20),
              const SizedBox(height: 24),
              // Keypad
              PinInputWidget(
                onDigitPressed: _onDigitPressed,
                onBackspacePressed: _onBackspacePressed,
                showBiometric: false,
                enabled: !_isProcessing,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProgressDot(theme, _step >= 0),
        _buildProgressLine(theme, _step >= 1),
        _buildProgressDot(theme, _step >= 1),
        _buildProgressLine(theme, _step >= 2),
        _buildProgressDot(theme, _step >= 2),
      ],
    );
  }

  Widget _buildProgressDot(ThemeData theme, bool isActive) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.outlineVariant,
      ),
    );
  }

  Widget _buildProgressLine(ThemeData theme, bool isActive) {
    return Container(
      width: 32,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: isActive
          ? theme.colorScheme.primary
          : theme.colorScheme.outlineVariant,
    );
  }
}
