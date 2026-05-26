import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/earnings/domain/entities/earning.dart';

/// Pre-selects a source when navigating from home (e.g. Log chore).
final pendingEarningSourceProvider = StateProvider<EarningSource?>(
  (ref) => null,
);
