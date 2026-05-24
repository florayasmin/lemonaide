import 'package:equatable/equatable.dart';

class DashboardTodo extends Equatable {
  const DashboardTodo({
    required this.id,
    required this.label,
    this.isDone = false,
  });

  final String id;
  final String label;
  final bool isDone;

  @override
  List<Object?> get props => [id, label, isDone];
}
