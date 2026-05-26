import 'package:equatable/equatable.dart';

import '../../features/earnings/domain/entities/earning.dart';
import '../../features/goals/domain/entities/savings_goal.dart';
import '../../features/home/domain/entities/dashboard_todo.dart';
import '../../features/home/domain/entities/kid_dashboard.dart';

/// Root app data — earnings and goals stay in sync across the app.
class AppState extends Equatable {
  const AppState({
    required this.kidName,
    required this.earnings,
    required this.goals,
    required this.activeGoalId,
    required this.cupCapacityCents,
    required this.streakDays,
    required this.todos,
    this.lastEarningDay,
  });

  final String kidName;
  final List<Earning> earnings;
  final List<SavingsGoal> goals;
  final String activeGoalId;
  final int cupCapacityCents;
  final int streakDays;
  final List<DashboardTodo> todos;
  final DateTime? lastEarningDay;

  SavingsGoal get activeGoal =>
      goals.firstWhere((g) => g.id == activeGoalId);

  /// Active goal shown on home — [savedCents] is updated when earnings are logged.
  SavingsGoal get goalWithProgress => activeGoal;

  int get totalEarnedCents =>
      earnings.fold(0, (sum, e) => sum + e.amountCents);

  int weekEarnedCents([DateTime? now]) {
    final anchor = now ?? DateTime.now();
    final weekStart = anchor.subtract(const Duration(days: 7));
    return earnings
        .where((e) => !e.earnedAt.isBefore(weekStart))
        .fold(0, (sum, e) => sum + e.amountCents);
  }

  int get currentSavingsCents => totalEarnedCents;

  List<Earning> get recentEarnings {
    final sorted = List<Earning>.from(earnings)
      ..sort((a, b) => b.earnedAt.compareTo(a.earnedAt));
    return sorted.take(8).toList();
  }

  String get mascotMessage {
    final goal = activeGoal;
    if (goal.isComplete) {
      return 'You did it! 🎉 Your ${goal.title} goal is fully funded!';
    }
    if (totalEarnedCents >= 5000) {
      return "You're on fire! 🔥 Keep saving for that ${goal.title}!";
    }
    if (totalEarnedCents >= 1000) {
      return 'Nice work! Every dollar gets you closer to your goal.';
    }
    return 'Log earnings to fill your cup and grow your savings!';
  }

  bool get hasFirstFiveDollars => totalEarnedCents >= 500;
  bool get isSaver => totalEarnedCents >= 2500;
  bool get isBoss => totalEarnedCents >= 5000;

  int get standLevel {
    if (totalEarnedCents >= 10000) return 3;
    if (totalEarnedCents >= 5000) return 2;
    return 1;
  }

  KidDashboard toDashboard() => KidDashboard(
        kidName: kidName,
        totalEarnedCents: totalEarnedCents,
        currentSavingsCents: currentSavingsCents,
        weekEarnedCents: weekEarnedCents(),
        cupCapacityCents: cupCapacityCents,
        streakDays: streakDays,
        activeGoal: goalWithProgress,
        recentEarnings: recentEarnings,
        mascotMessage: mascotMessage,
        todos: todos,
      );

  AppState copyWith({
    String? kidName,
    List<Earning>? earnings,
    List<SavingsGoal>? goals,
    String? activeGoalId,
    int? cupCapacityCents,
    int? streakDays,
    List<DashboardTodo>? todos,
    DateTime? lastEarningDay,
    bool clearLastEarningDay = false,
  }) {
    return AppState(
      kidName: kidName ?? this.kidName,
      earnings: earnings ?? this.earnings,
      goals: goals ?? this.goals,
      activeGoalId: activeGoalId ?? this.activeGoalId,
      cupCapacityCents: cupCapacityCents ?? this.cupCapacityCents,
      streakDays: streakDays ?? this.streakDays,
      todos: todos ?? this.todos,
      lastEarningDay:
          clearLastEarningDay ? null : (lastEarningDay ?? this.lastEarningDay),
    );
  }

  @override
  List<Object?> get props => [
        kidName,
        earnings,
        goals,
        activeGoalId,
        cupCapacityCents,
        streakDays,
        todos,
        lastEarningDay,
      ];
}

extension SavingsGoalCopy on SavingsGoal {
  SavingsGoal copyWith({
    String? id,
    String? title,
    int? targetCents,
    int? savedCents,
    DateTime? createdAt,
    String? emoji,
  }) {
    return SavingsGoal(
      id: id ?? this.id,
      title: title ?? this.title,
      targetCents: targetCents ?? this.targetCents,
      savedCents: savedCents ?? this.savedCents,
      createdAt: createdAt ?? this.createdAt,
      emoji: emoji ?? this.emoji,
    );
  }
}
