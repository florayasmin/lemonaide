import 'package:equatable/equatable.dart';

/// Domain entity for a single money-in event.
class Earning extends Equatable {
  const Earning({
    required this.id,
    required this.amountCents,
    required this.source,
    required this.earnedAt,
    this.note,
    this.photoUrl,
  });

  final String id;
  final int amountCents;
  final EarningSource source;
  final DateTime earnedAt;
  final String? note;
  final String? photoUrl;

  double get amountDollars => amountCents / 100;

  @override
  List<Object?> get props => [id, amountCents, source, earnedAt, note, photoUrl];
}

enum EarningSource {
  lemonadeStand,
  chores,
  allowance,
  babysitting,
  dogWalking,
  other,
}

extension EarningSourceX on EarningSource {
  String get displayName => switch (this) {
        EarningSource.lemonadeStand => 'Lemonade stand',
        EarningSource.chores => 'Chores',
        EarningSource.allowance => 'Allowance',
        EarningSource.babysitting => 'Babysitting',
        EarningSource.dogWalking => 'Dog walking',
        EarningSource.other => 'Other',
      };
}
