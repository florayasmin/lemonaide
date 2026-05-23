import '../../domain/entities/earning.dart';

/// Firestore-serializable DTO for [Earning].
class EarningModel {
  const EarningModel({
    required this.id,
    required this.amountCents,
    required this.source,
    required this.earnedAt,
    this.note,
    this.photoUrl,
  });

  final String id;
  final int amountCents;
  final String source;
  final DateTime earnedAt;
  final String? note;
  final String? photoUrl;

  factory EarningModel.fromJson(Map<String, dynamic> json, String id) {
    return EarningModel(
      id: id,
      amountCents: (json['amountCents'] as num).toInt(),
      source: json['source'] as String,
      earnedAt: DateTime.parse(json['earnedAt'] as String),
      note: json['note'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'amountCents': amountCents,
        'source': source,
        'earnedAt': earnedAt.toIso8601String(),
        if (note != null) 'note': note,
        if (photoUrl != null) 'photoUrl': photoUrl,
      };

  Earning toEntity() => Earning(
        id: id,
        amountCents: amountCents,
        source: EarningSource.values.firstWhere(
          (s) => s.name == source,
          orElse: () => EarningSource.other,
        ),
        earnedAt: earnedAt,
        note: note,
        photoUrl: photoUrl,
      );

  factory EarningModel.fromEntity(Earning entity) => EarningModel(
        id: entity.id,
        amountCents: entity.amountCents,
        source: entity.source.name,
        earnedAt: entity.earnedAt,
        note: entity.note,
        photoUrl: entity.photoUrl,
      );
}
