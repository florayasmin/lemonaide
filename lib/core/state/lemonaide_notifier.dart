import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../features/earnings/domain/entities/earning.dart';
import '../../features/goals/domain/entities/savings_goal.dart';
import '../../features/home/data/mock/dashboard_mock_data.dart';
import 'app_state.dart';

const _uuid = Uuid();

class LemonaideNotifier extends StateNotifier<AppState> {
  LemonaideNotifier() : super(_initialState);

  static AppState get _initialState {
    final mock = DashboardMockData.dashboard;
    final earnings = List<Earning>.from(mock.recentEarnings);
    final totalEarned =
        earnings.fold<int>(0, (sum, e) => sum + e.amountCents);

    final latest = earnings.isEmpty
        ? null
        : earnings
            .map((e) => e.earnedAt)
            .reduce((a, b) => a.isAfter(b) ? a : b);

    final initialGoal = mock.activeGoal.copyWith(
      savedCents: totalEarned.clamp(0, mock.activeGoal.targetCents),
    );

    return AppState(
      kidName: mock.kidName,
      earnings: earnings,
      goals: [initialGoal],
      activeGoalId: initialGoal.id,
      cupCapacityCents: mock.cupCapacityCents,
      streakDays: mock.streakDays,
      todos: mock.todos,
      lastEarningDay: latest == null ? null : _dateOnly(latest),
    );
  }

  static DateTime _dateOnly(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);

  void addEarning({
    required int amountCents,
    required EarningSource source,
    String? note,
  }) {
    if (amountCents <= 0) {
      return;
    }

    final now = DateTime.now();
    final today = _dateOnly(now);
    final earning = Earning(
      id: _uuid.v4(),
      amountCents: amountCents,
      source: source,
      earnedAt: now,
      note: note,
    );

    final updatedGoals = state.goals.map((goal) {
      if (goal.id != state.activeGoalId) {
        return goal;
      }
      return goal.copyWith(
        savedCents: (goal.savedCents + amountCents).clamp(0, goal.targetCents),
      );
    }).toList();

    state = state.copyWith(
      earnings: [...state.earnings, earning],
      goals: updatedGoals,
      streakDays: _nextStreak(today),
      lastEarningDay: today,
    );
  }

  void createGoal({
    required String title,
    required int targetCents,
    String? emoji,
  }) {
    final trimmed = title.trim();
    if (trimmed.isEmpty || targetCents <= 0) {
      return;
    }

    final goal = SavingsGoal(
      id: _uuid.v4(),
      title: trimmed,
      targetCents: targetCents,
      savedCents: 0,
      createdAt: DateTime.now(),
      emoji: emoji,
    );

    state = state.copyWith(
      goals: [...state.goals, goal],
      activeGoalId: goal.id,
    );
  }

  void setActiveGoal(String goalId) {
    if (!state.goals.any((g) => g.id == goalId)) {
      return;
    }
    state = state.copyWith(activeGoalId: goalId);
  }

  void deleteGoal(String goalId) {
    if (state.goals.length <= 1) {
      return;
    }

    final remaining = state.goals.where((g) => g.id != goalId).toList();
    final nextActive = state.activeGoalId == goalId
        ? remaining.first.id
        : state.activeGoalId;

    state = state.copyWith(
      goals: remaining,
      activeGoalId: nextActive,
    );
  }

  int _nextStreak(DateTime today) {
    final last = state.lastEarningDay;
    if (last == null) {
      return 1;
    }
    if (_dateOnly(last) == today) {
      return state.streakDays;
    }
    final yesterday = today.subtract(const Duration(days: 1));
    if (_dateOnly(last) == yesterday) {
      return state.streakDays + 1;
    }
    return 1;
  }
}

final lemonaideProvider =
    StateNotifierProvider<LemonaideNotifier, AppState>((ref) {
  return LemonaideNotifier();
});
