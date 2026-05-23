import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_routes.dart';

/// Single entry in the left navigation rail.
class NavDestination {
  const NavDestination({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  static const List<NavDestination> all = [
    NavDestination(
      path: AppRoutes.home,
      label: AppStrings.navHome,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
    ),
    NavDestination(
      path: AppRoutes.earnings,
      label: AppStrings.navEarnings,
      icon: Icons.paid_outlined,
      selectedIcon: Icons.paid_rounded,
    ),
    NavDestination(
      path: AppRoutes.coach,
      label: AppStrings.navCoach,
      icon: Icons.chat_bubble_outline_rounded,
      selectedIcon: Icons.chat_bubble_rounded,
    ),
    NavDestination(
      path: AppRoutes.goals,
      label: AppStrings.navGoals,
      icon: Icons.savings_outlined,
      selectedIcon: Icons.savings_rounded,
    ),
    NavDestination(
      path: AppRoutes.progress,
      label: AppStrings.navProgress,
      icon: Icons.emoji_events_outlined,
      selectedIcon: Icons.emoji_events_rounded,
    ),
  ];

  static int indexForPath(String path) {
    final index = all.indexWhere((d) => d.path == path);
    return index >= 0 ? index : 0;
  }
}
