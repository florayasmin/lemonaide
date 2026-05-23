import '../entities/earning.dart';

/// Contract for earnings persistence (Firestore implementation later).
abstract class EarningsRepository {
  Stream<List<Earning>> watchEarnings(String userId);

  Future<void> addEarning(String userId, Earning earning);

  Future<void> deleteEarning(String userId, String earningId);
}
