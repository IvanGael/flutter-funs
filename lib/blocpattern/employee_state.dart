// employee_state.dart
import 'package:equatable/equatable.dart';

import 'employee_model.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;

  const EmployeeLoaded({required this.employees});

  @override
  List<Object?> get props => [employees];
}

class EmployeeError extends EmployeeState {}
