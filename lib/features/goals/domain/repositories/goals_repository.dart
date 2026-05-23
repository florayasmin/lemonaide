import '../entities/savings_goal.dart';

/// Contract for savings goals persistence.
abstract class GoalsRepository {
  Stream<List<SavingsGoal>> watchGoals(String userId);

  Future<void> upsertGoal(String userId, SavingsGoal goal);

  Future<void> deleteGoal(String userId, String goalId);
}
