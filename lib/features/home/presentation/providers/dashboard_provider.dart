import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/state/lemonaide_notifier.dart';
import '../../domain/entities/kid_dashboard.dart';

final dashboardProvider = Provider<KidDashboard>((ref) {
  final state = ref.watch(lemonaideProvider);
  return state.toDashboard();
});
