import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock/dashboard_mock_data.dart';
import '../../domain/entities/kid_dashboard.dart';

final dashboardProvider = Provider<KidDashboard>(
  (ref) => DashboardMockData.dashboard,
);
