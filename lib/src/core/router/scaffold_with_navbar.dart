import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.homeTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.assignment_outlined),
            selectedIcon: const Icon(Icons.assignment),
            label: l10n.examineTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.church_outlined),
            selectedIcon: const Icon(Icons.church),
            label: l10n.confessTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.help_outline),
            selectedIcon: const Icon(Icons.help),
            label: l10n.guideTitle,
          ),
        ],
        backgroundColor: theme.colorScheme.surface,
        elevation: 3,
        shadowColor: Colors.black26,
        indicatorColor: theme.colorScheme.secondaryContainer,
      ),
    );
  }
}
