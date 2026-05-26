import 'package:flutter_test/flutter_test.dart';
import 'package:lemonaide/core/state/lemonaide_notifier.dart';
import 'package:lemonaide/features/earnings/domain/entities/earning.dart';

void main() {
  test('addEarning updates totals and active goal progress', () {
    final notifier = LemonaideNotifier();
    final beforeTotal = notifier.state.totalEarnedCents;
    final beforeSaved = notifier.state.activeGoal.savedCents;

    notifier.addEarning(
      amountCents: 250,
      source: EarningSource.chores,
    );

    final after = notifier.state;
    expect(after.totalEarnedCents, beforeTotal + 250);
    expect(after.currentSavingsCents, beforeTotal + 250);
    expect(after.activeGoal.savedCents, beforeSaved + 250);
    expect(after.earnings.last.amountCents, 250);
  });

  test('createGoal adds goal and sets it active', () {
    final notifier = LemonaideNotifier();
    final countBefore = notifier.state.goals.length;

    notifier.createGoal(
      title: 'Video game',
      targetCents: 6000,
      emoji: '🎮',
    );

    final after = notifier.state;
    expect(after.goals.length, countBefore + 1);
    expect(after.activeGoal.title, 'Video game');
    expect(after.activeGoal.targetCents, 6000);
    expect(after.activeGoal.savedCents, 0);
    expect(after.activeGoal.emoji, '🎮');
  });

  test('setActiveGoal switches home goal', () {
    final notifier = LemonaideNotifier();
    notifier.createGoal(title: 'Skateboard', targetCents: 8000, emoji: '🛼');
    final skateId = notifier.state.activeGoalId;

    final firstGoalId = notifier.state.goals.first.id;
    notifier.setActiveGoal(firstGoalId);

    expect(notifier.state.activeGoalId, firstGoalId);
    expect(notifier.state.activeGoal.id, isNot(skateId));
  });
}
