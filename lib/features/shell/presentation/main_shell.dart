import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/theme_mode_provider.dart';
import 'nav_destination.dart';

/// App shell with a 5-icon navigation rail fixed on the left.
class MainShell extends ConsumerWidget {
  const MainShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = NavDestination.indexForPath(location);
    final themeMode = ref.watch(themeModeProvider);

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
                  themeMode: themeMode,
                  onToggleTheme: () =>
                      ref.read(themeModeProvider.notifier).toggleDarkLight(),
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
  const _ShellAppBar({
    required this.title,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final String title;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.screenPadding(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
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
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.4),
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
              IconButton(
                tooltip: isDark ? 'Light mode' : 'Dark mode',
                onPressed: onToggleTheme,
                icon: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: AppColors.blue,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Theme.of(context).navigationRailTheme.backgroundColor,
      child: SafeArea(
        child: NavigationRail(
          extended: false,
          minWidth: AppSpacing.navRailWidth,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          leading: Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            child: const _LemonLogo(compact: true),
          ),
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
          trailing: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Icon(
              Icons.local_drink_rounded,
              color: AppColors.lemonYellow.withValues(
                alpha: isDark ? 0.9 : 1,
              ),
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

class _LemonLogo extends StatelessWidget {
  const _LemonLogo({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final lemon = Container(
      width: compact ? 44 : 52,
      height: compact ? 44 : 52,
      decoration: BoxDecoration(
        color: AppColors.lemonYellow,
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Icon(
        Icons.local_drink_rounded,
        color: AppColors.blue,
        size: 28,
      ),
    );

    if (compact) return lemon;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        lemon,
        const SizedBox(height: AppSpacing.xs),
        Text(
          '🍋',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
