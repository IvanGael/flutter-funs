// employee_bloc.dart

import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

import 'employee_event.dart';
import 'employee_repository.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;

  EmployeeBloc({required this.employeeRepository}) : super(EmployeeLoading()) {
    on<LoadEmployees>((event, emit) {
      _mapLoadEmployeesToState(event, emit);
    });
  }

  void _mapLoadEmployeesToState(LoadEmployees event, Emitter<EmployeeState> emit) async {
    try {
      final employees = employeeRepository.getEmployees();
      emit(EmployeeLoaded(employees: employees));
    } catch (_) {
      emit(EmployeeError());
    }
  }
  
  @override
  Stream<EmployeeState> mapEventToState(
    EmployeeEvent event,
  ) async* {}
}
