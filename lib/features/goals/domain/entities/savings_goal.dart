import 'package:equatable/equatable.dart';

/// Domain entity for a kid's savings target.
class SavingsGoal extends Equatable {
  const SavingsGoal({
    required this.id,
    required this.title,
    required this.targetCents,
    required this.savedCents,
    required this.createdAt,
    this.emoji,
  });

  final String id;
  final String title;
  final int targetCents;
  final int savedCents;
  final DateTime createdAt;
  final String? emoji;

  double get progress =>
      targetCents > 0 ? (savedCents / targetCents).clamp(0.0, 1.0) : 0;

  bool get isComplete => savedCents >= targetCents;

  @override
  List<Object?> get props =>
      [id, title, targetCents, savedCents, createdAt, emoji];
}
