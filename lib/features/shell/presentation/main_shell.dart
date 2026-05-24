import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/spacing/app_spacing.dart';
import 'nav_destination.dart';

/// App shell with a 5-icon navigation rail fixed on the left.
class MainShell extends StatelessWidget {
  const MainShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = NavDestination.indexForPath(location);

    return Scaffold(
      body: Row(
        children: [
          _LemonNavRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              context.go(NavDestination.all[index].path);
            },
          ),
          Expanded(
            child: Column(
              children: [
                _ShellAppBar(
                  title: NavDestination.all[selectedIndex].label,
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShellAppBar extends StatelessWidget {
  const _ShellAppBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.screenPadding(context);

    return Material(
      color: AppColors.cream,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(padding, AppSpacing.sm, padding, 0),
          child: Row(
            children: [
              Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '·',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.slate.withValues(alpha: 0.4),
                    ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LemonNavRail extends StatelessWidget {
  const _LemonNavRail({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.creamSurface,
      child: SafeArea(
        child: NavigationRail(
          extended: false,
          minWidth: AppSpacing.navRailWidth,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            for (final dest in NavDestination.all)
              NavigationRailDestination(
                icon: Tooltip(
                  message: dest.label,
                  child: Icon(dest.icon),
                ),
                selectedIcon: Tooltip(
                  message: dest.label,
                  child: Icon(dest.selectedIcon),
                ),
                label: Text(dest.label),
              ),
          ],
        ),
      ),
    );
  }
}
