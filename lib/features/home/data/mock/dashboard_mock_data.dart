import '../../../earnings/domain/entities/earning.dart';
import '../../../goals/domain/entities/savings_goal.dart';
import '../../domain/entities/dashboard_todo.dart';
import '../../domain/entities/kid_dashboard.dart';

/// Mock dashboard data for MVP development.
abstract final class DashboardMockData {
  static final _goalCreatedAt = DateTime(2026, 4, 1);

  static final _activeGoal = SavingsGoal(
    id: 'goal-1',
    title: 'New bike',
    targetCents: 12000,
    savedCents: 4750,
    createdAt: _goalCreatedAt,
    emoji: '🚲',
  );

  static final KidDashboard dashboard = KidDashboard(
    kidName: 'Alex',
    totalEarnedCents: 6850,
    currentSavingsCents: 4750,
    weekEarnedCents: 2700,
    cupCapacityCents: 10000,
    streakDays: 5,
    activeGoal: _activeGoal,
    mascotMessage: "You're on fire! 🔥 Keep saving for that bike!",
    todos: const [
      DashboardTodo(id: 't-1', label: 'Clean room'),
      DashboardTodo(id: 't-2', label: 'Set up your store'),
    ],
    recentEarnings: [
      Earning(
        id: 'e-1',
        amountCents: 1200,
        source: EarningSource.lemonadeStand,
        earnedAt: DateTime(2026, 5, 23, 10, 30),
        note: 'Busy Saturday!',
      ),
      Earning(
        id: 'e-2',
        amountCents: 500,
        source: EarningSource.chores,
        earnedAt: DateTime(2026, 5, 22, 17, 0),
        note: 'Dishes & trash',
      ),
      Earning(
        id: 'e-3',
        amountCents: 1000,
        source: EarningSource.allowance,
        earnedAt: DateTime(2026, 5, 20, 9, 0),
      ),
      Earning(
        id: 'e-4',
        amountCents: 750,
        source: EarningSource.dogWalking,
        earnedAt: DateTime(2026, 5, 18, 16, 45),
        note: 'Walked Max',
      ),
    ],
  );
}
