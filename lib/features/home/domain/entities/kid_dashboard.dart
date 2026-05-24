import 'package:equatable/equatable.dart';

import '../../../earnings/domain/entities/earning.dart';
import '../../../goals/domain/entities/savings_goal.dart';
import 'dashboard_todo.dart';

/// Aggregated snapshot for the home dashboard.
class KidDashboard extends Equatable {
  const KidDashboard({
    required this.kidName,
    required this.totalEarnedCents,
    required this.currentSavingsCents,
    required this.weekEarnedCents,
    required this.cupCapacityCents,
    required this.streakDays,
    required this.activeGoal,
    required this.recentEarnings,
    required this.mascotMessage,
    required this.todos,
  });

  final String kidName;
  final int totalEarnedCents;
  final int currentSavingsCents;
  final int weekEarnedCents;

  /// Max earnings shown as a full cup ($100 default in mock data).
  final int cupCapacityCents;
  final int streakDays;
  final SavingsGoal activeGoal;
  final List<Earning> recentEarnings;
  final String mascotMessage;
  final List<DashboardTodo> todos;

  double get cupFill =>
      cupCapacityCents > 0
          ? (totalEarnedCents / cupCapacityCents).clamp(0.0, 1.0)
          : 0;

  @override
  List<Object?> get props => [
        kidName,
        totalEarnedCents,
        currentSavingsCents,
        weekEarnedCents,
        cupCapacityCents,
        streakDays,
        activeGoal,
        recentEarnings,
        mascotMessage,
        todos,
      ];
}
